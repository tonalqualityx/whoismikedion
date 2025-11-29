<template>
  <div class="not-found-page">
    <div class="container">
      <div class="not-found-content">
        <div class="error-code">404</div>
        <h1>Page Not Found</h1>
        <p>The page you're looking for doesn't exist or has been moved.</p>
        <div class="not-found-actions">
          <router-link to="/" class="btn btn-primary">
            Go to Profile
          </router-link>
          <router-link to="/stories" class="btn btn-secondary">
            View Stories
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'NotFoundPage',
};
</script>

<style scoped>
/* ============================================
   NOT FOUND PAGE - Mobile First
   ============================================ */

.not-found-page {
  min-height: calc(100vh - var(--header-height) - var(--spacing-16));
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--spacing-8) 0;
}

.not-found-content {
  text-align: center;
  max-width: 400px;
  margin: 0 auto;
}

.error-code {
  font-size: 6rem;
  font-weight: 800;
  color: var(--color-primary);
  line-height: 1;
  margin-bottom: var(--spacing-4);
  opacity: 0.3;
}

@media (min-width: 640px) {
  .error-code {
    font-size: 8rem;
  }
}

.not-found-content h1 {
  margin-bottom: var(--spacing-4);
}

.not-found-content p {
  color: var(--color-text-muted);
  margin-bottom: var(--spacing-8);
}

.not-found-actions {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-3);
}

@media (min-width: 480px) {
  .not-found-actions {
    flex-direction: row;
    justify-content: center;
  }
}

.not-found-actions .btn {
  text-decoration: none;
}
</style>
