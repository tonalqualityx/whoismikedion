<script setup></script>

<template>
  <div id="app">
    <NavBar />

    <main class="main-content">
      <router-view />
    </main>

    <footer class="footer">
      <div class="footer-content">
        <p>&copy; 2025 Mike Dion</p>
      </div>
    </footer>
  </div>
</template>

<script>
  import NavBar from './components/NavBar.vue';

  export default {
    name: 'App',
    components: {
      NavBar,
    },
  };
</script>

<style>
/* Import design system */
@import './assets/styles/colors.css';
@import './assets/styles/base.css';

/* App layout */
#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: var(--color-bg-primary);
}

/* Main content area */
.main-content {
  flex: 1;
  padding-top: var(--spacing-6);
  padding-bottom: var(--spacing-8);
}

@media (min-width: 640px) {
  .main-content {
    padding-top: var(--spacing-8);
    padding-bottom: var(--spacing-12);
  }
}

/* Footer */
.footer {
  background-color: var(--color-bg-secondary);
  border-top: 1px solid var(--color-border);
  padding: var(--spacing-6) var(--spacing-4);
  margin-top: auto;
}

.footer-content {
  max-width: var(--max-width-content);
  margin: 0 auto;
  text-align: center;
}

.footer p {
  color: var(--color-text-muted);
  font-size: var(--text-sm);
  margin: 0;
}

@media (min-width: 640px) {
  .footer {
    padding: var(--spacing-8) var(--spacing-8);
  }
}
</style>
