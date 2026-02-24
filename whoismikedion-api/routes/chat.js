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
const claudeService = require('../services/claude');
const contextBuilder = require('../services/context-builder');

const CONFIG = {
  // Maximum conversation history to send to Claude
  maxHistoryMessages: 10,
  
  // Fallback response if AI fails
  fallbackResponse: "I apologize, but I'm having trouble generating a response right now. Please try again in a moment, or feel free to explore Mike's profile and stories pages to learn more about his experience."
};


router.post('/', async (req, res) => {
    try {
        const { session_id, message } = req.body;

        if(!message || message.trim().length === 0) {
            return res.status(400).json({
                error: 'Message cannot be empty',
                details: 'Please provide a valid message to send'
            });
            
        }

        const userMessage = message.trim();

        let sessionDbId;
        let sessionUuid;
        let isNewSession = false;
        let conversationHistory = [];

        if (session_id) {
            const [sessions] = await db.query(
                'SELECT id, session_id FROM chat_sessions WHERE session_id = ?',
                [session_id]
            );

            if (sessions.length === 0) {
                return res.status(404).json({
                    error: 'Session not found',
                    details: 'No chat session found with that ID'
                });
            }

            sessionDbId = sessions[0].id;
            sessionUuid = sessions[0].session_id;

            const [history] = await db.query(
                `SELECT role, content FROM chat_messages
                WHERE session_id = ?
                ORDER BY created_at DESC
                LIMIT ?`,
                [sessionDbId, CONFIG.maxHistoryMessages]
            );

            // Reverse to get chronological order (oldest first) for Claude
            conversationHistory = history.reverse();

        } else {
            sessionUuid = uuidv4();
            const [result] = await db.query(
                'INSERT INTO chat_sessions (session_id) VALUES (?)',
                [sessionUuid]
            );
            sessionDbId = result.insertId;
            isNewSession = true;
        }

        const { context, metadata: contextMetadata } = await contextBuilder.buildContext(userMessage, conversationHistory);

        // Debug logging for production issues
        console.log('Context build result:', {
            contextLength: context.length,
            hasError: !!contextMetadata.error,
            metadata: contextMetadata
        });
        console.log('Context preview (first 500 chars):', context.substring(0, 500));

        let assistantReponse;
        let aiMetadata = {};
        let systemPromptUsed = null;

        try {
            const aiResult = await claudeService.generateResponse({
                userMessage,
                conversationHistory,
                context
            });

            assistantReponse = aiResult.response;
            systemPromptUsed = aiResult.systemPromptUsed;
            console.log('System prompt length:', systemPromptUsed?.length || 0);
            aiMetadata = {
                model: aiResult.model,
                usage: aiResult.usage,
                stopReason: aiResult.stopReason
            };
        } catch (aiError) {
            console.error('AI response error:', aiError);
            assistantReponse = CONFIG.fallbackResponse;

            aiMetadata = {
                error: aiError.message,
                usedFallback: true
            };
        }

        const contextUsed = JSON.stringify({
            keywords: contextMetadata.keywords,
            skillsFound: contextMetadata.skillsFound,
            storiesFound: contextMetadata.storiesFound,
            storiesAreFallback: contextMetadata.storiesAreFallback,
            includesWeaknesses: contextMetadata.includesWeaknesses,
            ...aiMetadata
        });

        const [userMsgResult] = await db.query(
            'INSERT INTO chat_messages (session_id, role, content) VALUES (?, ?, ?)',
            [sessionDbId, 'user', userMessage]
        );

        const [assistantMsgResult] = await db.query(
            'INSERT INTO chat_messages (session_id, role, content, context_used, system_prompt_used) VALUES (?, ?, ?, ?, ?)',
            [sessionDbId, 'assistant', assistantReponse, contextUsed, systemPromptUsed]
        );

        await db.query(
            'UPDATE chat_sessions SET message_count = message_count + 2 WHERE id = ?',
            [sessionDbId]
        );

        const [newMessages] = await db.query(
            `SELECT id, role, content, created_at
            FROM chat_messages
            WHERE id IN (?, ?)
            ORDER BY created_at ASC`,
            [userMsgResult.insertId, assistantMsgResult.insertId]
        );

        res.json({
            session_id: sessionUuid,
            messages: newMessages,
            is_new_session: isNewSession,
            metadata: {
                keywords: contextMetadata.keywords,
                skillsFound: contextMetadata.skillsFound,
                storiesFound: contextMetadata.storiesFound,
                storiesAreFallback: contextMetadata.storiesAreFallback,
            }
        });
    } catch (error) {
        console.error('Chat POST error:', error);
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
            'SELECT id, session_id, started_at, message_count, cleared_at FROM chat_sessions WHERE session_id = ?',
            [session_id]
        );

        if (sessions.length === 0) {
            return res.status(404).json({
                error: 'Session not found',
                details: 'No chat session found with that ID'
            });
        }

        // Don't return cleared sessions - treat as not found
        if (sessions[0].cleared_at) {
            return res.status(404).json({
                error: 'Session not found',
                details: 'This chat session has been cleared'
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
 * Mark a chat session as cleared (preserves data for admin review).
 * Used for "Clear Conversation" feature.
 *
 * Instead of deleting, we set cleared_at timestamp so the session
 * can no longer be loaded by the user, but data remains in the database.
 */

router.delete('/:session_id', async (req, res) => {
    try {
        const { session_id } = req.params;

        const [result] = await db.query(
            'UPDATE chat_sessions SET cleared_at = NOW() WHERE session_id = ? AND cleared_at IS NULL',
            [session_id]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({
                error: 'Session not found or already cleared',
            });
        }

        res.json({
            success: true,
            message: `Chat session cleared`
        });
    } catch (error) {
        console.error('Clear session error:', error);
        res.status(500).json({
            error: 'Failed to clear chat session'
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