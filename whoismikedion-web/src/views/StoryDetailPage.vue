<template>
  <div class="story-detail-page">
    <div class="container">

      <!-- Back Navigation -->
      <nav class="back-nav">
        <router-link to="/stories" class="back-link">
          <span class="back-arrow">&larr;</span>
          Back to Stories
        </router-link>
      </nav>

      <!-- Loading State -->
      <div v-if="loading" class="loading">
        <p>Loading story...</p>
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="error-state">
        <h2>{{ error.title }}</h2>
        <p>{{ error.message }}</p>
        <router-link to="/stories" class="btn btn-primary">
          View All Stories
        </router-link>
      </div>

      <!-- Story Content -->
      <article v-else-if="story" class="story-article">

        <!-- Story Header -->
        <header class="story-header">
          <h1>{{ story.title }}</h1>
          <p class="story-id">{{ story.story_id }}</p>
        </header>

        <!-- Context Section -->
        <section class="story-section">
          <h2>Context</h2>
          <p>{{ story.context }}</p>
        </section>

        <!-- Solution Section -->
        <section class="story-section story-section--solution">
          <h2>Solution</h2>
          <p>{{ story.solution }}</p>
        </section>

        <!-- Outcome Section -->
        <section class="story-section story-section--outcome">
          <h2>Outcome</h2>
          <p>{{ story.outcome }}</p>
        </section>

        <!-- Impact Highlight -->
        <div v-if="story.quantifiable_impact" class="impact-highlight">
          <h3>Measurable Impact</h3>
          <p>{{ story.quantifiable_impact }}</p>
        </div>

        <!-- Skills Demonstrated -->
        <section v-if="story.skills?.length" class="skills-section">
          <h2 class="section-title">Skills Demonstrated</h2>
          <div class="skills-grid">
            <div
              v-for="skill in story.skills"
              :key="skill.skill_id"
              class="skill-item"
            >
              <h3 class="skill-name">{{ skill.name }}</h3>
              <span :class="['skill-tag', `skill-tag--${skill.proficiency}`]">
                {{ skill.proficiency }}
              </span>
              <p class="skill-category">{{ formatCategory(skill.category) }}</p>
            </div>
          </div>
        </section>

        <!-- Related Work Experience -->
        <section v-if="story.work_history?.length" class="work-section">
          <div class="work-header">
            <h2 class="section-title">Related Experience</h2>
            <router-link to="/work" class="work-link">
              View All Experience
            </router-link>
          </div>

          <div class="work-list">
            <div
              v-for="(work, index) in story.work_history"
              :key="index"
              class="work-item card"
            >
              <h3 class="work-title">{{ work.title }}</h3>
              <p class="work-company">{{ work.company }}</p>
              <p class="work-dates">{{ work.dates }}</p>
            </div>
          </div>

          <p class="work-note">
            This story was developed during my time at {{ story.work_history[0].company }}.
          </p>
        </section>

      </article>

    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import axios from 'axios';
import config from '@/config';

export default {
  name: 'StoryDetailPage',

  setup() {
    const route = useRoute();
    const story = ref(null);
    const loading = ref(true);
    const error = ref(null);

    const storyId = route.params.story_id;

    const fetchStory = async () => {
      try {
        loading.value = true;
        error.value = null;

        const response = await axios.get(
          `${config.API_BASE}/stories/${storyId}`
        );
        story.value = response.data;

        // Update document title with story title
        if (response.data.title) {
          document.title = `${response.data.title} - Mike Dion`;

          // Update meta description with story context
          const descriptionMeta = document.querySelector('meta[name="description"]');
          if (descriptionMeta && response.data.context) {
            const truncatedContext = response.data.context.substring(0, 155) + '...';
            descriptionMeta.setAttribute('content', truncatedContext);
          }
        }
      } catch (err) {
        console.error('Failed to fetch story:', err);

        if (err.response?.status === 404) {
          error.value = {
            title: 'Story Not Found',
            message: `No story found with ID: ${storyId}`,
          };
        } else {
          error.value = {
            title: 'Error Loading Story',
            message: 'Failed to load story details. Please try again.',
          };
        }
      } finally {
        loading.value = false;
      }
    };

    const formatCategory = (category) => {
      if (!category) return '';
      return category
        .replace(/_/g, ' ')
        .replace(/\b\w/g, (l) => l.toUpperCase());
    };

    onMounted(() => {
      fetchStory();
    });

    return {
      story,
      loading,
      error,
      formatCategory,
    };
  },
};
</script>

<style scoped>
/* ============================================
   STORY DETAIL PAGE - Mobile First
   ============================================ */

.story-detail-page {
  padding: var(--spacing-4) 0;
}

@media (min-width: 640px) {
  .story-detail-page {
    padding: var(--spacing-8) 0;
  }
}

/* ============================================
   BACK NAVIGATION
   ============================================ */

.back-nav {
  margin-bottom: var(--spacing-6);
}

.back-link {
  display: inline-flex;
  align-items: center;
  gap: var(--spacing-2);
  color: var(--color-text-muted);
  text-decoration: none;
  font-size: var(--text-sm);
  font-weight: 500;
  transition: color var(--transition-fast);
}

.back-link:hover {
  color: var(--color-primary);
}

.back-arrow {
  font-size: var(--text-lg);
}

/* ============================================
   LOADING & ERROR STATES
   ============================================ */

.loading {
  text-align: center;
  padding: var(--spacing-16);
  color: var(--color-text-muted);
  font-size: var(--text-lg);
}

.error-state {
  text-align: center;
  padding: var(--spacing-8);
  background: var(--color-error-subtle);
  border: 1px solid var(--color-error);
  border-radius: var(--radius-xl);
}

.error-state h2 {
  color: var(--color-error);
  margin-bottom: var(--spacing-2);
}

.error-state p {
  color: var(--color-text-secondary);
  margin-bottom: var(--spacing-6);
}

/* ============================================
   STORY ARTICLE
   ============================================ */

.story-article {
  background: var(--color-bg-tertiary);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  padding: var(--spacing-6);
}

@media (min-width: 640px) {
  .story-article {
    padding: var(--spacing-8);
  }
}

@media (min-width: 768px) {
  .story-article {
    padding: var(--spacing-10);
  }
}

/* ============================================
   STORY HEADER
   ============================================ */

.story-header {
  margin-bottom: var(--spacing-8);
  padding-bottom: var(--spacing-6);
  border-bottom: 2px solid var(--color-primary);
}

.story-header h1 {
  margin-bottom: var(--spacing-2);
}

.story-id {
  color: var(--color-text-muted);
  font-size: var(--text-sm);
  font-family: monospace;
  margin: 0;
}

/* ============================================
   STORY SECTIONS
   ============================================ */

.story-section {
  margin-bottom: var(--spacing-8);
}

.story-section h2 {
  color: var(--color-text-primary);
  font-size: var(--text-xl);
  margin-bottom: var(--spacing-4);
  padding-bottom: var(--spacing-2);
  border-bottom: 1px solid var(--color-border);
}

.story-section p {
  line-height: 1.8;
  color: var(--color-text-secondary);
}

.story-section--solution {
  background: var(--color-info-subtle);
  padding: var(--spacing-4);
  border-radius: var(--radius-lg);
  border-left: 4px solid var(--color-info);
}

.story-section--solution h2 {
  border-bottom: none;
  padding-bottom: 0;
}

.story-section--outcome {
  background: var(--color-success-subtle);
  padding: var(--spacing-4);
  border-radius: var(--radius-lg);
  border-left: 4px solid var(--color-success);
}

.story-section--outcome h2 {
  border-bottom: none;
  padding-bottom: 0;
}

@media (min-width: 640px) {
  .story-section--solution,
  .story-section--outcome {
    padding: var(--spacing-6);
  }
}

/* ============================================
   IMPACT HIGHLIGHT
   ============================================ */

.impact-highlight {
  background: linear-gradient(135deg, var(--color-primary) 0%, #0d7ab8 100%);
  color: var(--color-text-primary);
  padding: var(--spacing-6);
  border-radius: var(--radius-xl);
  margin-bottom: var(--spacing-8);
  text-align: center;
}

.impact-highlight h3 {
  font-size: var(--text-sm);
  text-transform: uppercase;
  letter-spacing: 1px;
  opacity: 0.9;
  margin-bottom: var(--spacing-3);
}

.impact-highlight p {
  font-size: var(--text-xl);
  font-weight: 700;
  margin: 0;
  color: var(--color-text-primary);
}

@media (min-width: 640px) {
  .impact-highlight {
    padding: var(--spacing-8);
  }

  .impact-highlight p {
    font-size: var(--text-2xl);
  }
}

/* ============================================
   SKILLS SECTION
   ============================================ */

.skills-section {
  margin-bottom: var(--spacing-8);
}

.skills-grid {
  display: grid;
  gap: var(--spacing-4);
}

@media (min-width: 640px) {
  .skills-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 768px) {
  .skills-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

.skill-item {
  background: var(--color-bg-secondary);
  padding: var(--spacing-4);
  border-radius: var(--radius-lg);
  border: 1px solid var(--color-border);
}

.skill-name {
  font-size: var(--text-base);
  font-weight: 600;
  margin-bottom: var(--spacing-2);
}

.skill-category {
  color: var(--color-text-muted);
  font-size: var(--text-xs);
  margin: var(--spacing-2) 0 0;
  text-transform: capitalize;
}

/* ============================================
   WORK SECTION
   ============================================ */

.work-section {
  margin-bottom: var(--spacing-4);
}

.work-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: var(--spacing-2);
  margin-bottom: var(--spacing-4);
}

.work-header .section-title {
  margin-bottom: 0;
}

.work-link {
  color: var(--color-primary);
  font-size: var(--text-sm);
  font-weight: 500;
  text-decoration: none;
  transition: color var(--transition-fast);
}

.work-link:hover {
  color: var(--color-text-primary);
}

.work-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-4);
  margin-bottom: var(--spacing-4);
}

.work-item {
  border-left: 3px solid var(--color-primary);
}

.work-title {
  font-size: var(--text-base);
  font-weight: 600;
  margin-bottom: var(--spacing-1);
}

.work-company {
  color: var(--color-primary);
  font-weight: 500;
  font-size: var(--text-sm);
  margin-bottom: var(--spacing-1);
}

.work-dates {
  color: var(--color-text-muted);
  font-size: var(--text-sm);
  margin: 0;
}

.work-note {
  padding: var(--spacing-3);
  background: var(--color-bg-secondary);
  border-radius: var(--radius-md);
  font-size: var(--text-sm);
  color: var(--color-text-muted);
  font-style: italic;
  margin: 0;
}
</style>
