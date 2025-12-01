<template>
  <div class="chat-page">
    <div class="chat-container">

      <!-- HEADER -->
      <header class="chat-header">
        <h1>Chat with Mike's Digital Projection</h1>
        <h2>AI Powered Chat</h2>
        <p class="chat-intro">
          Ask me about my experience, skills, or anything else. I'm here to help you determine if we'd be a good fit.
        </p>
      </header>

      <!-- MESSAGE CONTAINER -->
      <div class="messages-container" ref="messagesContainer">

        <!-- LOADING STATE -->
        <div v-if="loading" class="loading-state">
          <p>Loading conversation...</p>
        </div>

        <!-- EMPTY STATE -->
        <div v-else-if="messages.length === 0" class="empty-state">
          <p>No messages yet. Start a conversation!</p>

          <div class="suggested-questions">
            <h3>Try asking:</h3>
            <div class="suggested-list">
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
        </div>

        <!-- MESSAGES LIST -->
        <div v-else class="messages-list">
          <div
            v-for="message in messages"
            :key="message.id"
            :class="['message', `message--${message.role}`]"
          >
            <!-- AVATAR -->
            <div class="message-avatar">
              <span v-if="message.role === 'user'" class="avatar avatar--user">You</span>
              <span v-else class="avatar avatar--assistant">M</span>
            </div>

            <!-- Content -->
            <div class="message-content">
              <div
                v-if="message.role === 'assistant'"
                class="message-text"
                v-html="getSanitizedContent(message.content)"
              ></div>
              <p v-else>{{ message.content }}</p>
              <span class="message-time">
                {{ formatTime(message.created_at) }}
              </span>
            </div>
          </div>

          <!-- TYPING INDICATOR -->
          <div v-if="sending" class="message message--assistant">
            <div class="message-avatar">
              <span class="avatar avatar--assistant">M</span>
            </div>
            <div class="message-content">
              <div class="typing-indicator">
                <span></span>
                <span></span>
                <span></span>
              </div>
            </div>
          </div>

        </div>

      </div>

      <!-- INPUT FORM -->
      <form class="chat-input-form" @submit.prevent="handleSubmit">
        <input
          v-model="newMessage"
          type="text"
          placeholder="Type your message..."
          :disabled="sending"
          class="message-input"
          ref="messageInput"
        />
        <button
          type="submit"
          class="btn btn-primary send-button"
          :disabled="!newMessage.trim() || sending"
        >
          {{ sending ? '...' : 'Send' }}
        </button>
      </form>

      <!-- SESSION ACTIONS -->
      <div v-if="sessionId && messages.length > 0" class="chat-actions">
        <button
          @click="downloadTranscript"
          class="action-button"
        >
          Download Transcript
        </button>
        <button
          @click="confirmClearChat"
          class="action-button action-button--danger"
        >
          Clear Chat
        </button>
        <p class="chat-disclaimer">This chat is powered by Claude. It's great, but remember that it may hallucinate sometimes too!</p>
      </div>

      <!-- ERROR DISPLAY -->
      <div v-if="error" class="error-message">
        <p>{{ error }}</p>
        <button @click="error = null">Dismiss</button>
      </div>

    </div>
  </div>
</template>

<script>
import { ref, onMounted, nextTick, watch } from 'vue';
import axios from 'axios';
import { sanitizeHtml } from '@/utils/sanitizeHtml';
import config from '@/config';

export default {
  name: 'ChatPage',

  setup() {
    const newMessage = ref('');
    const messages = ref([]);
    const sessionId = ref(null);
    const loading = ref(true);
    const sending = ref(false);
    const error = ref(null);
    const messagesContainer = ref(null);
    const messageInput = ref(null);

    const suggestedQuestions = [
      "What's your experience with product strategy?",
      "Tell me about a challenging project you've worked on.",
      "What technologies are you most proficient in?",
      "What are you looking for in your next role?",
    ];

    const API_BASE = config.API_BASE;

    onMounted(async () => {
      const storedSessionId = localStorage.getItem('chat_session_id');

      if (storedSessionId) {
        await loadSession(storedSessionId);
      } else {
        loading.value = false;
      }

      if (messageInput.value) {
        messageInput.value.focus();
      }
    });

    async function loadSession(existingSessionId) {
      try {
        const response = await axios.get(`${API_BASE}/chat/${existingSessionId}`);
        sessionId.value = response.data.session_id;
        messages.value = response.data.messages;
        loading.value = false;
        await nextTick();
        scrollToBottom();
      } catch (err) {
        console.error('Failed to load session:', err);
        localStorage.removeItem('chat_session_id');
        sessionId.value = null;
        messages.value = [];
        loading.value = false;
      }
    }

    async function handleSubmit() {
      if (!newMessage.value.trim()) return;
      if (sending.value) return;

      const messageText = newMessage.value.trim();
      newMessage.value = '';

      const tempUserMessage = {
        id: `temp-${Date.now()}`,
        role: 'user',
        content: messageText,
        created_at: new Date().toISOString(),
      };
      messages.value.push(tempUserMessage);

      await nextTick();
      scrollToBottom();

      sending.value = true;
      error.value = null;
      await nextTick();
      scrollToBottom();

      try {
        const requestBody = { message: messageText };
        if (sessionId.value) {
          requestBody.session_id = sessionId.value;
        }

        const response = await axios.post(`${API_BASE}/chat`, requestBody);

        if (response.data.is_new_session) {
          sessionId.value = response.data.session_id;
          localStorage.setItem('chat_session_id', response.data.session_id);
        }

        const serverMessages = response.data.messages;
        const userMsg = serverMessages.find((m) => m.role === 'user');
        const assistantMsg = serverMessages.find((m) => m.role === 'assistant');

        const tempIndex = messages.value.findIndex((m) => m.id === tempUserMessage.id);
        if (tempIndex !== -1 && userMsg) {
          messages.value[tempIndex] = userMsg;
        }

        if (assistantMsg) {
          messages.value.push(assistantMsg);
        }

        await nextTick();
        scrollToBottom();
      } catch (err) {
        console.error('Failed to send message:', err);
        error.value = 'Failed to send message. Please try again.';

        const tempIndex = messages.value.findIndex((m) => m.id === tempUserMessage.id);
        if (tempIndex !== -1) {
          messages.value.splice(tempIndex, 1);
        }

        newMessage.value = messageText;
      } finally {
        sending.value = false;

        await nextTick();
        if (messageInput.value) {
          messageInput.value.focus();
        }
      }
    }

    function sendSuggestedQuestion(question) {
      newMessage.value = question;
      handleSubmit();
    }

    function scrollToBottom() {
      if (messagesContainer.value) {
        messagesContainer.value.scrollTop = messagesContainer.value.scrollHeight;
      }
    }

    function formatTime(timestamp) {
      if (!timestamp) return '';
      const date = new Date(timestamp);
      return date.toLocaleTimeString([], {
        hour: '2-digit',
        minute: '2-digit',
      });
    }

    function getSanitizedContent(content) {
      return sanitizeHtml(content);
    }

    function downloadTranscript() {
      if (!sessionId.value) return;
      window.open(`${API_BASE}/chat/${sessionId.value}/transcript`, '_blank');
    }

    async function confirmClearChat() {
      const confirmed = window.confirm(
        'Are you sure you want to clear this conversation? This cannot be undone.'
      );

      if (!confirmed) return;

      try {
        await axios.delete(`${API_BASE}/chat/${sessionId.value}`);
        messages.value = [];
        sessionId.value = null;
        localStorage.removeItem('chat_session_id');
      } catch (err) {
        console.error('Failed to clear chat:', err);
        error.value = 'Failed to clear chat. Please try again.';
      }
    }

    watch(
      messages,
      async () => {
        await nextTick();
        scrollToBottom();
      },
      { deep: true }
    );

    return {
      newMessage,
      messages,
      sessionId,
      loading,
      sending,
      error,
      suggestedQuestions,
      messagesContainer,
      messageInput,
      handleSubmit,
      sendSuggestedQuestion,
      formatTime,
      getSanitizedContent,
      downloadTranscript,
      confirmClearChat,
    };
  },
};
</script>

<style scoped>
/* ============================================
   CHAT PAGE - Mobile First
   ============================================ */

.chat-page {
  height: calc(100vh - var(--header-height) - var(--spacing-12));
  display: flex;
  flex-direction: column;
  padding: var(--spacing-4);
}

@media (min-width: 640px) {
  .chat-page {
    padding: var(--spacing-6);
  }
}

.chat-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  max-width: 800px;
  margin: 0 auto;
  width: 100%;
}

/* ============================================
   HEADER
   ============================================ */

.chat-header {
  text-align: center;
  padding-bottom: var(--spacing-4);
  border-bottom: 1px solid var(--color-border);
  margin-bottom: var(--spacing-4);
  flex-shrink: 0;
}

.chat-header h1 {
  font-size: var(--text-xl);
  margin-bottom: var(--spacing-2);
}

.chat-header h2 {
  font-size: var(--text-lg);
}

@media (min-width: 640px) {
  .chat-header h1 {
    font-size: var(--text-2xl);
  }
}

.chat-intro {
  color: var(--color-text-muted);
  font-size: var(--text-sm);
  max-width: 500px;
  margin: 0 auto;
}

/* ============================================
   MESSAGES CONTAINER
   ============================================ */

.messages-container {
  flex: 1;
  overflow-y: auto;
  padding: var(--spacing-4);
  background: var(--color-bg-secondary);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  margin-bottom: var(--spacing-4);
}

/* ============================================
   LOADING & EMPTY STATES
   ============================================ */

.loading-state,
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  text-align: center;
  color: var(--color-text-muted);
}

.suggested-questions {
  margin-top: var(--spacing-8);
  width: 100%;
}

.suggested-questions h3 {
  color: var(--color-text-primary);
  font-size: var(--text-sm);
  margin-bottom: var(--spacing-4);
}

.suggested-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-2);
}

.suggested-question {
  width: 100%;
  padding: var(--spacing-3) var(--spacing-4);
  background: var(--color-bg-tertiary);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  color: var(--color-text-secondary);
  font-size: var(--text-sm);
  text-align: left;
  cursor: pointer;
  transition: border-color var(--transition-fast), color var(--transition-fast);
}

.suggested-question:hover {
  border-color: var(--color-primary);
  color: var(--color-primary);
}

/* ============================================
   MESSAGES LIST
   ============================================ */

.messages-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-4);
}

.message {
  display: flex;
  gap: var(--spacing-3);
  max-width: 85%;
}

.message--user {
  flex-direction: row-reverse;
  margin-left: auto;
}

.message--assistant {
  margin-right: auto;
}

/* ============================================
   MESSAGE AVATAR
   ============================================ */

.message-avatar {
  flex-shrink: 0;
}

.avatar {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  border-radius: var(--radius-full);
  font-size: var(--text-xs);
  font-weight: 700;
}

.avatar--user {
  background: var(--color-bg-tertiary);
  color: var(--color-text-secondary);
}

.avatar--assistant {
  background: var(--color-primary);
  color: var(--color-text-primary);
}

/* ============================================
   MESSAGE CONTENT
   ============================================ */

.message-content {
  padding: var(--spacing-3) var(--spacing-4);
  border-radius: var(--radius-xl);
  background: var(--color-bg-tertiary);
}

.message--user .message-content {
  background: var(--color-primary);
  color: var(--color-text-primary);
}

.message-content p {
  margin: 0;
  line-height: 1.6;
  font-size: var(--text-sm);
  color: inherit;
}

.message--assistant .message-content p {
  color: var(--color-text-secondary);
}

/* ============================================
   MESSAGE HTML CONTENT STYLING
   ============================================ */

.message-text {
  line-height: 1.6;
  font-size: var(--text-sm);
  color: var(--color-text-secondary);
}

.message-text :deep(p) {
  margin: 0 0 var(--spacing-2) 0;
}

.message-text :deep(p:last-child) {
  margin-bottom: 0;
}

.message-text :deep(strong) {
  font-weight: 600;
  color: var(--color-text-primary);
}

.message-text :deep(em) {
  font-style: italic;
}

.message-text :deep(ul),
.message-text :deep(ol) {
  margin: var(--spacing-2) 0;
  padding-left: var(--spacing-4);
}

.message-text :deep(li) {
  margin-bottom: var(--spacing-1);
}

.message-text :deep(code) {
  background: var(--color-bg-elevated);
  padding: 0.125rem 0.375rem;
  border-radius: var(--radius-sm);
  font-family: 'SF Mono', Monaco, monospace;
  font-size: 0.85em;
}

.message-text :deep(pre) {
  background: var(--color-bg-primary);
  padding: var(--spacing-3);
  border-radius: var(--radius-md);
  overflow-x: auto;
  margin: var(--spacing-2) 0;
}

.message-text :deep(pre code) {
  background: none;
  padding: 0;
}

.message-text :deep(a) {
  color: var(--color-primary);
  text-decoration: underline;
}

.message-text :deep(a:hover) {
  opacity: 0.8;
}

.message-time {
  display: block;
  margin-top: var(--spacing-2);
  font-size: var(--text-xs);
  color: var(--color-text-muted);
}

.message--user .message-time {
  color: rgba(255, 255, 255, 0.7);
}

/* ============================================
   TYPING INDICATOR
   ============================================ */

.typing-indicator {
  display: flex;
  gap: 4px;
  padding: var(--spacing-1) 0;
}

.typing-indicator span {
  width: 8px;
  height: 8px;
  background: var(--color-text-muted);
  border-radius: var(--radius-full);
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
  0%,
  60%,
  100% {
    transform: translateY(0);
    opacity: 0.4;
  }
  30% {
    transform: translateY(-4px);
    opacity: 1;
  }
}

/* ============================================
   INPUT FORM
   ============================================ */

.chat-input-form {
  display: flex;
  gap: var(--spacing-2);
  flex-shrink: 0;
}

.message-input {
  flex: 1;
  padding: var(--spacing-3) var(--spacing-4);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  background: var(--color-bg-secondary);
  color: var(--color-text-primary);
  font-size: 16px; /* Prevents iOS zoom */
  font-family: inherit;
  transition: border-color var(--transition-fast);
}

.message-input::placeholder {
  color: var(--color-text-muted);
}

.message-input:focus {
  outline: none;
  border-color: var(--color-primary);
}

.message-input:disabled {
  background: var(--color-bg-tertiary);
  cursor: not-allowed;
}

.send-button {
  padding: var(--spacing-3) var(--spacing-6);
  flex-shrink: 0;
}

.send-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* ============================================
   CHAT ACTIONS
   ============================================ */

.chat-actions {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  gap: var(--spacing-4);
  margin-top: var(--spacing-4);
  flex-shrink: 0;
}

.chat-disclaimer {
  width: 100%;
  text-align: center;
  font-size: var(--text-sm);
  color: var(--color-text-muted);
  margin: var(--spacing-2) 0 0 0;
}

.action-button {
  padding: var(--spacing-2) var(--spacing-4);
  background: transparent;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  color: var(--color-text-muted);
  font-size: var(--text-sm);
  cursor: pointer;
  transition: border-color var(--transition-fast), color var(--transition-fast);
}

.action-button:hover {
  border-color: var(--color-primary);
  color: var(--color-primary);
}

.action-button--danger:hover {
  border-color: var(--color-error);
  color: var(--color-error);
}

/* ============================================
   ERROR MESSAGE
   ============================================ */

.error-message {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--spacing-3) var(--spacing-4);
  margin-top: var(--spacing-4);
  background: var(--color-error-subtle);
  border: 1px solid var(--color-error);
  border-radius: var(--radius-lg);
  flex-shrink: 0;
}

.error-message p {
  color: var(--color-error);
  margin: 0;
  font-size: var(--text-sm);
}

.error-message button {
  background: transparent;
  border: none;
  color: var(--color-error);
  font-weight: 600;
  font-size: var(--text-sm);
  cursor: pointer;
}

/* ============================================
   RESPONSIVE
   ============================================ */

@media (max-width: 480px) {
  .message {
    max-width: 90%;
  }

  .chat-actions {
    flex-direction: column;
    gap: var(--spacing-2);
  }

  .action-button {
    width: 100%;
    text-align: center;
  }
}
</style>
