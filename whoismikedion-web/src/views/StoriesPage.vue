<template>
    <div class="stories-page">
        <h1>Success Stories</h1>
        <p class="tagline">
            Real examples of product strategy, systems thinking, and technical delivery.
        </p>
    </div>

    <!-- skill filter -->
     <div class="filter-section">
        <label for="skill-filter">Filter by skill:</label>
        <select
            id="skill-filter"
            v-model="selectedSkill"
            @change="filterStories"
            class="skill-select"
        >
            <option value="">All Skills</option>
            <option value="product-strategy">Product Strategy</option>
            <option value="systems-thinking">Systems Thinking</option>
            <option value="technical-writing">Technical Writing</option>
            <option value="stakeholder-management">Stakeholder Management</option>
            <option value="nodejs">Node.js</option>
            <option value="vuejs">Vue.js</option>
        </select>

        <span v-if="filteredCount != totalCount" class="filter-info">
            Showing {{ filteredCount }} of {{ totalCount }} stories
        </span>
     </div>

     <!-- Loading State -->
      <div v-if="loading" class="loading">
        <p>Loading stories...</p>
      </div>

      <!-- Error state -->
       <div v-else-if="error" class="error">
            <p>{{ error }}</p>
            <button @click="fetchStories" class="retry-button">Retry</button>
       </div>

       <!-- Stories List-->
        <div v-else-if="stories.length > 0" class="stories-list">
            <StoryCard
                v-for="story in stories"
                :key="story.story_id"
                :story="story"
            />
        </div>
        
        <!-- EMPTY State -->
         <div v-else class="empty-state">
            <p>No stories found.</p>
            <p v-if="selectedSkill" class="empty-hint">
                Try selecting a different skill or view all stories.
            </p>
         </div>
</template>

<script>
import { ref, onMounted, computed } from 'vue';
import axios from 'axios';
import StoryCard from '../components/StoryCard.vue';

export default {
    name: 'StoriesPage',

    components: {
        StoryCard
    },

    setup() {
        const stories = ref([]);
        const loading = ref(true);
        const error = ref(null);
        const selectedSkill = ref('');
        const totalCount = ref(0);
        const filteredCount = ref(0);

        const fetchStories = async () => {
            try {
                loading.value = true;
                error.value = null;

                let url = 'http://localhost:3000/api/stories';
                if (selectedSkill.value ) {
                    url += `?skill=${selectedSkill.value}`;
                }

                console.log('Fetching stories:', url);

                const response = await axios.get(url);

                //update state
                stories.value = response.data.stories;
                totalCount.value = response.data.total;
                filteredCount.value = response.data.total;

                console.log(`Loaded ${stories.value.length} stories`);
            } catch (err) {
                console.error('Failed to fetch stories:', err);
                error.value = 'Failed to load stories. Is the back end server running?';
            } finally {
                loading.value = false;
            }
        };

        // Handle skill filter change
        const filterStories = () => {
            fetchStories();
        };

        // Fetch on component mount
        onMounted(() => {
            fetchStories();
        });

        return {
            stories,
            loading,
            error,
            selectedSkill,
            totalCount,
            fetchStories,
            filterStories,
            filteredCount
        };
    }
}
</script>

<style scoped>
.stories-page {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
}

.page-header {
  text-align: center;
  margin-bottom: var(--spacing-2xl);
}

.page-header h1 {
  color: var(--color-primary);
  font-size: 2.5rem;
  margin-bottom: var(--spacing-sm);
}

.tagline {
  color: var(--color-text-secondary);
  font-size: 1.125rem;
}

.filter-section {
  margin-bottom: var(--spacing-2xl);
  padding: var(--spacing-lg);
  background-color: var(--color-bg-tertiary);
  border-radius: var(--radius-lg);
  display: flex;
  align-items: center;
  gap: var(--spacing-md);
  flex-wrap: wrap;
}

.filter-section label {
  font-weight: 600;
  color: var(--color-text-primary);
}

.skill-select {
  padding: var(--spacing-sm) var(--spacing-md);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  background-color: white;
  font-size: 1rem;
  cursor: pointer;
  transition: border-color var(--transition-fast);
  min-width: 200px;
}

.skill-select:focus {
  outline: none;
  border-color: var(--color-primary);
  box-shadow: 0 0 0 3px rgba(44, 95, 111, 0.1);
}

.filter-info {
  color: var(--color-text-secondary);
  font-size: 0.875rem;
  font-style: italic;
}

.stories-list {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
  gap: 1.61rem;
}

/* Loading state */
.loading {
  text-align: center;
  padding: var(--spacing-2xl);
  color: var(--color-text-secondary);
  font-size: 1.125rem;
}

/* Error state */
.error {
  text-align: center;
  padding: var(--spacing-2xl);
  background-color: var(--color-error-bg);
  border: 1px solid var(--color-error);
  border-radius: var(--radius-lg);
  color: var(--color-error);
}

.retry-button {
  margin-top: var(--spacing-md);
  padding: var(--spacing-sm) var(--spacing-lg);
  background-color: var(--color-accent-amber);
  color: white;
  border: none;
  border-radius: var(--radius-md);
  font-weight: 600;
  cursor: pointer;
  transition: background-color var(--transition-base);
}

.retry-button:hover {
  background-color: var(--color-accent-amber-dark);
}

/* Empty state */
.empty-state {
  text-align: center;
  padding: var(--spacing-2xl);
  background-color: var(--color-bg-tertiary);
  border-radius: var(--radius-lg);
  color: var(--color-text-secondary);
}

.empty-hint {
  margin-top: var(--spacing-md);
  font-size: 0.875rem;
}

/* Mobile responsive */
@media (max-width: 768px) {
  .stories-page {
    padding: 1rem;
  }
  
  .page-header h1 {
    font-size: 2rem;
  }
  
  .filter-section {
    flex-direction: column;
    align-items: stretch;
  }
  
  .skill-select {
    width: 100%;
  }
}
</style>