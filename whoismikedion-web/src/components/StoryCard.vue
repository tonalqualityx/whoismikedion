<template>
  <router-link
    :to="`/stories/${story.story_id}`"
    class="story-card card"
  >
    <!-- Story Title -->
    <h3 class="story-title">{{ story.title }}</h3>

    <!-- Story Summary -->
    <p class="story-summary">{{ story.summary }}</p>

    <!-- Skill Tags -->
    <div v-if="story.skills?.length" class="story-skills">
      <span
        v-for="skill in story.skills.slice(0, 4)"
        :key="skill"
        class="skill-tag skill-tag--primary"
      >
        {{ formatSkillName(skill) }}
      </span>
      <span
        v-if="story.skills.length > 4"
        class="skill-tag skill-tag--secondary"
      >
        +{{ story.skills.length - 4 }} more
      </span>
    </div>

    <!-- Quantifiable Impact -->
    <div v-if="story.quantifiable_impact" class="story-impact">
      <span class="impact-label">Impact:</span>
      <span class="impact-value">{{ story.quantifiable_impact }}</span>
    </div>
  </router-link>
</template>

<script>
export default {
  name: 'StoryCard',

  props: {
    story: {
      type: Object,
      required: true,
    },
  },

  methods: {
    formatSkillName(skillId) {
      return skillId
        .split('-')
        .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
        .join(' ');
    },
  },
};
</script>

<style scoped>
/* ============================================
   STORY CARD - Mobile First
   ============================================ */

.story-card {
  display: flex;
  flex-direction: column;
  text-decoration: none;
  color: inherit;
  height: 100%;
  transition: transform var(--transition-base), box-shadow var(--transition-base), border-color var(--transition-base);
}

.story-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
  border-color: var(--color-primary);
}

/* ============================================
   STORY TITLE
   ============================================ */

.story-title {
  color: var(--color-text-primary);
  font-size: var(--text-lg);
  font-weight: 700;
  margin-bottom: var(--spacing-2);
  line-height: 1.3;
  transition: color var(--transition-fast);
}

.story-card:hover .story-title {
  color: var(--color-primary);
}

/* ============================================
   STORY SUMMARY
   ============================================ */

.story-summary {
  color: var(--color-text-secondary);
  font-size: var(--text-sm);
  line-height: 1.6;
  margin-bottom: var(--spacing-4);
  flex-grow: 1;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* ============================================
   SKILL TAGS
   ============================================ */

.story-skills {
  display: flex;
  flex-wrap: wrap;
  gap: var(--spacing-2);
  margin-bottom: var(--spacing-4);
}

/* ============================================
   IMPACT SECTION
   ============================================ */

.story-impact {
  padding: var(--spacing-3);
  background: var(--color-success-subtle);
  border-radius: var(--radius-md);
  font-size: var(--text-sm);
  margin-top: auto;
}

.impact-label {
  color: var(--color-success);
  font-weight: 600;
  margin-right: var(--spacing-1);
}

.impact-value {
  color: var(--color-text-secondary);
}

/* ============================================
   DESKTOP STYLES
   ============================================ */

@media (min-width: 640px) {
  .story-title {
    font-size: var(--text-xl);
  }

  .story-summary {
    font-size: var(--text-base);
  }
}
</style>
