<template>
  <nav class="navbar">
    <div class="nav-container">
      <div class="nav-brand">
        <router-link to="/">Mike Dion</router-link>
      </div>
      
      <!-- Hamburger button (mobile only) -->
      <button 
        class="nav-toggle" 
        @click="isMenuOpen = !isMenuOpen"
        :aria-expanded="isMenuOpen"
        aria-label="Toggle navigation menu"
      >
        <span class="hamburger-line"></span>
        <span class="hamburger-line"></span>
        <span class="hamburger-line"></span>
      </button>
      
      <!-- Navigation links -->
      <ul 
        class="nav-links" 
        :class="{ 'nav-open': isMenuOpen }"
      >
        <li>
          <router-link to="/" @click="closeMenu">Profile</router-link>
        </li>
        <li>
          <router-link to="/stories" @click="closeMenu">Stories</router-link>
        </li>
        <li>
          <router-link to="/work" @click="closeMenu">Work History</router-link>
        </li>
        <li>
          <router-link to="/chat" class="chat-link" @click="closeMenu">
            Start Chat
          </router-link>
        </li>
      </ul>
    </div>
  </nav>
</template>

<script setup>
import { ref } from 'vue';

const isMenuOpen = ref(false);

function closeMenu() {
  isMenuOpen.value = false;
}
</script>

<style scoped>
.navbar {
  background-color: var(--color-primary);
  position: sticky;
  top: 0;
  z-index: 100;
}

.nav-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: var(--spacing-md) var(--spacing-lg);
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
}

.nav-brand a {
  color: var(--color-text-inverse);
  font-size: 1.25rem;
  font-weight: 700;
  text-decoration: none;
}

/* Hamburger button - hidden on desktop */
.nav-toggle {
  display: none;
  flex-direction: column;
  justify-content: center;
  gap: 4px;
  width: 44px;
  height: 44px;
  background: none;
  border: none;
  cursor: pointer;
  padding: var(--spacing-sm);
}

.hamburger-line {
  display: block;
  width: 24px;
  height: 2px;
  background-color: var(--color-text-inverse);
  border-radius: 2px;
  transition: transform var(--transition-base), opacity var(--transition-base);
}

/* Navigation links - horizontal on desktop */
.nav-links {
  display: flex;
  gap: var(--spacing-lg);
  list-style: none;
  margin: 0;
  padding: 0;
  align-items: center;
}

.nav-links a {
  color: var(--color-text-inverse);
  text-decoration: none;
  font-weight: 500;
  padding: var(--spacing-xs) var(--spacing-sm);
  transition: opacity var(--transition-fast);
}

.nav-links a:hover {
  opacity: 0.8;
}

.nav-links a.router-link-active {
  border-bottom: 2px solid var(--color-accent-amber);
}

.chat-link {
  background-color: var(--color-accent-amber) !important;
  color: var(--color-text-inverse) !important;
  padding: var(--spacing-sm) var(--spacing-md) !important;
  border-radius: var(--radius-md);
}

.chat-link:hover {
  background-color: var(--color-accent-amber-dark) !important;
  opacity: 1 !important;
}

/* =========================================
   MOBILE STYLES (max-width: 768px)
   ========================================= */

@media (max-width: 768px) {
  .nav-toggle {
    display: flex;
  }
  
  .nav-links {
    /* Hidden by default on mobile */
    display: none;
    flex-direction: column;
    width: 100%;
    padding-top: var(--spacing-md);
    gap: var(--spacing-sm);
  }
  
  .nav-links.nav-open {
    display: flex;
  }
  
  .nav-links li {
    width: 100%;
  }
  
  .nav-links a {
    display: block;
    padding: var(--spacing-md);
    text-align: center;
    border-radius: var(--radius-md);
  }
  
  .nav-links a:hover {
    background-color: rgba(255, 255, 255, 0.1);
    opacity: 1;
  }
  
  .nav-links a.router-link-active {
    background-color: rgba(255, 255, 255, 0.1);
    border-bottom: none;
  }
  
  .chat-link {
    margin-top: var(--spacing-sm);
  }
}
</style>