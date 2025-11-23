import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

// Styles
import './assets/styles/colors.css'
import './assets/styles/base.css'

const app = createApp(App)

app.use(router)

app.mount('#app')
