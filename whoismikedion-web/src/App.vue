<script setup></script>

<template>
  <div id="app">
    <NavBar />

    <main class="main-content">
      <router-view />
    </main>

    <footer class="footer">
      <p>&copy; 2025 Mike Dion.</p>
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
/* Import global colors */
@import './assets/styles/colors.css';

/* Global styles */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 
               'Helvetica Neue', Arial, sans-serif;
  color: var(--color-text-primary);
  background-color: var(--color-bg-primary);
  line-height: 1.6;
}

#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.main-content {
  flex: 1;
  padding: 2rem;
}

.footer {
  background-color: var(--color-bg-tertiary);
  padding: 2rem;
  text-align: center;
  color: var(--color-text-secondary);
  margin-top: auto;
}

/* Typography */
h1 {
  font-size: 2.5rem;
  color: var(--color-primary);
  margin-bottom: 1rem;
}

h2 {
  font-size: 2rem;
  color: var(--color-secondary);
  margin-bottom: 1rem;
  border-bottom: 2px solid var(--color-primary);
  padding-bottom: 0.5rem;
}

h3 {
  font-size: 1.5rem;
  color: var(--color-text-primary);
  margin-bottom: 0.75rem;
}

/* Links */
a {
  color: var(--color-secondary);
  transition: color var(--transition-fast);
}

a:hover {
  color: var(--color-accent-amber);
}
</style>