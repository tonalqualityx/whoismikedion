/**
 * Test script for Context Builder
 * Run with: node scripts/test-context-builder.js
 */

require('dotenv').config();
const contextBuilder = require('../services/context-builder');

async function testContextBuilder() {
  console.log('Testing Context Builder...\n');
  
  // Test 1: Keyword extraction
  console.log('Test 1: Keyword Extraction');
  console.log('--------------------------');
  const testMessages = [
    "Tell me about your product strategy experience",
    "What's your WordPress background?",
    "Can you handle stakeholder management?",
    "What are your weaknesses?"
  ];
  
  testMessages.forEach(msg => {
    const keywords = contextBuilder.extractKeywords(msg);
    console.log(`"${msg}"`);
    console.log(`  Keywords: [${keywords.join(', ')}]`);
    console.log(`  Weakness query: ${contextBuilder.isAskingAboutWeaknesses(msg)}`);
    console.log();
  });

  // Test 2: Full context build
  console.log('\nTest 2: Full Context Build');
  console.log('--------------------------');
  
  const testQueries = [
    "What are Mike's strongest skills?",
    "Tell me about product strategy experience",
    "What are your weaknesses and areas for improvement?"
  ];

  for (const query of testQueries) {
    console.log(`\nQuery: "${query}"`);
    console.log('---');
    
    try {
      const { context, metadata } = await contextBuilder.buildContext(query);
      
      console.log('Metadata:', JSON.stringify(metadata, null, 2));
      console.log('\nContext preview (first 500 chars):');
      console.log(context.substring(0, 500) + '...');
      console.log('\n');
    } catch (error) {
      console.log('Error:', error.message);
    }
  }

  // Close database connection
  process.exit(0);
}

testContextBuilder().catch(console.error);