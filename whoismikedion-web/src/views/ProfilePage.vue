<template>
  <div class="profile-page">
    <div class="container">

      <!-- LOADING STATE -->
      <div v-if="loading" class="loading">
        <p>Loading profile...</p>
      </div>

      <!-- ERROR STATE -->
      <div v-else-if="error" class="error-state">
        <p>{{ error }}</p>
        <button class="btn btn-primary" @click="fetchProfile">Retry</button>
      </div>

      <!-- SUCCESS STATE -->
      <template v-else-if="profile">

        <!-- Profile Header -->
        <header class="profile-header">
          <img
            v-if="profile.photo_url"
            :src="profile.photo_url"
            :alt="profile.name"
            class="profile-avatar"
          />
          <div v-else class="profile-avatar-placeholder">
            {{ profile.name?.charAt(0) || 'M' }}
          </div>

          <h1 class="profile-name">{{ profile.name }}</h1>
          <p class="profile-tagline">{{ profile.tagline }}</p>

          <!-- Top Skills as Tags -->
          <div v-if="profile.top_skills?.length" class="profile-skills">
            <span
              v-for="skill in profile.top_skills"
              :key="skill.skill_id"
              :class="['skill-tag', `skill-tag--${skill.proficiency}`]"
            >
              {{ skill.name }}
            </span>
          </div>

          <!-- CTA Button -->
          <router-link to="/chat" class="btn btn-primary profile-cta">
            Start a Conversation
          </router-link>
        </header>

        <!-- Core Values Section -->
        <section v-if="profile.core_values?.length" class="profile-section">
          <h2 class="section-title">Core Values</h2>

          <div class="values-grid">
            <div
              v-for="value in profile.core_values"
              :key="value.value_text"
              class="value-card"
            >
              <h3 class="value-title">{{ value.value_text }}</h3>
              <p class="value-description">{{ value.description }}</p>
            </div>
          </div>
        </section>

        <!-- Quick Links Section -->
        <section class="profile-section">
          <h2 class="section-title">Explore More</h2>

          <div class="quick-links">
            <router-link to="/work" class="quick-link card">
              <h3>Work History</h3>
              <p>See my professional journey and experience</p>
            </router-link>

            <router-link to="/stories" class="quick-link card">
              <h3>Stories</h3>
              <p>Read about specific projects and achievements</p>
            </router-link>
          </div>
        </section>

      </template>

      <!-- NO DATA STATE -->
      <div v-else class="no-data">
        <p>No profile data available.</p>
      </div>

    </div>
  </div>
</template>

<script>
import { ref, onMounted, onUnmounted } from 'vue';
import axios from 'axios';
import config from '@/config';

export default {
  name: 'ProfilePage',

  setup() {
    const profile = ref(null);
    const loading = ref(false);
    const error = ref(null);
    let schemaScript = null;

    const injectPersonSchema = (profileData) => {
      if (schemaScript) schemaScript.remove();

      const schema = {
        "@context": "https://schema.org",
        "@type": "Person",
        "name": profileData.name || "Mike Dion",
        "url": "https://whoismikedion.com",
        "image": profileData.photo_url || "https://whoismikedion.com/open-graph.png",
        "jobTitle": "Product Leader & Technical Strategist",
        "description": profileData.tagline,
        "sameAs": [
          "https://www.linkedin.com/in/whoismikedion/"
        ],
        "knowsAbout": (profileData.top_skills || []).map(skill => skill.name)
      };

      schemaScript = document.createElement('script');
      schemaScript.type = 'application/ld+json';
      schemaScript.textContent = JSON.stringify(schema);
      document.head.appendChild(schemaScript);
    };

    const fetchProfile = async () => {
      try {
        loading.value = true;
        error.value = null;

        const response = await axios.get(`${config.API_BASE}/profile`);
        profile.value = response.data;

        // Inject Person schema with profile data
        injectPersonSchema(response.data);
      } catch (err) {
        console.error('Error fetching profile:', err);

        if (err.response) {
          error.value = `Server error: ${err.response.status}`;
        } else if (err.request) {
          error.value = 'Network error: Unable to connect to server';
        } else {
          error.value = 'Failed to load profile. Please try again.';
        }
      } finally {
        loading.value = false;
      }
    };

    onMounted(() => {
      fetchProfile();
    });

    onUnmounted(() => {
      if (schemaScript) schemaScript.remove();
    });

    return {
      profile,
      loading,
      error,
      fetchProfile,
    };
  },
};
</script>

<style scoped>
/* ============================================
   PROFILE PAGE - Mobile First
   ============================================ */

.profile-page {
  padding: var(--spacing-4) 0;
}

@media (min-width: 640px) {
  .profile-page {
    padding: var(--spacing-8) 0;
  }
}

/* ============================================
   LOADING & ERROR STATES
   ============================================ */

.loading {
  text-align: center;
  padding: var(--spacing-16) var(--spacing-4);
  color: var(--color-text-muted);
  font-size: var(--text-lg);
}

.error-state {
  text-align: center;
  padding: var(--spacing-8);
  background: var(--color-error-subtle);
  border: 1px solid var(--color-error);
  border-radius: var(--radius-xl);
  margin: var(--spacing-4);
}

.error-state p {
  color: var(--color-error);
  margin-bottom: var(--spacing-4);
}

.no-data {
  text-align: center;
  padding: var(--spacing-16);
  color: var(--color-text-muted);
}

/* ============================================
   PROFILE HEADER
   ============================================ */

.profile-header {
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: var(--spacing-12);
}

.profile-avatar {
  width: 128px;
  height: 128px;
  border-radius: var(--radius-full);
  object-fit: cover;
  border: 4px solid var(--color-primary);
  box-shadow: var(--shadow-lg);
  margin-bottom: var(--spacing-6);
}

.profile-avatar-placeholder {
  width: 128px;
  height: 128px;
  border-radius: var(--radius-full);
  background: var(--color-primary);
  color: var(--color-text-primary);
  font-size: var(--text-4xl);
  font-weight: 800;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto var(--spacing-6);
  box-shadow: var(--shadow-lg);
}

.profile-name {
  margin-bottom: var(--spacing-2);
}

.profile-tagline {
  color: var(--color-text-muted);
  font-size: var(--text-lg);
  margin-bottom: var(--spacing-6);
  max-width: 500px;
  margin-left: auto;
  margin-right: auto;
}

/* ============================================
   SKILL TAGS
   ============================================ */

.profile-skills {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: var(--spacing-2);
  margin-bottom: var(--spacing-6);
}

/* ============================================
   CTA BUTTON
   ============================================ */

.profile-cta {
  display: inline-flex;
  text-decoration: none;
  padding: var(--spacing-3) var(--spacing-8);
  font-size: var(--text-base);
}

/* ============================================
   SECTIONS
   ============================================ */

.profile-section {
  margin-bottom: var(--spacing-12);
}

/* ============================================
   CORE VALUES
   ============================================ */

.values-grid {
  display: grid;
  gap: var(--spacing-4);
}

@media (min-width: 640px) {
  .values-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

.value-card {
  background: var(--color-bg-tertiary);
  border: 1px solid var(--color-border);
  border-left: 4px solid var(--color-primary);
  border-radius: var(--radius-lg);
  padding: var(--spacing-4);
}

@media (min-width: 640px) {
  .value-card {
    padding: var(--spacing-6);
  }
}

.value-title {
  color: var(--color-text-primary);
  font-size: var(--text-lg);
  font-weight: 600;
  margin-bottom: var(--spacing-2);
}

.value-description {
  color: var(--color-text-secondary);
  font-size: var(--text-sm);
  line-height: 1.6;
  margin: 0;
}

/* ============================================
   QUICK LINKS
   ============================================ */

.quick-links {
  display: grid;
  gap: var(--spacing-4);
}

@media (min-width: 640px) {
  .quick-links {
    grid-template-columns: repeat(2, 1fr);
  }
}

.quick-link {
  text-decoration: none;
  transition: transform var(--transition-base), box-shadow var(--transition-base);
}

.quick-link:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-lg);
  border-color: var(--color-primary);
}

.quick-link h3 {
  color: var(--color-text-primary);
  font-size: var(--text-lg);
  margin-bottom: var(--spacing-2);
}

.quick-link p {
  color: var(--color-text-muted);
  font-size: var(--text-sm);
  margin: 0;
}
</style>
