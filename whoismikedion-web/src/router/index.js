import { createRouter, createWebHistory } from 'vue-router'
import ProfilePage from '../views/ProfilePage.vue'

const routes = [
  {
    path: '/',
    name: 'profile',
    component: ProfilePage,
    meta: {title: 'Profile - Who Is Mike Dion?'}
  },
  {
    path: '/stories',
    name: 'stories',
    component: () => import('../views/StoriesPage.vue'),
    meta: {title: 'Stories - Who Is Mike Dion?'}
  },
  {
    path: '/stories/:story_id',
    name: 'story-detail',
    component: () => import('../views/StoryDetailPage.vue'),
    meta: {title: 'Story Detail - Who Is Mike Dion?'}
  },
  {
    path: '/:pathMatch(.*)*',
    name: 'not-found',
    component: () => import('../views/NotFoundPage.vue'),
    meta: {title: '404 Not Found - Who Is Mike Dion?'}
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
})

export default router
