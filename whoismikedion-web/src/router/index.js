import { createRouter, createWebHistory } from 'vue-router'
import ProfilePage from '../views/ProfilePage.vue'
import ChatPage from '@/views/ChatPage.vue';

const DEFAULT_TITLE = 'Mike Dion - Product Leader & Technical Strategist';

const routes = [
  {
    path: '/',
    name: 'profile',
    component: ProfilePage,
    meta: {
      title: 'Mike Dion - Product Leader & Technical Strategist',
      description: 'Portfolio of Mike Dion - product leader specializing in product strategy, systems thinking, and technical delivery.'
    }
  },
  {
    path: '/stories',
    name: 'stories',
    component: () => import('../views/StoriesPage.vue'),
    meta: {
      title: 'Success Stories - Mike Dion',
      description: 'Real examples of product strategy and technical delivery from Mike Dion.'
    }
  },
  {
    path: '/stories/:story_id',
    name: 'story-detail',
    component: () => import('../views/StoryDetailPage.vue'),
    meta: {
      title: 'Story - Mike Dion',
      description: 'A success story from Mike Dion.'
    }
  },
  {
    path: '/work',
    name: 'work',
    component: () => import('../views/WorkHistoryPage.vue'),
    meta: {
      title: 'Work History - Mike Dion',
      description: 'Career progression in product management and technical delivery.'
    }
  },
  {
    path: '/personality',
    name: 'personality',
    component: () => import('../views/PersonalityPage.vue'),
    meta: {
      title: 'Personality - Mike Dion',
      description: 'How Mike Dion is wired - CliftonStrengths profile, work style, and what kind of teammate and leader he is.'
    }
  },
  {
    path: '/chat',
    name: 'Chat',
    component: ChatPage,
    meta: {
      title: 'Chat with Mike - Mike Dion',
      description: 'Start a conversation with Mike Dion\'s AI assistant.'
    }
  },
  {
    path: '/:pathMatch(.*)*',
    name: 'not-found',
    component: () => import('../views/NotFoundPage.vue'),
    meta: {
      title: '404 Not Found - Mike Dion',
      description: 'Page not found.'
    }
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
})

// Navigation guard for dynamic title and meta updates
router.afterEach((to) => {
  // Update document title
  document.title = to.meta.title || DEFAULT_TITLE;

  // Update meta description
  const descriptionMeta = document.querySelector('meta[name="description"]');
  if (descriptionMeta && to.meta.description) {
    descriptionMeta.setAttribute('content', to.meta.description);
  }

  // Update canonical URL
  const canonicalLink = document.querySelector('link[rel="canonical"]');
  if (canonicalLink) {
    canonicalLink.setAttribute('href', `https://whoismikedion.com${to.path}`);
  }

  // Update OG URL
  const ogUrl = document.querySelector('meta[property="og:url"]');
  if (ogUrl) {
    ogUrl.setAttribute('content', `https://whoismikedion.com${to.path}`);
  }
})

export default router
