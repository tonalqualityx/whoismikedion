<template>
    <nav class="navbar">
        <div class="navbar-container">
            <!-- Logo -->
             <router-link to="/" class="navbar-brand">
                Who Is Mike Dion?
             </router-link>

            <!-- Navigation Links -->
             <div class="navbar-links">
                <router-link to="/" class="nav-link">Profile</router-link>
                <router-link to="/stories" class="nav-link">Stories</router-link>
                <router-link to="/work" class="nav-link">Work History</router-link>
                <router-link to="/chat" class="nav-link">Chat</router-link>

             </div>
        </div>
    </nav>
</template>

<script>
export default {
    name: 'NavBar',
};
</script>

<style scoped>
.navbar {
  background-color: var(--color-primary);
  padding: 1rem 2rem;
  box-shadow: var(--shadow-md);
}

.navbar-container {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.navbar-brand {
  font-size: 1.5rem;
  font-weight: 700;
  color: white;
  text-decoration: none;
  transition: opacity var(--transition-fast);
}

.navbar-brand:hover {
  opacity: 0.9;
}

.navbar-links {
  display: flex;
  gap: 2rem;
}

.nav-link {
  color: white;
  text-decoration: none;
  padding: 0.5rem 1rem;
  border-radius: var(--radius-md);
  transition: background-color var(--transition-fast);
  opacity: 0.9;
}

.nav-link:hover {
  opacity: 1;
  background-color: rgba(255, 255, 255, 0.1);
}

/* Active link styling - automatically applied by Vue Router */
.nav-link.router-link-active {
  background-color: rgba(255, 255, 255, 0.2);
  opacity: 1;
  font-weight: 600;
}

.chat-link {
  background-color: var(--color-accent-amber);
  color: white !important;
  padding: 0.5rem 1rem;
  border-radius: var(--radius-md);
  transition: background-color var(--transition-base);
}

.chat-link:hover {
  background-color: var(--color-accent-amber-dark);
}

/* Mobile responsive */
@media (max-width: 768px) {
  .navbar-container {
    flex-direction: column;
    gap: 1rem;
  }
  
  .navbar-links {
    width: 100%;
    justify-content: center;
  }
}
</style>