<template>
  <div class="not-found">
    <h1>404 - Page Not Found</h1>
    <p>The page you're looking for doesn't exist.</p>
    <router-link to="/" class="btn-primary">
      Go to Profile
    </router-link>
  </div>
</template>

<script>
export default {
  name: 'NotFoundPage'
}
</script>

<style scoped>
.not-found {
  text-align: center;
  padding: 4rem 2rem;
}

.not-found h1 {
  font-size: 3rem;
  color: var(--color-error);
  margin-bottom: 1rem;
}

.btn-primary {
  display: inline-block;
  margin-top: 2rem;
  padding: 0.75rem 1.5rem;
  background-color: var(--color-accent-amber);
  color: white;
  text-decoration: none;
  border-radius: 0.5rem;
  font-weight: 600;
}

.btn-primary:hover {
  background-color: var(--color-accent-amber-dark);
}
</style>