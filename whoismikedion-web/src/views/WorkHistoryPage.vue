<template>
  <div class="work-page">
    <div class="container">

      <!-- PAGE HEADER -->
      <header class="page-header">
        <h1>Work History</h1>
        <p class="page-subtitle">
          Career progression in product management, systems thinking, and technical delivery
        </p>
      </header>

      <!-- Loading State -->
      <div v-if="loading" class="loading">
        <p>Loading work history...</p>
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="error-state">
        <p>{{ error }}</p>
        <button class="btn btn-primary" @click="fetchWorkHistory">Retry</button>
      </div>

      <!-- Timeline -->
      <div v-else-if="jobs.length > 0" class="timeline">

        <div
          v-for="(job, index) in jobs"
          :key="job.id"
          class="timeline-item"
        >
          <!-- Timeline Dot -->
          <div class="timeline-dot">
            <div class="dot-inner" :class="{ 'dot-current': job.is_current }"></div>
          </div>

          <!-- Date Column (visible on desktop) -->
          <div class="timeline-date">
            <span class="date-text">{{ job.dates }}</span>
            <span class="duration-text">{{ formatDuration(job.duration_months) }}</span>
          </div>

          <!-- Job Card -->
          <div class="job-card card">
            <!-- Mobile Date (hidden on desktop) -->
            <div class="job-date-mobile">
              <span class="date-text">{{ job.dates }}</span>
              <span class="duration-text">{{ formatDuration(job.duration_months) }}</span>
            </div>

            <!-- Header -->
            <div class="job-header">
              <div class="job-titles">
                <h2 class="job-title">{{ job.title }}</h2>
                <h3 class="company-name">{{ job.company }}</h3>
              </div>
              <span v-if="job.is_current" class="current-badge">Current</span>
            </div>

            <!-- Accomplishments (expandable on mobile) -->
            <details
              v-if="job.key_accomplishments?.length"
              class="accomplishments-section"
              :open="index === 0"
            >
              <summary class="accomplishments-header">
                Key Accomplishments
                <span class="expand-icon"></span>
              </summary>
              <ul class="accomplishments-list">
                <li
                  v-for="(accomplishment, idx) in job.key_accomplishments"
                  :key="idx"
                >
                  {{ accomplishment }}
                </li>
              </ul>
            </details>

            <!-- Related Stories -->
            <div v-if="job.stories?.length" class="related-stories">
              <h4 class="stories-header">
                Related Stories
                <span class="story-count">{{ job.story_count }}</span>
              </h4>
              <div class="story-links">
                <router-link
                  v-for="story in job.stories"
                  :key="story.story_id"
                  :to="`/stories/${story.story_id}`"
                  class="story-link"
                >
                  {{ story.title }}
                </router-link>
              </div>
            </div>
          </div>
        </div>

      </div>

      <!-- Empty State -->
      <div v-else class="empty-state">
        <p>No work history available.</p>
      </div>

    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import config from '@/config';

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

        const response = await axios.get(`${config.API_BASE}/work-history`);
        jobs.value = response.data.jobs;
      } catch (err) {
        console.error('Failed to fetch work history:', err);
        error.value = 'Failed to load work history. Please try again.';
      } finally {
        loading.value = false;
      }
    };

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
      formatDuration,
    };
  },
};
</script>

<style scoped>
/* ============================================
   WORK HISTORY PAGE - Mobile First
   ============================================ */

.work-page {
  padding: var(--spacing-4) 0;
}

@media (min-width: 640px) {
  .work-page {
    padding: var(--spacing-8) 0;
  }
}

/* ============================================
   PAGE HEADER
   ============================================ */

.page-header {
  text-align: center;
  margin-bottom: var(--spacing-10);
}

.page-subtitle {
  color: var(--color-text-muted);
  font-size: var(--text-lg);
  max-width: 500px;
  margin: 0 auto;
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
  padding: var(--spacing-16);
  color: var(--color-text-muted);
}

/* ============================================
   TIMELINE - Mobile First (left-aligned)
   ============================================ */

.timeline {
  position: relative;
  padding-left: var(--spacing-8);
}

/* Vertical line */
.timeline::before {
  content: '';
  position: absolute;
  left: var(--spacing-4);
  top: 0;
  bottom: 0;
  width: 2px;
  background: var(--color-border);
}

.timeline-item {
  position: relative;
  margin-bottom: var(--spacing-8);
}

.timeline-item:last-child {
  margin-bottom: 0;
}

/* ============================================
   TIMELINE DOT
   ============================================ */

.timeline-dot {
  position: absolute;
  left: calc(-1 * var(--spacing-8) + var(--spacing-4) - 12px);
  top: var(--spacing-4);
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.dot-inner {
  width: 12px;
  height: 12px;
  border-radius: var(--radius-full);
  background: var(--color-primary);
  border: 3px solid var(--color-bg-primary);
  box-shadow: 0 0 0 2px var(--color-primary-subtle);
}

.dot-current {
  width: 16px;
  height: 16px;
  box-shadow: 0 0 0 4px var(--color-primary-subtle);
}

/* ============================================
   DATE COLUMN (hidden on mobile)
   ============================================ */

.timeline-date {
  display: none;
}

/* ============================================
   JOB CARD
   ============================================ */

.job-card {
  position: relative;
}

/* Mobile date display */
.job-date-mobile {
  display: flex;
  flex-wrap: wrap;
  gap: var(--spacing-2);
  margin-bottom: var(--spacing-3);
}

.date-text {
  color: var(--color-text-primary);
  font-weight: 600;
  font-size: var(--text-sm);
}

.duration-text {
  color: var(--color-text-muted);
  font-size: var(--text-sm);
}

/* Job Header */
.job-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: var(--spacing-4);
  margin-bottom: var(--spacing-4);
}

.job-titles {
  flex: 1;
}

.job-title {
  font-size: var(--text-xl);
  font-weight: 700;
  margin-bottom: var(--spacing-1);
}

.company-name {
  font-size: var(--text-base);
  font-weight: 600;
  color: var(--color-primary);
  margin: 0;
}

.current-badge {
  display: inline-block;
  background: var(--color-success);
  color: var(--color-text-primary);
  padding: var(--spacing-1) var(--spacing-3);
  border-radius: var(--radius-full);
  font-size: var(--text-xs);
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  flex-shrink: 0;
}

/* ============================================
   ACCOMPLISHMENTS (Expandable)
   ============================================ */

.accomplishments-section {
  margin-bottom: var(--spacing-4);
  background: var(--color-bg-secondary);
  border-radius: var(--radius-lg);
  overflow: hidden;
}

.accomplishments-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--spacing-3) var(--spacing-4);
  cursor: pointer;
  font-size: var(--text-sm);
  font-weight: 600;
  color: var(--color-text-primary);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  list-style: none;
}

.accomplishments-header::-webkit-details-marker {
  display: none;
}

.expand-icon {
  width: 0;
  height: 0;
  border-left: 5px solid transparent;
  border-right: 5px solid transparent;
  border-top: 5px solid var(--color-text-muted);
  transition: transform var(--transition-fast);
}

details[open] .expand-icon {
  transform: rotate(180deg);
}

.accomplishments-list {
  padding: 0 var(--spacing-4) var(--spacing-4) var(--spacing-8);
  margin: 0;
}

.accomplishments-list li {
  color: var(--color-text-secondary);
  font-size: var(--text-sm);
  line-height: 1.6;
  margin-bottom: var(--spacing-2);
}

.accomplishments-list li:last-child {
  margin-bottom: 0;
}

/* ============================================
   RELATED STORIES
   ============================================ */

.related-stories {
  padding: var(--spacing-4);
  background: var(--color-primary-subtle);
  border-radius: var(--radius-lg);
  border-left: 3px solid var(--color-primary);
}

.stories-header {
  display: flex;
  align-items: center;
  gap: var(--spacing-2);
  font-size: var(--text-sm);
  font-weight: 600;
  color: var(--color-primary);
  margin-bottom: var(--spacing-3);
}

.story-count {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 20px;
  height: 20px;
  background: var(--color-primary);
  color: var(--color-text-primary);
  border-radius: var(--radius-full);
  font-size: var(--text-xs);
  font-weight: 700;
}

.story-links {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-2);
}

.story-link {
  color: var(--color-text-secondary);
  font-size: var(--text-sm);
  text-decoration: none;
  padding: var(--spacing-2);
  border-radius: var(--radius-md);
  transition: background-color var(--transition-fast), color var(--transition-fast);
}

.story-link:hover {
  background: var(--color-bg-tertiary);
  color: var(--color-primary);
}

/* ============================================
   DESKTOP STYLES
   ============================================ */

@media (min-width: 768px) {
  .timeline {
    padding-left: 0;
    max-width: 900px;
    margin: 0 auto;
  }

  .timeline::before {
    left: 50%;
    transform: translateX(-50%);
  }

  .timeline-item {
    display: grid;
    grid-template-columns: 1fr 32px 1fr;
    gap: var(--spacing-6);
    align-items: start;
  }

  .timeline-dot {
    position: static;
    grid-column: 2;
    grid-row: 1;
    width: 32px;
    height: 32px;
    margin-top: var(--spacing-4);
  }

  .dot-inner {
    width: 16px;
    height: 16px;
  }

  .dot-current {
    width: 20px;
    height: 20px;
  }

  /* Date column visible on desktop */
  .timeline-date {
    display: flex;
    flex-direction: column;
    padding-top: var(--spacing-4);
    gap: var(--spacing-1);
  }

  .timeline-date .date-text {
    font-size: var(--text-base);
  }

  /* Odd items: date on left, card on right */
  .timeline-item:nth-child(odd) .timeline-date {
    grid-column: 1;
    grid-row: 1;
    text-align: right;
    align-items: flex-end;
  }

  .timeline-item:nth-child(odd) .job-card {
    grid-column: 3;
    grid-row: 1;
  }

  /* Even items: card on left, date on right */
  .timeline-item:nth-child(even) .timeline-date {
    grid-column: 3;
    grid-row: 1;
    text-align: left;
    align-items: flex-start;
  }

  .timeline-item:nth-child(even) .job-card {
    grid-column: 1;
    grid-row: 1;
  }

  /* Hide mobile date on desktop */
  .job-date-mobile {
    display: none;
  }

  .job-title {
    font-size: var(--text-2xl);
  }
}
</style>
