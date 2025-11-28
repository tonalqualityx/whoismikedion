/**
 * Test script for Claude API integration
 * Run with: node scripts/test-claude.js
 */

require('dotenv').config();
const claudeService = require('../services/claude');

async function testClaude() {
  console.log('Testing Claude API connection...\n');
  
  // Test 1: Health check
  console.log('Test 1: Health Check');
  console.log('--------------------');
  const health = await claudeService.healthCheck();
  console.log('Status:', health.status);
  if (health.status === 'healthy') {
    console.log('Model:', health.model);
    console.log('Response:', health.message);
  } else {
    console.log('Error:', health.error);
    return;
  }
  
  console.log('\n');
  
  // Test 2: Basic completion
  console.log('Test 2: Basic Completion (no context)');
  console.log('-------------------------------------');
  try {
    const result = await claudeService.generateResponse({
      userMessage: 'What can you tell me about Mike Dion?'
    });
    console.log('Response:', result.response);
    console.log('Tokens used:', result.usage.totalTokens);
  } catch (error) {
    console.log('Error:', error.message);
  }
  
  console.log('\n');
  
  // Test 3: Completion with context
  console.log('Test 3: Completion With Context');
  console.log('-------------------------------');
  try {
    const sampleContext = `
## Skills
- Product Strategy (Expert): Defining product vision and roadmap
- WordPress Development (Expert): 10+ years of WordPress experience
- Stakeholder Management (Proficient): Building consensus across teams

## Relevant Story
**Restaurant Content Strategy** (STORY-001)
Context: Led content strategy for restaurant clients at Indelible
Challenge: Needed to standardize content approach across 50+ restaurant websites
Solution: Created templated content system with modular components
Outcome: Reduced content creation time by 60%, increased client satisfaction scores
Impact: $2.1M in revenue attributed to content-driven leads
`;
    
    const result = await claudeService.generateResponse({
      userMessage: 'What are Mike\'s strongest skills?',
      context: sampleContext
    });
    console.log('Response:', result.response);
    console.log('Tokens used:', result.usage.totalTokens);
  } catch (error) {
    console.log('Error:', error.message);
  }
}

testClaude().catch(console.error);