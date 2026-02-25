<template>
  <nav class="navbar">
    <div class="nav-container">
      <!-- Logo/Brand -->
      <div class="nav-brand">
        <router-link to="/" class="brand-link">
          <span class="brand-icon">M</span>
          <span class="brand-text">Mike Dion</span>
        </router-link>
      </div>

      <!-- Desktop Navigation -->
      <ul class="nav-links">
        <li>
          <router-link to="/" class="nav-link">Profile</router-link>
        </li>
        <li>
          <router-link to="/stories" class="nav-link">Stories</router-link>
        </li>
        <li>
          <router-link to="/work" class="nav-link">Work History</router-link>
        </li>
      </ul>

      <!-- CTA Button (Desktop) -->
      <div class="nav-actions">
        <router-link to="/chat" class="btn btn-primary nav-cta">
          Ask my AI
        </router-link>
      </div>

      <!-- Hamburger button (mobile only) -->
      <button
        class="nav-toggle"
        @click="isMenuOpen = !isMenuOpen"
        :aria-expanded="isMenuOpen"
        aria-label="Toggle navigation menu"
      >
        <span class="hamburger-line" :class="{ 'open': isMenuOpen }"></span>
        <span class="hamburger-line" :class="{ 'open': isMenuOpen }"></span>
        <span class="hamburger-line" :class="{ 'open': isMenuOpen }"></span>
      </button>
    </div>

    <!-- Mobile Menu -->
    <div class="mobile-menu" :class="{ 'open': isMenuOpen }">
      <ul class="mobile-nav-links">
        <li>
          <router-link to="/" class="mobile-nav-link" @click="closeMenu">Profile</router-link>
        </li>
        <li>
          <router-link to="/stories" class="mobile-nav-link" @click="closeMenu">Stories</router-link>
        </li>
        <li>
          <router-link to="/work" class="mobile-nav-link" @click="closeMenu">Work History</router-link>
        </li>
        <li>
          <router-link to="/chat" class="mobile-nav-link mobile-cta" @click="closeMenu">
            Ask my AI
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
/* ============================================
   NAVBAR - Mobile First
   ============================================ */

.navbar {
  position: sticky;
  top: 0;
  z-index: 100;
  background-color: var(--color-bg-primary);
  border-bottom: 1px solid var(--color-border);
}

.nav-container {
  max-width: var(--max-width-content);
  margin: 0 auto;
  padding: var(--spacing-3) var(--spacing-4);
  display: flex;
  justify-content: space-between;
  align-items: center;
}

@media (min-width: 640px) {
  .nav-container {
    padding: var(--spacing-3) var(--spacing-8);
  }
}

@media (min-width: 768px) {
  .nav-container {
    padding: var(--spacing-3) var(--spacing-20);
  }
}

/* ============================================
   BRAND / LOGO
   ============================================ */

.nav-brand {
  flex-shrink: 0;
}

.brand-link {
  display: flex;
  align-items: center;
  gap: var(--spacing-2);
  text-decoration: none;
  color: var(--color-text-primary);
}

.brand-link:hover {
  color: var(--color-text-primary);
}

.brand-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  background-color: var(--color-primary);
  color: var(--color-text-primary);
  font-weight: 800;
  font-size: var(--text-sm);
  border-radius: var(--radius-md);
}

.brand-text {
  font-weight: 700;
  font-size: var(--text-base);
}

/* ============================================
   DESKTOP NAVIGATION (hidden on mobile)
   ============================================ */

.nav-links {
  display: none;
  list-style: none;
  margin: 0;
  padding: 0;
  gap: var(--spacing-6);
}

.nav-link {
  color: var(--color-text-secondary);
  text-decoration: none;
  font-size: var(--text-sm);
  font-weight: 500;
  padding: var(--spacing-2) 0;
  transition: color var(--transition-fast);
}

.nav-link:hover {
  color: var(--color-text-primary);
}

.nav-link.router-link-exact-active {
  color: var(--color-primary);
}

.nav-actions {
  display: none;
}

.nav-cta {
  text-decoration: none;
}

@media (min-width: 768px) {
  .nav-links {
    display: flex;
  }

  .nav-actions {
    display: block;
  }
}

/* ============================================
   HAMBURGER BUTTON (mobile only)
   ============================================ */

.nav-toggle {
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 5px;
  width: 40px;
  height: 40px;
  background: none;
  border: none;
  cursor: pointer;
  padding: var(--spacing-2);
  border-radius: var(--radius-md);
  transition: background-color var(--transition-fast);
}

.nav-toggle:hover {
  background-color: var(--color-bg-tertiary);
}

.hamburger-line {
  display: block;
  width: 20px;
  height: 2px;
  background-color: var(--color-text-primary);
  border-radius: 2px;
  transition: transform var(--transition-base), opacity var(--transition-base);
}

/* Hamburger animation when open */
.hamburger-line.open:nth-child(1) {
  transform: translateY(7px) rotate(45deg);
}

.hamburger-line.open:nth-child(2) {
  opacity: 0;
}

.hamburger-line.open:nth-child(3) {
  transform: translateY(-7px) rotate(-45deg);
}

@media (min-width: 768px) {
  .nav-toggle {
    display: none;
  }
}

/* ============================================
   MOBILE MENU
   ============================================ */

.mobile-menu {
  display: none;
  background-color: var(--color-bg-primary);
  border-top: 1px solid var(--color-border);
  padding: var(--spacing-4);
}

.mobile-menu.open {
  display: block;
}

.mobile-nav-links {
  list-style: none;
  margin: 0;
  padding: 0;
  display: flex;
  flex-direction: column;
  gap: var(--spacing-2);
}

.mobile-nav-link {
  display: block;
  padding: var(--spacing-3) var(--spacing-4);
  color: var(--color-text-secondary);
  text-decoration: none;
  font-size: var(--text-base);
  font-weight: 500;
  border-radius: var(--radius-lg);
  transition: background-color var(--transition-fast), color var(--transition-fast);
}

.mobile-nav-link:hover {
  background-color: var(--color-bg-tertiary);
  color: var(--color-text-primary);
}

.mobile-nav-link.router-link-exact-active {
  background-color: var(--color-primary-subtle);
  color: var(--color-primary);
}

.mobile-cta {
  background-color: var(--color-primary);
  color: var(--color-text-primary);
  text-align: center;
  margin-top: var(--spacing-2);
}

.mobile-cta:hover {
  background-color: var(--color-primary-hover);
  color: var(--color-text-primary);
}

@media (min-width: 768px) {
  .mobile-menu {
    display: none !important;
  }
}
</style>
