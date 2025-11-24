<template>
    <router-link
        :to="`/stories/${story.story_id}`"
        class="story-card"
    >
        <!-- Story Title -->
        <h3 class="story-title">{{ story.title }}</h3>

        <!-- Story Summary -->
        <p class="story-summary">{{ story.summary }}</p>

        <!-- Skill Tags -->
         <div class="skills-section" v-if="story.skills && story.skills.length > 0">
            <span class="skill-label">Demonstrates:</span>
            <div class="skill-tags">
                <span
                    v-for="skill in story.skills"
                    :key ="skill"
                    class="skill-tag"
                >
                    {{  formatSkillName(skill) }}
                </span>
            </div>
         </div>

         <!--Quantifiable Impact -->
         <div class="impact-section" v-if="story.quantifiable_impact">
            <strong>Impact:</strong> {{  story.quantifiable_impact }}
         </div>
    </router-link>
</template>

<script>
export default {
    name: 'StoryCard',

    props: {
        story: {
            type: Object,
            required: true
        }
    },

    methods: {
        formatSkillName(skillId) {
            return skillId
                .split('-')
                .map(word => word.charAt(0).toUpperCase() + word.slice(1))
                .join(' ');
        }
    }
} 
</script>

<style scoped>
.story-card {
  display: block;
  background-color: var(--color-bg-primary);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: var(--spacing-lg);
  margin-bottom: var(--spacing-lg);
  text-decoration: none;
  color: inherit;
  transition: all var(--transition-base);
  box-shadow: var(--shadow-md);
}

.story-card:hover {
  box-shadow: var(--shadow-lg);
  transform: translateY(-2px);
  border-color: var(--color-primary);
}

.story-title {
  color: var(--color-primary);
  font-size: 1.5rem;
  margin-bottom: var(--spacing-sm);
}

.story-summary {
  color: var(--color-text-primary);
  margin-bottom: var(--spacing-md);
  line-height: 1.6;
}

.skills-section {
  margin-bottom: var(--spacing-md);
}

.skill-label {
  font-size: 0.875rem;
  color: var(--color-text-secondary);
  font-weight: 600;
  display: block;
  margin-bottom: var(--spacing-xs);
}

.skills-tags {
  display: flex;
  flex-wrap: wrap;
  gap: var(--spacing-sm);
}

.skill-tag {
  background-color: var(--color-secondary);
  color: white;
  padding: var(--spacing-xs) var(--spacing-sm);
  border-radius: var(--radius-sm);
  font-size: 0.875rem;
  font-weight: 600;
}

.impact-section {
  padding: var(--spacing-sm);
  background-color: var(--color-bg-secondary);
  border-radius: var(--radius-md);
  font-size: 0.9rem;
  color: var(--color-text-primary);
}

.impact-section strong {
  color: var(--color-accent-amber);
}

/* Mobile responsive */
@media (max-width: 768px) {
  .story-title {
    font-size: 1.25rem;
  }
  
  .story-summary {
    font-size: 0.9rem;
  }
}
</style>