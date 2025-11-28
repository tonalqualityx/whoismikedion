<template>
    <div class="story-detail-page">
        <!-- Back Navigation -->
        <div class="back-nav">
        <router-link to="/stories" class="back-link">
            ← Back to Stories
        </router-link>
        </div>

        <!-- Loading State -->
        <div v-if="loading" class="loading">
        <p>Loading story details...</p>
        </div>

        <!-- Error State-->
        <div v-else-if="error" class="error-state">
            <h2>{{ error.title }}</h2>
            <p>{{ error.message }}</p>
            <router-link to="/stories" class="btn-primary">
                View All Stories
            </router-link>
        </div>

        <!-- Story Content -->
        <article v-else-if="story" class="story-content">
            
            <!-- Story Header -->
            <header class="story-header">
                <h1>{{ story.title }}</h1>
                <p class="story-id">Story ID: {{ story.story_id }}</p>
            </header>

            <!-- Context Section -->
            <section class="story-section">
                <h2>Context</h2>
                <p>{{ story.context }}</p>
            </section>

            <!-- Challenge Section -->
            <section class="story-section solution">
                <h2>Solution</h2>
                <p>{{ story.solution }}</p>
            </section>

            <!-- Outcome Section -->
            <section class="story-section outcome">
                <h2>Outcome</h2>
                <p>{{ story.outcome }}</p>    
            </section>
            
            <!-- Impact Highlights -->
            <div v-if="story.quantifiable_impact" class="impact-highlight">
                <h3>Measurable Impact</h3>
                <p>{{ story.quantifiable_impact }}</p>
            </div>

                <!-- Skills -->
            <section class="skills-section" v-if="story.skills && story.skills.length > 0">
                <h2>Skills Demonstrated</h2>
                <div class="skills-grid">
                    <div
                        v-for="skill in story.skills"
                        :key="skill.skill_id"
                        class="skill-card"
                    >
                        <h3>{{ skill.name }}</h3>
                        <span :class="`proficiency-badge ${skill.proficiency}`">
                            {{ skill.proficiency }}
                        </span>
                        <p class="skill-category">{{ formatCategory(skill.category) }}</p>
                    </div>
                </div>
            </section>

            <!-- Related Work -->
            <section 
                class="work-section"
                v-if="story.work_history && story.work_history.length > 0"
            >
                <h2>Related Experience</h2>
                <router-link to="/work" class="view-all-work">
                  View All Experience →
                </router-link>
                <div class="work-list">
                    <div
                        v-for="(work, index) in story.work_history"
                        :key="index"
                        class="work-item"
                    >
                        <h3>{{ work.title }}</h3>
                        <p class="work-company">{{ work.company }}</p>
                        <p class="work-dates">{{ work.dates }}</p>
                    </div>
                </div>

                <p class="work-context-note">
                  This story was developed during my time at {{  story.work_history[0].company }}.
                </p>
            </section>
        </article>
    </div>
</template>

<script>
import {ref, onMounted } from 'vue';
import { useRoute } from  'vue-router';
import axios from 'axios';

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

                const url = `http://localhost:3000/api/stories/${storyId}`;
                console.log('Fetching story:', url);

                const response = await axios.get(url);
                story.value = response.data;

                console.log('Story loaded:', response.data.title);

            } catch (err) {
                console.error('Failed to fetch story:', err);

                if( err.response && err.response.status === 404) {
                    error.value = {
                        title: 'Story Not Found',
                        message: `No story found with ID: ${storyId}`
                    };
                } else {
                    error.value = {
                        title: 'Error Loading Story',
                        message: 'Failed to load story details. Please try again.'
                    };
                }
            } finally {
                loading.value = false;
            }
        };

        // Format Category
        const formatCategory = (category) => {
            if (!category) return '';
            return category
                .replace(/_/g, ' ')
                .replace(/\b\w/g, l=> l.toUpperCase());
        };

        onMounted(() => {
            fetchStory();
        });

        return {
            story,
            loading,
            error,
            formatCategory
        }
    }
}
</script>

<style scoped>
.story-detail-page {
  max-width: 900px;
  margin: 0 auto;
  padding: 2rem;
}

.back-nav {
  margin-bottom: var(--spacing-lg);
}

.back-link {
  display: inline-flex;
  align-items: center;
  color: var(--color-secondary);
  text-decoration: none;
  font-weight: 600;
  transition: color var(--transition-fast);
}

.back-link:hover {
  color: var(--color-accent-amber);
}

/* Loading and Error States */
.loading,
.error-state {
  text-align: center;
  padding: var(--spacing-2xl);
}

.error-state {
  background-color: var(--color-error-bg);
  border: 1px solid var(--color-error);
  border-radius: var(--radius-lg);
}

.error-state h2 {
  color: var(--color-error);
  border: none;
}

.btn-primary {
  display: inline-block;
  margin-top: var(--spacing-lg);
  padding: var(--spacing-sm) var(--spacing-lg);
  background-color: var(--color-accent-amber);
  color: white;
  text-decoration: none;
  border-radius: var(--radius-md);
  font-weight: 600;
  transition: background-color var(--transition-base);
}

.btn-primary:hover {
  background-color: var(--color-accent-amber-dark);
}

/* Story Content */
.story-content {
  background-color: var(--color-bg-primary);
  border-radius: var(--radius-lg);
  padding: var(--spacing-2xl);
  box-shadow: var(--shadow-md);
}

.story-header {
  margin-bottom: var(--spacing-2xl);
  padding-bottom: var(--spacing-lg);
  border-bottom: 3px solid var(--color-primary);
}

.story-header h1 {
  color: var(--color-primary);
  font-size: 2.5rem;
  margin-bottom: var(--spacing-sm);
}

.story-id {
  color: var(--color-text-secondary);
  font-size: 0.875rem;
  font-family: monospace;
}

/* Story Sections */
.story-section {
  margin-bottom: var(--spacing-2xl);
}

.story-section h2 {
  color: var(--color-secondary);
  font-size: 1.5rem;
  margin-bottom: var(--spacing-md);
  border-bottom: 2px solid var(--color-border);
  padding-bottom: var(--spacing-sm);
}

.story-section p {
  line-height: 1.8;
  color: var(--color-text-primary);
  font-size: 1.05rem;
}

/* Section Variations */
.story-section.challenge {
  background-color: var(--color-warning-bg);
  padding: var(--spacing-lg);
  border-radius: var(--radius-md);
  border-left: 4px solid var(--color-warning);
}

.story-section.solution {
  background-color: var(--color-info-bg);
  padding: var(--spacing-lg);
  border-radius: var(--radius-md);
  border-left: 4px solid var(--color-info);
}

.story-section.outcome {
  background-color: var(--color-success-bg);
  padding: var(--spacing-lg);
  border-radius: var(--radius-md);
  border-left: 4px solid var(--color-success);
}

/* Impact Highlight */
.impact-highlight {
  background: linear-gradient(135deg, var(--color-accent-amber) 0%, var(--color-accent-coral) 100%);
  color: white;
  padding: var(--spacing-xl);
  border-radius: var(--radius-lg);
  margin-bottom: var(--spacing-2xl);
  text-align: center;
}

.impact-highlight h3 {
  margin-bottom: var(--spacing-md);
  font-size: 1.25rem;
}

.impact-highlight p {
  font-size: 1.25rem;
  font-weight: 600;
}

/* Skills Section */
.skills-section {
  margin-bottom: var(--spacing-2xl);
}

.skills-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: var(--spacing-lg);
}

.skill-card {
  background-color: var(--color-bg-tertiary);
  padding: var(--spacing-lg);
  border-radius: var(--radius-md);
  border: 1px solid var(--color-border);
}

.skill-card h3 {
  color: var(--color-text-primary);
  font-size: 1.125rem;
  margin-bottom: var(--spacing-sm);
}

.proficiency-badge {
  display: inline-block;
  padding: var(--spacing-xs) var(--spacing-sm);
  border-radius: var(--radius-sm);
  font-size: 0.875rem;
  font-weight: 600;
  text-transform: capitalize;
  margin-bottom: var(--spacing-sm);
}

.proficiency-badge.expert {
  background-color: var(--color-skill-expert);
  color: white;
}

.proficiency-badge.proficient {
  background-color: var(--color-skill-proficient);
  color: white;
}

.proficiency-badge.developing {
  background-color: var(--color-skill-developing);
  color: white;
}

.skill-category {
  color: var(--color-text-secondary);
  font-size: 0.875rem;
  margin-top: var(--spacing-xs);
}

/* Work History Section */
.work-section {
  margin-bottom: var(--spacing-2xl);
}

.work-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-lg);
}

.work-item {
  background-color: var(--color-bg-secondary);
  padding: var(--spacing-lg);
  border-radius: var(--radius-md);
  border-left: 4px solid var(--color-primary);
}

.work-item h3 {
  color: var(--color-text-primary);
  margin-bottom: var(--spacing-xs);
}

.work-company {
  color: var(--color-secondary);
  font-weight: 600;
  margin-bottom: var(--spacing-xs);
}

.work-dates {
  color: var(--color-text-secondary);
  font-size: 0.875rem;
  font-style: italic;
}

.work-section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: var(--spacing-lg);
}

.view-all-work {
  color: var(--color-secondary);
  text-decoration: none;
  font-weight: 600;
  font-size: 0.9rem;
  transition: color var(--transition-fast);
}

.view-all-work:hover {
  color: var(--color-accent-amber);
}

.work-context-note {
  margin-top: var(--spacing-md);
  padding: var(--spacing-sm) var(--spacing-md);
  background-color: var(--color-bg-secondary);
  border-radius: var(--radius-sm);
  font-style: italic;
  color: var(--color-text-secondary);
  font-size: 0.9rem;
}

/* Mobile Responsive */
@media (max-width: 768px) {
  .story-detail-page {
    padding: 1rem;
  }
  
  .story-content {
    padding: var(--spacing-lg);
  }
  
  .story-header h1 {
    font-size: 2rem;
  }
  
  .skills-grid {
    grid-template-columns: 1fr;
  }
}


</style>