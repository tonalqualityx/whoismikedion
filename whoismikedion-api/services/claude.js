/**
 * Claude AI Service
 * 
 * Handles all interactions with the Claude API.
 * Provides a clean interface for generating responses
 * with context from your portfolio database.
 * 
 * Services/claude.js
 */

const Anthropic = require('@anthropic-ai/sdk');

// Initialize the client

const anthropic = new Anthropic.Anthropic({
    apiKey: process.env.CLAUDE_API_KEY,
});

// Config

const CONFIG = {
    model: 'claude-sonnet-4-20250514',
    maxTokens: 1024,
    temperature: 0.7,
};

// System Prompt
const SYSTEM_PROMPT = `You are an AI assistant representing Mike Dion's professional portfolio. Your role is to help potential employers and collaborators learn about Mike's experience, skills, and fit for roles they're considering.

## Your Personality
- Warm but professional
- Honest and direct—help people assess mutual fit, even if that means acknowledging limitations
- Knowledgeable about Mike's background from the context provided
- Thoughtful and systems-oriented in explanations

## Core Principles
1. **Context-Aware Honesty**: Only make claims supported by the context provided. If asked about something not in your context, say you don't have specific information about that. Encourage the user to reach out to the real Mike for more details.

2. **Mutual Fit Focus**: Help employers determine if Mike is right for their needs. It's better to help someone realize Mike isn't a fit than to oversell. Do this with extreme caution and tact, we also don't want to turn away good opportunities because the context for a fit isn't there. Be sure to word things carefully to reflect YOUR CONTEXT and not make assumptions about the employer's needs beyond what they share with you, or Mike's abilities beyond what is available from data in this project.

3. **Bridge-Building**: Mike's core value is connecting communities and supporting vulnerable populations through technology. This should come through in how you discuss his work.

4. **Technical + Human**: Mike combines technical skills with human-centered design. Emphasize both aspects.

## Response Guidelines
- Reference specific stories and accomplishments from the context when relevant
- Be concise but thorough—respect the interviewer's time
- If asked about weaknesses or gaps, be honest (Mike has provided that information)
- Don't invent details not in the context
- When uncertain, acknowledge it

## What You Know
You have access to:
- Mike's skills and proficiency levels
- Success stories with specific outcomes
- Work history and timeline
- Core values and motivations
- Areas for growth/weaknesses

Remember: You're helping both Mike AND the employer find the right fit. Honesty serves everyone.`;

// Completion function'

/**
 * Generate a response from Claude using the provided context.
 * 
 * @param {Object} options - Completion options
 * @param {string} options.userMessage - The user's current message
 * @param {Array} options.conversationHistory - Previous messages in format [{role, content}]
 * @param {string} options.context - Retrieved context from database (skills, stories, etc.)
 * @returns {Promise<Object>} - { response: string, usage: { inputTokens, outputTokens } }
 */

async function generateResponse({ userMessage, conversationHistory = [], context = '' }) {
    try {
        const fullSystemPrompt = context
            ? `${SYSTEM_PROMPT}\n\n## Context About Mike\n${context}`
            : SYSTEM_PROMPT;

        const messages = [
            ...conversationHistory,
            {role: 'user', content: userMessage}
        ];
        
        // Call Claude
        const response = await anthropic.messages.create({
            model: CONFIG.model,
            max_tokens: CONFIG.maxTokens,
            temperature: CONFIG.temperature,
            system: fullSystemPrompt,
            messages: messages
        });

        const assistantMessage = response.content[0].text;

        return {
            response: assistantMessage,
            usage: {
                inputTokens: response.usage.input_tokens,
                outputTokens: response.usage.output_tokens,
                totalTokens: response.usage.input_tokens + response.usage.output_tokens
            },
            model: response.model,
            stopReason: response.stop_reason
        };
    } catch (error) {
        if(error.status === 401) {
            throw new Error('Invalid Claude API Key');
        }
        if(error.status === 429) {
            throw new Error('Claude API Rate Limit Exceeded');
        }
        if(error.status >= 500) {
            throw new Error('Claude API Server Error');
        }
        throw new Error(`Claude API Error: ${error.message}`);
    }
}

// Health Check
async function healthCheck() {
    try {
        response = await anthropic.messages.create({
            model: CONFIG.model,
            max_tokens: 50,
            messages: [{role: 'user', content: 'Say "API connected!" and nothing else.'}]
        });

        return {
            status: 'healthy',
            model: response.model,
            message: response.content[0].text
        };
    } catch (error) {
        return {
            status: 'unhealthy',
            error: error.message
        };
    }
}

// Exports
module.exports = {
    generateResponse,
    healthCheck,
    CONFIG,
    SYSTEM_PROMPT
};