<template>
    <div class="work-history-page">

        <!-- PAGE HEADER -->
        <div class="page-header">
            <h1>Work History</h1>
            <p class="tagline">
                Career progression in product management, systems thinking, and technical delivery
            </p>
        </div>

        <!-- Loading State -->
        <div v-if="loading" class="loading">
            <p>Loading work history...</p>
        </div>

        <!-- ERROR State -->
        <div v-else-if="error" class="error">
            <p>{{ error }}</p>
            <button @click="fetchWorkHistory" class="retry-button">Retry</button>
        </div>

        <!-- Timeline -->
        <div v-else-if="jobs.length > 0" class="timeline">

            <!-- JOB CARD -->
            <div
                v-for="job in jobs"
                :key="job.id"
                class="job-card"
            >

                <!-- TIMELINE DOT -->
                <div class="timeline-dot"></div>

                <!-- JOB CONTENT -->
                <div class="job-content">
                    <!-- HEADER -->
                    <div class="job-header">
                        <div class="job-title-section">
                            <h2 class="job-title">{{ job.title }}</h2>
                            <h3 class="company-name">{{ job.company }}</h3>
                        </div>

                        <span v-if="job.is_current" class="current-badge">
                            Current
                        </span>
                    </div>

                    <!-- DATES & DURATION -->
                    <div class="job-meta">
                        <span class="date-range">{{ job.dates }}</span>
                        <span class="duration">{{ formatDuration(job.duration_months) }}</span>
                    </div>

                    <!-- KEY ACCOMPLISHMENTS -->
                    <div
                        v-if="job.key_accomplishments && job.key_accomplishments.length > 0"
                        class="accomplishments"
                    >
                        <h4>Key Accomplishments</h4>
                        <ul>
                            <li
                                v-for="(accomplishment, index) in job.key_accomplishments"
                                :key="index"
                            >
                                {{ accomplishment }}
                            </li>
                        </ul>
                    </div>

                    <!-- RELATED STORIES -->
                    <div
                        v-if="job.stories && job.stories.length > 0"
                        class="related-stories"
                    >
                        <h4>
                            Related Success stories
                            <span class="story-count-badge">{{ job.story_count }}</span>
                        </h4>

                        <div class="story-links">
                            <router-link
                                v-for="story in job.stories"
                                :key="story.story_id"
                                :to="`/stories/${story.story_id}`"
                                class="story-link"
                            >
                                → {{ story.title }}
                            </router-link>
                        </div>

                    </div>

                </div>

            </div>
        </div>

        <!-- EMPTY STATE -->
        <div v-else class="empty-state">
            <p>No work history found.</p>
        </div>

    </div>
</template>

<script>
import {ref, onMounted } from 'vue';
import axios from 'axios';

export default {
    name: 'WorkHistoryPage',

    setup() {
        const jobs = ref([]);
        const loading = ref(true);
        const error = ref(null);

        const fetchWorkHistory = async () => {
            try {
                loading.value = true;
                error.value = null;

                console.log('Fetching work history...');

                const response = await axios.get('http://localhost:3000/api/work-history');
                jobs.value = response.data.jobs;

                console.log(`Loaded ${jobs.value.length} jobs`);

            } catch (err) {
                console.error('Failed to fetch work history:', err);
                error.value = 'Failed to load work history.';
            } finally {
                loading.value = false;
            }
        };

        // Format duration from months to "X yrs Y mo"
        const formatDuration = (months) => {
            const years = Math.floor(months / 12);
            const remainingMonths = months % 12;
            
            if (years === 0) {
                return `${months} mo`;
            } else if (remainingMonths === 0) {
                return `${years} ${years === 1 ? 'yr' : 'yrs'}`;
            } else {
                return `${years} ${years === 1 ? 'yr' : 'yrs'} ${remainingMonths} mo`;
            }
        };

        onMounted(() => {
            fetchWorkHistory();
        });

        return {
            jobs,
            loading,
            error,
            fetchWorkHistory,
            formatDuration
        };
    }
}

</script>


<style scoped>
.work-history-page {
  max-width: 1000px;
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

/* Loading and Error States */
.loading,
.error {
  text-align: center;
  padding: var(--spacing-2xl);
}

.error {
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

/* Timeline */
.timeline {
  position: relative;
  padding-left: 2rem;
}

/* Vertical line connecting jobs */
.timeline::before {
  content: '';
  position: absolute;
  left: 0.75rem;
  top: 0;
  bottom: 0;
  width: 2px;
  background-color: var(--color-border-dark);
}

/* Job Card */
.job-card {
  position: relative;
  margin-bottom: var(--spacing-2xl);
}

/* Timeline Dot */
.timeline-dot {
  position: absolute;
  left: -1.5rem;
  top: 0.5rem;
  width: 1rem;
  height: 1rem;
  border-radius: 50%;
  background-color: var(--color-primary);
  border: 3px solid var(--color-bg-primary);
  z-index: 1;
}

/* Job Content Card */
.job-content {
  background-color: var(--color-bg-primary);
  border: 1px solid var(--color-border);
  border-left: 4px solid var(--color-primary);
  border-radius: var(--radius-lg);
  padding: var(--spacing-xl);
  box-shadow: var(--shadow-md);
  transition: box-shadow var(--transition-base);
}

.job-content:hover {
  box-shadow: var(--shadow-lg);
}

/* Job Header */
.job-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: var(--spacing-md);
  flex-wrap: wrap;
  gap: var(--spacing-md);
}

.job-title-section {
  flex: 1;
  min-width: 200px;
}

.job-title {
  color: var(--color-text-primary);
  font-size: 1.5rem;
  margin: 0 0 var(--spacing-xs) 0;
}

.company-name {
  color: var(--color-secondary);
  font-size: 1.25rem;
  font-weight: 600;
  margin: 0;
}

.current-badge {
  display: inline-block;
  background: linear-gradient(135deg, var(--color-accent-amber) 0%, var(--color-accent-coral) 100%);
  color: white;
  padding: var(--spacing-xs) var(--spacing-md);
  border-radius: var(--radius-full);
  font-size: 0.875rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* Job Meta */
.job-meta {
  display: flex;
  gap: var(--spacing-lg);
  margin-bottom: var(--spacing-lg);
  flex-wrap: wrap;
}

.date-range {
  color: var(--color-text-primary);
  font-weight: 600;
  font-size: 1rem;
}

.duration {
  color: var(--color-text-secondary);
  font-style: italic;
  font-size: 0.9rem;
}

/* Accomplishments */
.accomplishments {
  margin-bottom: var(--spacing-lg);
  padding: var(--spacing-md);
  background-color: var(--color-bg-secondary);
  border-radius: var(--radius-md);
}

.accomplishments h4 {
  color: var(--color-text-primary);
  font-size: 1rem;
  margin: 0 0 var(--spacing-sm) 0;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  font-weight: 600;
}

.accomplishments ul {
  margin: 0;
  padding-left: var(--spacing-lg);
}

.accomplishments li {
  color: var(--color-text-primary);
  line-height: 1.6;
  margin-bottom: var(--spacing-sm);
}

.accomplishments li:last-child {
  margin-bottom: 0;
}

/* Related Stories */
.related-stories {
  padding: var(--spacing-md);
  background-color: var(--color-info-bg);
  border-radius: var(--radius-md);
  border-left: 3px solid var(--color-secondary);
}

.related-stories h4 {
  color: var(--color-secondary);
  font-size: 1rem;
  margin: 0 0 var(--spacing-md) 0;
  display: flex;
  align-items: center;
  gap: var(--spacing-sm);
}

.story-count-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background-color: var(--color-secondary);
  color: white;
  width: 1.5rem;
  height: 1.5rem;
  border-radius: 50%;
  font-size: 0.875rem;
  font-weight: 700;
}

.story-links {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-sm);
}

.story-link {
  color: var(--color-secondary);
  text-decoration: none;
  font-weight: 500;
  transition: all var(--transition-fast);
  padding: var(--spacing-xs) var(--spacing-sm);
  border-radius: var(--radius-sm);
}

.story-link:hover {
  color: var(--color-accent-amber);
  background-color: rgba(224, 122, 95, 0.1);
  padding-left: var(--spacing-md);
}

/* Empty State */
.empty-state {
  text-align: center;
  padding: var(--spacing-2xl);
  background-color: var(--color-bg-tertiary);
  border-radius: var(--radius-lg);
  color: var(--color-text-secondary);
}

/* Mobile Responsive */
@media (max-width: 768px) {
  .work-history-page {
    padding: 1rem;
  }
  
  .page-header h1 {
    font-size: 2rem;
  }
  
  .timeline {
    padding-left: 1.5rem;
  }
  
  .timeline::before {
    left: 0.5rem;
  }
  
  .timeline-dot {
    left: -1.25rem;
    width: 0.75rem;
    height: 0.75rem;
  }
  
  .job-content {
    padding: var(--spacing-lg);
  }
  
  .job-header {
    flex-direction: column;
  }
  
  .job-title {
    font-size: 1.25rem;
  }
  
  .company-name {
    font-size: 1.125rem;
  }
}
</style>