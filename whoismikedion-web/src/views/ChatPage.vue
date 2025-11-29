<template>
    <div class="chat-page">

        <!-- HEADER -->
        <div class="chat-header">
            <h1>Chat with Mike's Digital Projection</h1>
            <p class="chat-intro">
                Ask me about my experience, skills, or anything else you'd like to know. I'm here to help you determine if we'd be a good fit for each other.
            </p>
        </div>

        <!-- MESSAGE CONTAINER -->
        <div class="messages-container" ref="messagesContainer">

            <!-- LOADING STATE -->
            <div v-if="loading" class="loading-state">
                <p>Loading conversation...</p>
            </div>

            <!-- EMPTY STATE -->
            <div v-else-if="messages.length === 0" class="empty-state">
                <p>No messages yet. Start a conversation!</p>

                <div class="seuggested-questions">
                    <h3>Try asking:</h3>
                    <button
                        v-for="question in suggestedQuestions"
                        :key="question"
                        class="suggested-question"
                        @click="sendSuggestedQuestion(question)"
                    >
                        {{ question }}
                    </button>
                </div>
            </div>

            <!-- MESAGES LIST -->
            <div v-else class="messages-list">
                <div
                    v-for="message in messages"
                    :key="message.id"
                    :class="['message', message.role]"
                >
                    <!-- AVATAR -->
                    <div class="message-avatar">
                        <span v-if="message.role === 'user'" class="user-icon">You</span>
                        <span v-else class="assistant-icon">Mike</span>
                    </div>

                    <!-- Content -->
                    <div class="message-content">
                        <p>{{  message.content }}</p>
                        <span class="message-time">
                            {{ formatTime(message.created_at) }}
                        </span>
                    </div>
                </div>

                <!-- TYPING INDICATOR -->
                <div v-if="sending" class="message assistant typing">
                    <div class="message-avatar">
                        <span class="assistant-icon">Mike</span>
                    </div>
                    <div class="message-content">
                        <div class="typing-indicator">
                            <span></span>
                            <span></span>
                            <span></span>
                        </div>
                    </div>
                </div>

            </div> <!-- .messages-list -->

        </div> <!-- .messages-container -->

        <!-- INPUT FORM -->
        <form class="chat-input-form" @submit.prevent="handleSubmit">
            <input
                v-model="newMessage"
                type="text"
                placeholder="Type your message..."
                :disabled="sending"
                class="message-input"
                ref="messageInput"
            >
            <button
                type="submit"
                class="send-button"
                :disabled="!newMessage.trim() || sending"
            >
                {{ sending ? 'Sending...' : 'Send' }}
            </button>
        </form>

        <!-- SESSION Actions -->
        <div class="chat-actions">
            <button
                v-if="sessionId && messages.length > 0"
                @click="downloadTranscript"
                class="action-button"
            >
                Download Transcript
            </button>
            <button
                v-if="sessionId && messages.length > 0"
                @click="confirmClearChat"
                class="action-button danger"
            >
                Clear Chat
            </button>
        </div>

        <!-- ERROR DISPLAY -->
        <div v-if="error" class="error-message">
            <p>{{ error }}</p>
            <button @click="error = null">Dismiss</button>
        </div>
    </div>
</template>

<script>

import { ref, onMounted, nextTick, watch } from 'vue';
import axios from 'axios';

export default {
    name: 'ChatPage',
    
    setup() {
        // =========================================
        // REACTIVE STATE
        // =========================================
        
        // Message input
        const newMessage = ref('');
        
        // Messages array
        const messages = ref([]);
        
        // Session ID (will be stored in localStorage)
        const sessionId = ref(null);
        
        // Loading states
        const loading = ref(true);
        const sending = ref(false);
        
        // Error state
        const error = ref(null);
        
        // Template refs (for DOM access)
        const messagesContainer = ref(null);
        const messageInput = ref(null);
        
        // Suggested starter questions
        const suggestedQuestions = [
        "What's your experience with product strategy?",
        "Tell me about a challenging project you've worked on.",
        "What technologies are you most proficient in?",
        "What are you looking for in your next role?"
        ];

        // =========================================
        // API BASE URL
        // =========================================
        const API_BASE = 'http://localhost:3000/api';

        // =========================================
        // LIFECYCLE
        // =========================================
        
        onMounted(async () => {
        // Check for existing session in localStorage
        const storedSessionId = localStorage.getItem('chat_session_id');
        
        if (storedSessionId) {
            // Load existing session
            await loadSession(storedSessionId);
        } else {
            // No existing session - ready for new chat
            loading.value = false;
        }
        
        // Focus the input
        if (messageInput.value) {
            messageInput.value.focus();
        }
        });

        // =========================================
        // METHODS
        // =========================================
        
        /**
         * Load existing session messages
         */
        async function loadSession(existingSessionId) {
        try {
            const response = await axios.get(`${API_BASE}/chat/${existingSessionId}`);
            
            sessionId.value = response.data.session_id;
            messages.value = response.data.messages;
            
            // Session exists and loaded
            loading.value = false;
            
            // Scroll to bottom after messages load
            await nextTick();
            scrollToBottom();
            
        } catch (err) {
            console.error('Failed to load session:', err);
            
            // Session might have been deleted - clear localStorage and start fresh
            localStorage.removeItem('chat_session_id');
            sessionId.value = null;
            messages.value = [];
            loading.value = false;
        }
        }

        /**
         * Handle form submission - send message
         */
        async function handleSubmit() {
        // Don't submit empty messages
        if (!newMessage.value.trim()) return;

        // Don't submit while already sending
        if (sending.value) return;

        const messageText = newMessage.value.trim();
        newMessage.value = '';  // Clear input immediately for UX

        // Create temporary user message and show it immediately
        const tempUserMessage = {
            id: `temp-${Date.now()}`,
            role: 'user',
            content: messageText,
            created_at: new Date().toISOString()
        };
        messages.value.push(tempUserMessage);

        // Scroll to show user message
        await nextTick();
        scrollToBottom();

        // Start loading indicator, then scroll again to show it
        sending.value = true;
        error.value = null;
        await nextTick();
        scrollToBottom();

        try {
            // Build request body
            const requestBody = {
            message: messageText
            };

            // Include session ID if we have one
            if (sessionId.value) {
            requestBody.session_id = sessionId.value;
            }

            // Send to API
            const response = await axios.post(`${API_BASE}/chat`, requestBody);

            // Update session ID (important for new sessions)
            if (response.data.is_new_session) {
            sessionId.value = response.data.session_id;
            localStorage.setItem('chat_session_id', response.data.session_id);
            }

            // Update temp user message with real server data, add assistant message
            const serverMessages = response.data.messages;
            const userMsg = serverMessages.find(m => m.role === 'user');
            const assistantMsg = serverMessages.find(m => m.role === 'assistant');

            // Replace temp message with server version
            const tempIndex = messages.value.findIndex(m => m.id === tempUserMessage.id);
            if (tempIndex !== -1 && userMsg) {
                messages.value[tempIndex] = userMsg;
            }

            // Add assistant message
            if (assistantMsg) {
                messages.value.push(assistantMsg);
            }

            // Scroll to bottom to show assistant response
            await nextTick();
            scrollToBottom();

        } catch (err) {
            console.error('Failed to send message:', err);
            error.value = 'Failed to send message. Please try again.';

            // Remove the optimistic user message
            const tempIndex = messages.value.findIndex(m => m.id === tempUserMessage.id);
            if (tempIndex !== -1) {
                messages.value.splice(tempIndex, 1);
            }

            // Restore the message so user doesn't lose it
            newMessage.value = messageText;
        } finally {
            sending.value = false;

            // Refocus the input
            if (messageInput.value) {
            messageInput.value.focus();
            }
        }
        }

        /**
         * Send a suggested question
         */
        function sendSuggestedQuestion(question) {
        newMessage.value = question;
        handleSubmit();
        }

        /**
         * Scroll messages container to bottom
         */
        function scrollToBottom() {
        if (messagesContainer.value) {
            messagesContainer.value.scrollTop = messagesContainer.value.scrollHeight;
        }
        }

        /**
         * Format timestamp for display
         */
        function formatTime(timestamp) {
        if (!timestamp) return '';
        
        const date = new Date(timestamp);
        return date.toLocaleTimeString([], { 
            hour: '2-digit', 
            minute: '2-digit' 
        });
        }

        /**
         * Download chat transcript
         */
        function downloadTranscript() {
        if (!sessionId.value) return;
        
        // Open transcript URL in new tab (triggers download)
        window.open(`${API_BASE}/chat/${sessionId.value}/transcript`, '_blank');
        }

        /**
         * Confirm and clear chat
         */
        async function confirmClearChat() {
        const confirmed = window.confirm(
            'Are you sure you want to clear this conversation? This cannot be undone.'
        );
        
        if (!confirmed) return;

        try {
            await axios.delete(`${API_BASE}/chat/${sessionId.value}`);
            
            // Clear local state
            messages.value = [];
            sessionId.value = null;
            localStorage.removeItem('chat_session_id');
            
        } catch (err) {
            console.error('Failed to clear chat:', err);
            error.value = 'Failed to clear chat. Please try again.';
        }
        }

        // =========================================
        // WATCH FOR AUTO-SCROLL
        // =========================================
        
        // Scroll to bottom whenever messages change
        watch(messages, async () => {
        await nextTick();
        scrollToBottom();
        }, { deep: true });

        // =========================================
        // RETURN FOR TEMPLATE
        // =========================================
        
        return {
        // State
        newMessage,
        messages,
        sessionId,
        loading,
        sending,
        error,
        suggestedQuestions,
        
        // Refs
        messagesContainer,
        messageInput,
        
        // Methods
        handleSubmit,
        sendSuggestedQuestion,
        formatTime,
        downloadTranscript,
        confirmClearChat
        };
    }
};
</script>



<style scoped>
/* =========================================
   PAGE LAYOUT
   ========================================= */

.chat-page {
  display: flex;
  flex-direction: column;
  height: calc(100vh - 80px);  /* Subtract navbar height */
  max-width: 800px;
  margin: 0 auto;
  padding: var(--spacing-md);
}

/* =========================================
   HEADER
   ========================================= */

.chat-header {
  text-align: center;
  padding: var(--spacing-lg) 0;
  border-bottom: 1px solid var(--color-border);
  margin-bottom: var(--spacing-md);
}

.chat-header h1 {
  color: var(--color-primary);
  margin-bottom: var(--spacing-sm);
}

.chat-intro {
  color: var(--color-text-secondary);
  font-size: 0.9rem;
  max-width: 500px;
  margin: 0 auto;
}

/* =========================================
   MESSAGES CONTAINER
   ========================================= */

.messages-container {
  flex: 1;
  overflow-y: auto;
  padding: var(--spacing-md);
  background-color: var(--color-bg-secondary);
  border-radius: var(--radius-lg);
  margin-bottom: var(--spacing-md);
}

/* =========================================
   LOADING & EMPTY STATES
   ========================================= */

.loading-state,
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  color: var(--color-text-secondary);
}

.suggested-questions {
  margin-top: var(--spacing-xl);
  text-align: center;
}

.suggested-questions h3 {
  color: var(--color-text-primary);
  font-size: 1rem;
  margin-bottom: var(--spacing-md);
}

.suggested-question {
  display: block;
  width: 100%;
  max-width: 400px;
  margin: var(--spacing-sm) auto;
  padding: var(--spacing-sm) var(--spacing-md);
  background-color: var(--color-bg-primary);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  color: var(--color-secondary);
  cursor: pointer;
  transition: all var(--transition-base);
}

.suggested-question:hover {
  border-color: var(--color-accent-amber);
  color: var(--color-accent-amber);
}

/* =========================================
   MESSAGES LIST
   ========================================= */

.messages-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-md);
}

.message {
  display: flex;
  gap: var(--spacing-sm);
  max-width: 85%;
}

.message.user {
  flex-direction: row-reverse;
  margin-left: auto;
}

.message.assistant {
  margin-right: auto;
}

/* =========================================
   MESSAGE AVATAR
   ========================================= */

.message-avatar {
  flex-shrink: 0;
}

.user-icon,
.assistant-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  border-radius: var(--radius-full);
  font-size: 0.75rem;
  font-weight: 600;
}

.user-icon {
  background-color: var(--color-accent-coral);
  color: white;
}

.assistant-icon {
  background-color: var(--color-primary);
  color: white;
}

/* =========================================
   MESSAGE CONTENT
   ========================================= */

.message-content {
  padding: var(--spacing-sm) var(--spacing-md);
  border-radius: var(--radius-lg);
  background-color: var(--color-bg-primary);
  box-shadow: var(--shadow-sm);
}

.message.user .message-content {
  background-color: var(--color-primary);
  color: white;
}

.message-content p {
  margin: 0;
  line-height: 1.5;
  word-wrap: break-word;
}

.message-time {
  display: block;
  margin-top: var(--spacing-xs);
  font-size: 0.7rem;
  color: var(--color-text-secondary);
}

.message.user .message-time {
  color: rgba(255, 255, 255, 0.7);
}

/* =========================================
   TYPING INDICATOR
   ========================================= */

.typing-indicator {
  display: flex;
  gap: 4px;
  padding: var(--spacing-xs) 0;
}

.typing-indicator span {
  width: 8px;
  height: 8px;
  background-color: var(--color-text-secondary);
  border-radius: 50%;
  animation: typing 1.4s infinite ease-in-out;
}

.typing-indicator span:nth-child(1) {
  animation-delay: 0s;
}

.typing-indicator span:nth-child(2) {
  animation-delay: 0.2s;
}

.typing-indicator span:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes typing {
  0%, 60%, 100% {
    transform: translateY(0);
    opacity: 0.4;
  }
  30% {
    transform: translateY(-4px);
    opacity: 1;
  }
}

/* =========================================
   INPUT FORM
   ========================================= */

.chat-input-form {
  display: flex;
  gap: var(--spacing-sm);
  padding: var(--spacing-md);
  background-color: var(--color-bg-primary);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
}

.message-input {
  flex: 1;
  padding: var(--spacing-sm) var(--spacing-md);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  font-size: 1rem;
  transition: border-color var(--transition-fast);
}

.message-input:focus {
  outline: none;
  border-color: var(--color-primary);
}

.message-input:disabled {
  background-color: var(--color-bg-tertiary);
  cursor: not-allowed;
}

.send-button {
  padding: var(--spacing-sm) var(--spacing-lg);
  background-color: var(--color-accent-amber);
  color: white;
  border: none;
  border-radius: var(--radius-md);
  font-weight: 600;
  cursor: pointer;
  transition: background-color var(--transition-base);
}

.send-button:hover:not(:disabled) {
  background-color: var(--color-accent-amber-dark);
}

.send-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* =========================================
   CHAT ACTIONS
   ========================================= */

.chat-actions {
  display: flex;
  justify-content: center;
  gap: var(--spacing-md);
  margin-top: var(--spacing-md);
}

.action-button {
  padding: var(--spacing-xs) var(--spacing-md);
  background: none;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  color: var(--color-text-secondary);
  font-size: 0.875rem;
  cursor: pointer;
  transition: all var(--transition-base);
}

.action-button:hover {
  border-color: var(--color-secondary);
  color: var(--color-secondary);
}

.action-button.danger:hover {
  border-color: var(--color-error);
  color: var(--color-error);
}

/* =========================================
   ERROR MESSAGE
   ========================================= */

.error-message {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--spacing-sm) var(--spacing-md);
  margin-top: var(--spacing-md);
  background-color: var(--color-error-bg);
  border: 1px solid var(--color-error);
  border-radius: var(--radius-md);
  color: var(--color-error);
}

.error-message button {
  background: none;
  border: none;
  color: var(--color-error);
  cursor: pointer;
  font-weight: 600;
}

/* =========================================
   RESPONSIVE
   ========================================= */
@media (max-width: 768px) {
  .chat-page {
    padding: var(--spacing-sm);
    /* Account for mobile keyboard */
    padding-bottom: calc(var(--spacing-sm) + env(safe-area-inset-bottom));
  }

  .chat-header {
    padding: var(--spacing-md) 0;
    text-align: center;
  }

  .chat-header h1 {
    font-size: 1.5rem;
  }

  .chat-header p {
    font-size: 0.875rem;
  }

  /* Messages take more width on mobile */
  .message {
    max-width: 90%;
  }

  .message-content {
    padding: var(--spacing-sm) var(--spacing-md);
    font-size: 0.9375rem;
    line-height: 1.5;
  }

  /* Suggested questions: horizontal scroll on mobile */
  .suggested-questions {
    flex-wrap: nowrap;
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
    padding-bottom: var(--spacing-sm);
    gap: var(--spacing-sm);
  }

  .suggested-question {
    flex-shrink: 0;
    white-space: nowrap;
    font-size: 0.8125rem;
  }

  /* Input area */
  .chat-input-form {
    padding: var(--spacing-sm);
    gap: var(--spacing-sm);
  }

  .message-input {
    min-height: 44px; /* Touch-friendly minimum */
    font-size: 16px; /* Prevents iOS zoom on focus */
    padding: var(--spacing-sm);
  }

  .send-button {
    width: 44px;
    height: 44px;
    padding: var(--spacing-sm);
    flex-shrink: 0;
  }

  /* Actions stack vertically */
  .chat-actions {
    flex-direction: column;
    gap: var(--spacing-sm);
  }

  .action-button {
    justify-content: center;
    padding: var(--spacing-sm) var(--spacing-md);
    min-height: 44px;
  }
}

/* Landscape mobile - shorter chat area */
@media (max-width: 768px) and (orientation: landscape) {
  .chat-container {
    max-height: 50vh;
  }
  
  .chat-header {
    padding: var(--spacing-sm) 0;
  }
  
  .chat-header h1 {
    font-size: 1.25rem;
  }
}

/* Small phones */
@media (max-width: 375px) {
  .chat-header h1 {
    font-size: 1.25rem;
  }

  .message {
    max-width: 95%;
  }

  .message-content {
    padding: var(--spacing-xs) var(--spacing-sm);
    font-size: 0.875rem;
  }
}
</style>