<template>
  <div class="stories-page">
    <div class="container">

      <!-- Page Header -->
      <header class="page-header">
        <h1>Success Stories</h1>
        <p class="page-subtitle">
          Real examples of product strategy, systems thinking, and technical delivery.
        </p>
      </header>

      <!-- Skill Filter -->
      <div class="filter-section">
        <label for="skill-filter" class="filter-label">Filter by skill:</label>
        <select
          id="skill-filter"
          v-model="selectedSkill"
          @change="filterStories"
          class="skill-select"
        >
          <option value="">All Skills</option>
          <option
            v-for="skill in availableSkills"
            :key="skill.skill_id"
            :value="skill.skill_id"
          >
            {{ skill.name }}
          </option>
        </select>

        <span v-if="filteredCount !== totalCount" class="filter-info">
          Showing {{ filteredCount }} of {{ totalCount }} stories
        </span>
      </div>

      <!-- Loading State -->
      <div v-if="loading" class="loading">
        <p>Loading stories...</p>
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="error-state">
        <p>{{ error }}</p>
        <button class="btn btn-primary" @click="fetchStories">Retry</button>
      </div>

      <!-- Stories Grid -->
      <div v-else-if="stories.length > 0" class="stories-grid">
        <StoryCard
          v-for="story in stories"
          :key="story.story_id"
          :story="story"
        />
      </div>

      <!-- Empty State -->
      <div v-else class="empty-state">
        <p>No stories found.</p>
        <p v-if="selectedSkill" class="empty-hint">
          Try selecting a different skill or view all stories.
        </p>
        <button
          v-if="selectedSkill"
          class="btn btn-secondary"
          @click="clearFilter"
        >
          View All Stories
        </button>
      </div>

    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import StoryCard from '../components/StoryCard.vue';
import config from '@/config';

export default {
  name: 'StoriesPage',

  components: {
    StoryCard,
  },

  setup() {
    const stories = ref([]);
    const loading = ref(true);
    const error = ref(null);
    const selectedSkill = ref('');
    const totalCount = ref(0);
    const filteredCount = ref(0);
    const availableSkills = ref([]);

    const fetchStories = async () => {
      try {
        loading.value = true;
        error.value = null;

        let url = `${config.API_BASE}/stories`;
        if (selectedSkill.value) {
          url += `?skill=${selectedSkill.value}`;
        }

        const response = await axios.get(url);

        stories.value = response.data.stories;
        totalCount.value = response.data.total;
        filteredCount.value = response.data.stories.length;
      } catch (err) {
        console.error('Failed to fetch stories:', err);
        error.value = 'Failed to load stories. Please try again.';
      } finally {
        loading.value = false;
      }
    };

    const filterStories = () => {
      fetchStories();
    };

    const clearFilter = () => {
      selectedSkill.value = '';
      fetchStories();
    };

    const fetchFilters = async () => {
      try {
        const response = await axios.get(`${config.API_BASE}/stories/filters`);
        availableSkills.value = response.data.skills;
      } catch (err) {
        console.error('Failed to fetch filters:', err);
      }
    };

    onMounted(() => {
      fetchFilters();
      fetchStories();
    });

    return {
      stories,
      loading,
      error,
      selectedSkill,
      totalCount,
      filteredCount,
      availableSkills,
      fetchStories,
      filterStories,
      clearFilter,
    };
  },
};
</script>

<style scoped>
/* ============================================
   STORIES PAGE - Mobile First
   ============================================ */

.stories-page {
  padding: var(--spacing-4) 0;
}

@media (min-width: 640px) {
  .stories-page {
    padding: var(--spacing-8) 0;
  }
}

/* ============================================
   PAGE HEADER
   ============================================ */

.page-header {
  text-align: center;
  margin-bottom: var(--spacing-8);
}

.page-subtitle {
  color: var(--color-text-muted);
  font-size: var(--text-lg);
  max-width: 500px;
  margin: 0 auto;
}

/* ============================================
   FILTER SECTION
   ============================================ */

.filter-section {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-3);
  margin-bottom: var(--spacing-8);
  padding: var(--spacing-4);
  background: var(--color-bg-tertiary);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
}

@media (min-width: 640px) {
  .filter-section {
    flex-direction: row;
    align-items: center;
    padding: var(--spacing-4) var(--spacing-6);
  }
}

.filter-label {
  font-weight: 600;
  color: var(--color-text-primary);
  font-size: var(--text-sm);
}

.skill-select {
  padding: var(--spacing-2) var(--spacing-4);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  background: var(--color-bg-secondary);
  color: var(--color-text-primary);
  font-size: var(--text-base);
  font-family: inherit;
  cursor: pointer;
  transition: border-color var(--transition-fast), box-shadow var(--transition-fast);
  min-width: 200px;
}

.skill-select:focus {
  outline: none;
  border-color: var(--color-primary);
  box-shadow: 0 0 0 3px var(--color-primary-subtle);
}

.skill-select option {
  background: var(--color-bg-secondary);
  color: var(--color-text-primary);
}

.filter-info {
  color: var(--color-text-muted);
  font-size: var(--text-sm);
  margin-left: auto;
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

.error-state p {
  color: var(--color-error);
  margin-bottom: var(--spacing-4);
}

.empty-state {
  text-align: center;
  padding: var(--spacing-12);
  background: var(--color-bg-tertiary);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
}

.empty-state p {
  color: var(--color-text-muted);
}

.empty-hint {
  font-size: var(--text-sm);
  margin-bottom: var(--spacing-4);
}

/* ============================================
   STORIES GRID
   ============================================ */

.stories-grid {
  display: grid;
  gap: var(--spacing-6);
}

@media (min-width: 640px) {
  .stories-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}
</style>
