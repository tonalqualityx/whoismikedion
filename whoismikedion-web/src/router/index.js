import { createRouter, createWebHistory } from 'vue-router'
import ProfilePage from '../views/ProfilePage.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'profile',
      component: ProfilePage
    }
  ],
})

export default router
