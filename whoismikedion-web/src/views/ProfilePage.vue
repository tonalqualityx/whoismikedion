<template>
    <div class="profile-page">

        <!-- LOADING STATE -->
         <div v-if="loading" class="loading">
            <p>Loading profile...</p>
        </div>

        <!-- ERROR STATE -->
        <div v-else-if="error" class="error">
            <p>Error loading profile: {{ errorMessage }}</p>
            <button @click="retryFetch">Retry</button>
        </div>

        <!-- Success state -->
         <div v-else-if="profile" class="profile-content">

            <!-- Header Section -->
             <div class="profile-header">
                <img 
                    v-if="profile.photo_url"
                    :src="profile.photo_url" 
                    :alt="profile.name" 
                    class="profile-photo" />

                    
                <h1>{{ profile.name }}</h1>
                <p>{{ profile.tagline }}</p>
            </div>

            <section class="top-skills">
                <h2>Top Skills:</h2>

                <div v-if="profile.top_skills && profile.top_skills.length > 0" class="skills-grid">
                    <div 
                        v-for="skill in profile.top_skills"
                        :key="skill.skill_id"
                        class="skill-card">

                        <h3>{{ skill.name }}</h3>
                        <span :class="['proficiency', skill.proficiency]">
                            {{ skill.proficiency  }}
                        </span>
                        <p class="skill-category">{{ skill.category }}</p>
                    </div>
                </div>
                <div v-else>
                    <p>No top skills available.</p>
                </div>
            </section>

            <section class="core-values">
                <h2>Core Values:</h2>

                <div v-if="profile.core_values && profile.core_values.length > 0" class="values-list">
                    <div
                        v-for="value in profile.core_values"
                        :key="value.value_text"
                        class="value-item">

                        <h3>{{ value.value_text }}</h3>
                        <p>{{ value.description }}</p>
                    </div>
                </div>

                <div v-else>
                    <p>No core values available.</p>
                </div>
            </section>

        </div> <!-- End Success State -->

        <!-- NO DATA -->
         <div v-else class="no-data">
            <p>No profile data available.</p>
        </div>

    </div>
</template>  

<script>
    import { ref, onMounted } from 'vue';
    import axios from 'axios';

    export default {
        name: 'ProfilePage',

        setup() {

            const profile = ref(null);
            const loading = ref(false);
            const error = ref(null);

            const fetchProfile = async () => {

                try {
                    loading.value = true;
                    error.value = null;

                    console.log('Fetching profile from API...');

                    const response = await axios.get('http://localhost:3000/api/profile');

                    console.log('Profile fetched:', response.data);

                    profile.value = response.data;
                
                } catch (err) {
                    console.error('Error fetching profile:', err);
                    
                    if(err.response) {
                        error.value = `Server error: ${err.response.status}`;
                    } else if(err.request) {
                        error.value = 'Network error: No response from server';
                    } else {
                        error.value = 'Failed to load profile. Please try again.';
                    }

                } finally {
                    loading.value = false;
                }
            }

            onMounted( () => {
                console.log('ProfilePage mounted, fetching profile...');
                fetchProfile();
            })

            // TODO : Replace with actual skills
            const skill1 = ref('Product Strategy');
            const skill2 = ref('Node.js Development');
            const skill3 = ref('Communications');

            // TODO : Remove, this is just a test
            const count = ref(0);
            const increment = () => {
                count.value++;
            };

            return {
                profile,
                loading,
                error,
                skill1,
                skill2,
                skill3,
            }
        }
    };
</script>

<style scoped>
.profile-page {
  max-width: 1200px;
  margin: 0 auto;
  padding: var(--spacing-xl);
}

.loading {
  text-align: center;
  padding: var(--spacing-3xl) var(--spacing-xl);
  font-size: 1.5rem;
  color: var(--color-text-secondary);
}

.error {
  text-align: center;
  padding: var(--spacing-xl);
  background: var(--color-error-bg);
  border: 2px solid var(--color-error);
  border-radius: var(--radius-lg);
  color: var(--color-error);
  margin: var(--spacing-xl) 0;
}

.error button {
  padding: var(--spacing-sm) var(--spacing-lg);
  background: var(--color-error);
  color: var(--color-text-inverse);
  border: none;
  border-radius: var(--radius-md);
  cursor: pointer;
  font-weight: 600;
  transition: background-color var(--transition-base);
}

.error button:hover {
  background: #c82333;
}

.profile-header {
  text-align: center;
  margin-bottom: var(--spacing-2xl);
}

.profile-photo {
  width: 200px;
  height: 200px;
  border-radius: var(--radius-full);
  object-fit: cover;
  margin-bottom: var(--spacing-lg);
  border: 4px solid var(--color-primary);
  background-color: var(--color-primary);
}

.profile-header h1 {
  font-size: 2.5rem;
  margin-bottom: var(--spacing-sm);
  color: var(--color-primary);
}

.tagline {
  font-size: 1.2rem;
  color: var(--color-text-secondary);
}

section {
  margin-bottom: var(--spacing-2xl);
}

section h2 {
  font-size: 2rem;
  margin-bottom: var(--spacing-lg);
  border-bottom: 2px solid var(--color-primary);
  padding-bottom: var(--spacing-sm);
  color: var(--color-secondary);
}

.skills-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: var(--spacing-lg);
}

.skill-card {
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: var(--spacing-lg);
  background: var(--color-bg-tertiary);
  box-shadow: var(--shadow-md);
  transition: transform var(--transition-base), box-shadow var(--transition-base);
}

.skill-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
}

.skill-card h3 {
  margin: 0 0 var(--spacing-sm) 0;
  font-size: 1.2rem;
  color: var(--color-text-primary);
}

.proficiency {
  display: inline-block;
  padding: var(--spacing-xs) var(--spacing-sm);
  border-radius: var(--radius-sm);
  font-size: 0.875rem;
  font-weight: 600;
}

/* Use brand proficiency colors */
.proficiency.expert {
  background: var(--color-skill-expert);
  color: var(--color-text-inverse);
}

.proficiency.proficient {
  background: var(--color-skill-proficient);
  color: var(--color-text-inverse);
}

.proficiency.developing {
  background: var(--color-skill-developing);
  color: var(--color-text-primary);
}

.skill-category {
  margin-top: var(--spacing-sm);
  font-size: 0.85rem;
  color: var(--color-text-secondary);
  text-transform: capitalize;
}

.values-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-lg);
}

.value-item {
  padding: var(--spacing-lg);
  background: var(--color-bg-tertiary);
  border-left: 4px solid var(--color-primary);
  border-radius: var(--radius-md);
}

.value-item h3 {
  margin: 0 0 var(--spacing-sm) 0;
  font-size: 1.2rem;
  color: var(--color-text-primary);
}

.value-item p {
  margin: 0;
  color: var(--color-text-secondary);
  line-height: 1.6;
}

.no-data {
  color: var(--color-text-secondary);
  font-style: italic;
  text-align: center;
  padding: var(--spacing-xl);
}

.refresh-button {
  display: block;
  margin: var(--spacing-xl) auto 0;
  padding: var(--spacing-md) var(--spacing-xl);
  background: var(--color-accent-amber);
  color: var(--color-text-inverse);
  border: none;
  border-radius: var(--radius-md);
  cursor: pointer;
  font-size: 1rem;
  font-weight: 600;
  box-shadow: var(--shadow-md);
  transition: background-color var(--transition-base), box-shadow var(--transition-base);
}

.refresh-button:hover {
  background: var(--color-accent-amber-dark);
  box-shadow: var(--shadow-lg);
}


@media (max-width: 768px) {
  .profile-page {
    padding: var(--spacing-md);
  }

  .profile-header {
    text-align: center;
    margin-bottom: var(--spacing-xl);
  }

  .avatar {
    width: 150px;
    height: 150px;
  }

  .profile-name {
    font-size: 2rem;
  }

  /* Skills grid: 2 columns on tablet, 1 on phone */
  .skills-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: var(--spacing-sm);
  }

  /* Values: stack on mobile */
  .values-list {
    flex-direction: column;
  }

  .value-card {
    width: 100%;
  }
}

@media (max-width: 480px) {
  .skills-grid {
    grid-template-columns: 1fr;
  }

  .skill-tag {
    padding: var(--spacing-sm);
    font-size: 0.875rem;
  }
}
</style>