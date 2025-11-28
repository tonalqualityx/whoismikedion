/**
 * Chat API Routes
 * 
 * Handles chat session management and message storage.
 * Currently uses echo responses - Claude AI integration comes in Phase 6.
 * 
 * Endpoints:
 * - POST /api/chat - Send message and get response
 * - GET /api/chat/:session_id - Get all messages for a session
 * - GET /api/chat/:session_id/transcript - Download conversation transcript
 */

const express = require('express');
const router = express.Router();
const { v4: uuidv4 } = require('uuid');

const db = require('../db/connection');

/**
 * POST /api/chat
 * 
 * Send a message and receive a response.
 * Creates new session if session_id not provided.
 * 
 * Request body:
 * {
 *   "session_id": "uuid-string" (optional),
 *   "message": "user's message"
 * }
 * 
 * Response:
 * {
 *   "session_id": "uuid-string",
 *   "messages": [...],
 *   "is_new_session": boolean
 * }
 */

router.post('/', async (req, res) => {
    try {
        const { session_id, message } = req.body;

        if(!message || typeof message !== 'string' || message.trim() === '') {
            return res.status(400).json({
                error: 'Message is required',
                details: 'Please provide a non-empty message.'
            });
        }

        const cleanMessage = message.trim();

        // =================================
        // GET OR CREATE CHAT SESSION
        // =================================
        let sessionInternalId;
        let sessionUUID;
        let isNewSesssion = false;

        if (session_id) {

            const [sessions] = await db.query(
                'SELECT id, session_id FROM chat_sessions WHERE session_id = ?',
                [session_id]
            );

            if ( sessions.length === 0 ) {
                return res.status(404).json({
                    error: 'Session not found',
                    details: `No chat session found with ID ${session_id}`
                });
            }

            sessionInternalId = sessions[0].id;
            sessionUUID = sessions[0].session_id;
            
        } else {

            sessionUUID = uuidv4();
            isNewSesssion = true;

            const [result] = await db.query(
                'INSERT INTO chat_sessions (session_id, message_count) VALUES (?, 0)',
                [sessionUUID]
            );

            sessionInternalId = result.insertId;

            console.log(`Created new chat session: ${sessionUUID}`);
        }

        // =================================
        // STORE USER MESSAGE
        // =================================

        const [userMessageResult] = await db.query(
            `INSERT INTO chat_messages (session_id, role, content)
            VALUES (?, 'user', ?)`,
            [sessionInternalId, cleanMessage]
        );

        const userMessageId = userMessageResult.insertId;

        // =================================
        // ECHO BOT RESPONSE (Placeholder for Claude AI integration)
        // =================================

        const assistantResponse = generateEchoResponse(cleanMessage);

        // =================================
        // STORE ASSISTANT MESSAGE
        // =================================

        const [assistantMessageResult] = await db.query(
            `INSERT INTO chat_messages (session_id, role, content, context_used)
            VALUES (?, 'assistant', ?, ?)`,
            [sessionInternalId, assistantResponse, JSON.stringify({ type: 'echo' })]
        );

        const assistantMessageId = assistantMessageResult.insertId;

        // =================================
        // UPDATE MESSAGE COUNT
        // =================================

        await db.query(
            `UPDATE chat_sessions SET message_count = message_count + 2 WHERE id = ?`,
            [sessionInternalId]
        );

        // =================================
        // FETCH NEW MESSAGES TO RETURN
        // =================================

        const [newMessages] = await db.query(
            `SELECT id, role, content, created_at
            FROM chat_messages
            WHERE id IN (?, ?)
            ORDER BY created_at ASC`,
            [userMessageId, assistantMessageId]
        );

        // =================================
        // RESPOND TO CLIENT
        // =================================

        res.json({
            session_id: sessionUUID,
            messages: newMessages,
            is_new_session: isNewSesssion
        });
    } catch (error) {

        console.error('Chat error:', error);
        res.status(500).json({
            error: 'Failed to process chat message',
            details: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }

});

/**
 * GET /api/chat/:session_id
 * 
 * Retrieve all messages for a session.
 * Used when loading chat page with existing session.
 */

router.get('/:session_id', async (req, res) => {
    try {
        const { session_id } = req.params;

        // ===============================
        // VERIFY SESSION EXISTS
        // ===============================

        const [sessions] = await db.query(
            'SELECT id, session_id, started_at, message_count FROM chat_sessions WHERE session_id = ?',
            [session_id]
        );

        if (sessions.length === 0) {
            return res.status(404).json({
                error: 'Session not found',
                details: 'No chat session found with that ID'
            });
        }

        const session = sessions[0];
        
        // ===============================
        // GET ALL MESSAGES FOR SESSION
        // ===============================

        const [messages] = await db.query(
            `SELECT id, role, content, created_at
            FROM chat_messages
            WHERE session_id = ?
            ORDER BY created_at ASC`,
            [session.id]
        );

        // ===============================
        // RETURN SESSION DATA
        // ===============================

        res.json({
            session_id: session.session_id,
            started_at: session.started_at,
            message_count: session.message_count,
            messages: messages
        });
    } catch (error) {
        console.error('Get session error:', error);
        res.status(500).json({
            error: 'Failed to retrieve chat session',
            details: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
});

/**
 * GET /api/chat/:session_id/transcript
 * 
 * Download conversation as plain text transcript.
 * Returns text/plain content type for file download.
 */

router.get('/:session_id/transcript', async (req, res) => {
    try {
        const { session_id } = req.params;

        const [sessions] = await db.query(
            'SELECT id, session_id FROM chat_sessions WHERE session_id = ?',
            [session_id]
        );

        if( sessions.length === 0 ) {
            return res.status(404).json({
                error: 'Session not found',
            });
        }

        const session = sessions[0];

        const [messages] = await db.query(
            `SELECT role, content, created_at
            FROM chat_messages
            WHERE session_id = ?
            ORDER BY created_at ASC`,
            [session.id]
        );

        const transcript = formatTranscript(messages, session.started_at);

        // Set headers for file download
        res.setHeader('Content-Type', 'text/plain');
        res.setHeader('content-disposition', `attachment; filename="chat-transcript-${session_id.slice(0, 8)}.txt"`);

        res.send(transcript);
    } catch (error) {
        console.error('Transcript error:', error);
        res.status(500).json({
            error: 'Failed to generate transcript',
            details: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
});

/**
 * DELETE /api/chat/:session_id
 * 
 * Delete a chat session and all its messages.
 * Used for "Clear Conversation" feature.
 */

router.delete('/:session_id', async (req, res) => {
    try {
        const { session_id } = req.params;

        const [result] = await db.query(
            'DELETE FROM chat_sessions WHERE session_id = ?',
            [session_id]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({
                errro: 'Session not found',
            });
        }

        res.json({
            success: true,
            message: `Chat session deleted`
        });
    } catch (error) {
        console.error('Delete session error:', error);
        res.status(500).json({
            error: 'Failed to delete chat session'
        });
    }
});

// =============================================
// HELPER FUNCTIONS
// =============================================

function generateEchoResponse(userMessage) {

    const responses = [
        `I heard you say: "${userMessage}"`,
        `That's interesting! You said: "${userMessage}"`,
        `You mentioned: "${userMessage}". Tell me more!`
    ];

    const randomIndex = Math.floor(Math.random() * responses.length);

    return responses[randomIndex];
}

/**
 * Format messages as plain text transcript
 */
function formatTranscript(messages, startedAt) {
    const header = `
Chat Transcript - Who Is Mike Dion
==================================

Started: ${new Date(startedAt).toLocaleString()}
Messages: ${messages.length}

==================================

`;

    const body = messages.map(msg => {
        const timestamp = new Date(msg.created_at).toLocaleString();
        const speaker = msg.role === 'user' ? 'You' : 'Mike (AI)';
        return `[${timestamp}] ${speaker}:\n${msg.content}\n`;
    }).join('\n');

    const footer = `
==================================
End of Transcript
Generated ${new Date().toLocaleString()}
`;

    return header + body + footer;
}

module.exports = router;