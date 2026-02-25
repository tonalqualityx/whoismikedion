<template>
  <div class="personality-page">
    <div class="container">
      <header class="page-header">
        <h1 class="page-title">How I'm Wired</h1>
        <p class="page-subtitle">
          I've spent a lot of time understanding how I operate. What energizes me, what drains me, and what kind of work brings out my best. Here's the short version.
        </p>
      </header>

      <nav class="section-nav" ref="sectionNav">
        <a
          v-for="section in sections"
          :key="section.id"
          :href="'#' + section.id"
          class="section-nav-link"
          :class="{ active: activeSection === section.id }"
          @click.prevent="scrollToSection(section.id)"
        >
          {{ section.label }}
        </a>
      </nav>

      <section id="lead-with" class="page-section">
        <h2 class="section-title">What I Lead With</h2>
        <p class="section-intro">
          These are my top 5 CliftonStrengths (Gallup). They're the patterns that show up in everything I do: how I make decisions, how I work with teams, and what kind of problems I gravitate toward.
        </p>
        <div class="strengths-list">
          <details
            v-for="(strength, index) in topStrengths"
            :key="strength.name"
            class="strength-card strength-card--primary"
            :open="index === 0"
          >
            <summary class="strength-header">
              <span class="strength-rank strength-rank--primary">{{ strength.rank }}</span>
              <span class="strength-name">{{ strength.name }}</span>
              <span class="expand-icon"></span>
            </summary>
            <div class="strength-body">
              <p>{{ strength.description }}</p>
            </div>
          </details>
        </div>
      </section>

      <section id="dont-lead-with" class="page-section">
        <h2 class="section-title">What I Don't Lead With</h2>
        <p class="section-intro">
          These matter just as much. They're not weaknesses. They're things I don't rely on, which tells you a lot about what kind of teammate and leader I am.
        </p>
        <div class="strengths-list">
          <details
            v-for="strength in bottomStrengths"
            :key="strength.name"
            class="strength-card strength-card--secondary"
          >
            <summary class="strength-header">
              <span class="strength-rank strength-rank--secondary">{{ strength.rank }}</span>
              <span class="strength-name">{{ strength.name }}</span>
              <span class="expand-icon"></span>
            </summary>
            <div class="strength-body">
              <p>{{ strength.description }}</p>
            </div>
          </details>
        </div>
      </section>

      <section id="the-pattern" class="page-section">
        <h2 class="section-title">The Pattern</h2>
        <p class="section-intro">Everything above points in the same direction.</p>
        <div class="pattern-callout">
          <p>
            I'm built for understanding systems, learning quickly, developing people, fixing what's broken, and staying true to what I believe in. I'm not built for claiming authority, competing for status, or performing for recognition.
          </p>
          <p>
            In practice, this means I'm the person who listens in meetings, asks the question nobody thought to ask, and then quietly builds the thing that solves the actual problem. I won't be the loudest voice in the room. But I'll be the one who noticed what everyone else missed.
          </p>
        </div>
      </section>

      <section id="how-i-work-best" class="page-section">
        <h2 class="section-title">How I Work Best</h2>
        <div class="workstyle-grid">
          <div
            v-for="item in howIWorkBest"
            :key="item.title"
            class="workstyle-card"
          >
            <h3 class="workstyle-title">{{ item.title }}</h3>
            <p class="workstyle-description">{{ item.description }}</p>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const topStrengths = [
  {
    rank: 1,
    name: 'Belief',
    description: "I need to understand why we're building something before I can commit to how. When I can connect the work to something that matters, I'll run through walls for it. The conviction isn't performative. It's just how I'm wired."
  },
  {
    rank: 2,
    name: 'Learner',
    description: "I'm at my best in the first 80% of understanding something new. I read technical manuals, leadership books, and product frameworks because the learning itself energizes me. I don't need a test at the end to justify it."
  },
  {
    rank: 3,
    name: 'Intellection',
    description: "I process internally. I plan for conversations relentlessly beforehand and replay them afterward looking for what I missed. I run parallel threads on a problem until something clicks. From the outside it can look like silence, but the work is happening."
  },
  {
    rank: 4,
    name: 'Developer',
    description: "I notice potential before most people do, whether it's in a person, a product, or a system. And I'm drawn to growing it. My 97-98% client retention isn't because I'm a great salesperson. It's because I invest in making things better over time rather than chasing new."
  },
  {
    rank: 5,
    name: 'Restorative',
    description: "I'm energized by things that are broken. Hand me something that doesn't work and I'll troubleshoot it until it does. When my company hit a rough stretch and I had the chance to walk away or rebuild, I rebuilt. I couldn't leave it broken."
  }
]

const bottomStrengths = [
  {
    rank: 34,
    name: 'Significance',
    description: "I don't need to be recognized. I need the work to matter."
  },
  {
    rank: 33,
    name: 'Command',
    description: "I don't lead by authority. I lead by making the work clear enough that people want to follow it."
  },
  {
    rank: 32,
    name: 'Competition',
    description: "I'm not trying to beat anyone. I'm trying to build something good."
  },
  {
    rank: 31,
    name: 'Maximizer',
    description: "I'd rather fix what's broken than polish what's already working. Hand me the messy problem, not the optimization project."
  },
  {
    rank: 30,
    name: 'Deliberative',
    description: "I do my thinking up front (that's Intellection) but I don't wait for a risk-free path before acting. I'd rather move, learn, and adjust than try to anticipate every possible downside in advance."
  }
]

const howIWorkBest = [
  {
    title: 'Give me the why.',
    description: "If I understand what we're solving and who it's for, I'll figure out the how. If I don't have the why, I'll keep asking until I do."
  },
  {
    title: 'Give me ambiguity over bureaucracy.',
    description: "I'd rather navigate an unclear problem than follow a rigid process. Constraints are fine. I do my best work inside them. But prescribed steps without a clear reason drain me."
  },
  {
    title: 'Give me room to go deep.',
    description: "I need thinking time. It looks like nothing from the outside, but it's where the best work happens. I'll come back with something better than if I'd rushed to fill the silence."
  },
  {
    title: 'Let me build trust before expecting performance.',
    description: "I need to understand the team, the norms, and the unwritten rules before I can operate at full speed. I ramp deliberately, and then I don't stop."
  }
]

const sections = [
  { id: 'lead-with', label: 'What I Lead With' },
  { id: 'dont-lead-with', label: "What I Don't Lead With" },
  { id: 'the-pattern', label: 'The Pattern' },
  { id: 'how-i-work-best', label: 'How I Work Best' }
]

const activeSection = ref('lead-with')
const sectionNav = ref(null)
let observer = null

const NAVBAR_HEIGHT = 64
const SECTION_NAV_HEIGHT = 48
const SCROLL_OFFSET = NAVBAR_HEIGHT + SECTION_NAV_HEIGHT + 16

function scrollToSection(id) {
  const el = document.getElementById(id)
  if (!el) return
  const top = el.getBoundingClientRect().top + window.scrollY - SCROLL_OFFSET
  window.scrollTo({ top, behavior: 'smooth' })
}

onMounted(() => {
  observer = new IntersectionObserver(
    (entries) => {
      for (const entry of entries) {
        if (entry.isIntersecting) {
          activeSection.value = entry.target.id
        }
      }
    },
    {
      rootMargin: `-${SCROLL_OFFSET}px 0px -60% 0px`,
      threshold: 0
    }
  )

  for (const section of sections) {
    const el = document.getElementById(section.id)
    if (el) observer.observe(el)
  }
})

onUnmounted(() => {
  if (observer) observer.disconnect()
})
</script>

<style scoped>
/* ============================================
   PAGE LAYOUT
   ============================================ */

.personality-page {
  min-height: 100vh;
  padding-bottom: var(--spacing-16);
}

.page-header {
  padding: var(--spacing-8) 0 var(--spacing-6);
}

.page-title {
  font-size: var(--text-3xl);
  font-weight: 800;
  color: var(--color-text-primary);
  margin-bottom: var(--spacing-3);
}

.page-subtitle {
  color: var(--color-text-secondary);
  font-size: var(--text-lg);
  line-height: 1.6;
  max-width: 640px;
  margin: 0;
}

.page-section {
  padding-top: var(--spacing-8);
}

.section-intro {
  color: var(--color-text-secondary);
  font-size: var(--text-base);
  line-height: 1.6;
  margin-bottom: var(--spacing-6);
  max-width: 640px;
}

/* ============================================
   SECTION NAV (Sticky)
   ============================================ */

.section-nav {
  position: sticky;
  top: 64px;
  z-index: 50;
  display: flex;
  gap: var(--spacing-1);
  overflow-x: auto;
  background: var(--color-bg-primary);
  border-bottom: 1px solid var(--color-border);
  padding: var(--spacing-3) 0;
  -ms-overflow-style: none;
  scrollbar-width: none;
}

.section-nav::-webkit-scrollbar {
  display: none;
}

.section-nav-link {
  white-space: nowrap;
  padding: var(--spacing-2) var(--spacing-3);
  font-size: var(--text-sm);
  font-weight: 500;
  color: var(--color-text-muted);
  text-decoration: none;
  border-radius: var(--radius-md);
  transition: color var(--transition-fast), background-color var(--transition-fast);
}

.section-nav-link:hover {
  color: var(--color-text-primary);
  background-color: var(--color-bg-tertiary);
}

.section-nav-link.active {
  color: var(--color-primary);
  background-color: var(--color-primary-subtle);
}

/* ============================================
   STRENGTH CARDS
   ============================================ */

.strengths-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-3);
}

.strength-card {
  background: var(--color-bg-tertiary);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  overflow: hidden;
}

.strength-card--primary {
  border-left: 4px solid var(--color-primary);
}

.strength-card--secondary {
  border-left: 4px solid transparent;
}

.strength-header {
  display: flex;
  align-items: center;
  gap: var(--spacing-3);
  padding: var(--spacing-3) var(--spacing-4);
  cursor: pointer;
  list-style: none;
  min-height: 44px;
}

.strength-header::-webkit-details-marker {
  display: none;
}

.strength-header::marker {
  display: none;
  content: '';
}

.strength-rank {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  font-size: var(--text-sm);
  font-weight: 800;
  flex-shrink: 0;
}

.strength-rank--primary {
  background-color: var(--color-primary-subtle);
  color: var(--color-primary);
}

.strength-rank--secondary {
  background-color: var(--color-bg-secondary);
  color: var(--color-text-muted);
}

.strength-name {
  font-weight: 600;
  font-size: var(--text-base);
  color: var(--color-text-primary);
  flex: 1;
}

.expand-icon {
  width: 0;
  height: 0;
  border-left: 5px solid transparent;
  border-right: 5px solid transparent;
  border-top: 5px solid var(--color-text-muted);
  transition: transform var(--transition-fast);
  flex-shrink: 0;
}

details[open] .expand-icon {
  transform: rotate(180deg);
}

.strength-body {
  padding: 0 var(--spacing-4) var(--spacing-4);
  padding-left: calc(var(--spacing-4) + 32px + var(--spacing-3));
}

.strength-body p {
  color: var(--color-text-secondary);
  font-size: var(--text-sm);
  line-height: 1.7;
  margin: 0;
}

/* ============================================
   PATTERN CALLOUT
   ============================================ */

.pattern-callout {
  background: var(--color-primary-subtle);
  border-left: 4px solid var(--color-primary);
  border-radius: var(--radius-lg);
  padding: var(--spacing-6);
}

.pattern-callout p {
  color: var(--color-text-primary);
  font-size: var(--text-lg);
  line-height: 1.7;
  margin: 0;
}

.pattern-callout p + p {
  margin-top: var(--spacing-4);
}

/* ============================================
   WORKSTYLE GRID
   ============================================ */

.workstyle-grid {
  display: grid;
  gap: var(--spacing-4);
}

.workstyle-card {
  background: var(--color-bg-tertiary);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: var(--spacing-4);
}

.workstyle-title {
  display: flex;
  align-items: center;
  gap: var(--spacing-2);
  font-size: var(--text-base);
  font-weight: 600;
  color: var(--color-text-primary);
  margin-bottom: var(--spacing-2);
}

.workstyle-title::before {
  content: '';
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background-color: var(--color-success);
  flex-shrink: 0;
}

.workstyle-description {
  color: var(--color-text-secondary);
  font-size: var(--text-sm);
  line-height: 1.7;
  margin: 0;
}

/* ============================================
   RESPONSIVE
   ============================================ */

@media (min-width: 640px) {
  .page-header {
    padding: var(--spacing-12) 0 var(--spacing-8);
  }

  .page-title {
    font-size: var(--text-4xl);
  }

  .strength-header {
    padding: var(--spacing-4) var(--spacing-5);
  }

  .strength-body {
    padding: 0 var(--spacing-5) var(--spacing-5);
    padding-left: calc(var(--spacing-5) + 32px + var(--spacing-3));
  }

  .pattern-callout {
    padding: var(--spacing-8);
  }

  .workstyle-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .workstyle-card {
    padding: var(--spacing-6);
  }
}

@media (min-width: 768px) {
  .page-section {
    padding-top: var(--spacing-12);
  }
}
</style>
