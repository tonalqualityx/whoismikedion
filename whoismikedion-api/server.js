require('dotenv').config();

// Imports
const express = require('express');
const cors = require('cors');
const db = require('./db/connection');
const app = express();

const PORT = process.env.PORT || 3000;


// Middleware
app.use(cors());
app.use(express.json());

app.use(express.urlencoded({ extended: true }));

// Custom logging middleware
app.use((req, res, next) => {
    console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
    next();
});

// =========================================
// ROUTES
// =========================================

// Health check endpoint - useful for monitoring if server is running
// Test with: curl http://localhost:3000/health
app.get('/health', (req, res) => {
    res.json({ 
        status: 'OK', 
        timestamp: new Date().toISOString() 
    });
});

// Root endpoint - welcome message
app.get('/', (req, res) => {
    res.json({
        message: 'Who Is Mike Dion API IS',
        version: '1.0.0',
        endpoints: {
            health: '/health',
            profile: '/api/profile'
        }
    });
});

// TODO add /api/profile route later.

// =========================================
// ERROR HANDLING
// =========================================

// 404 handler - catches rquests to undefined routes
// MUST COME AFTER ALL OTHER ROUTES
app.use((req, res) => {
    res.status(404).json({
        error: 'You done messed up A-A-Ron!',
        path: req.path
    });
});

// General error handler
app.use((err, req, res, next) => {
    console.error('Error:', err);

    res.status(500).json({
        message: process.env.NODE_ENV === 'development' ? err.message : undefined
    });
})

//=========================================
// START SERVER
//=========================================
app.listen(PORT, () => {
    console.log(`Server is running on  http://localhost:${PORT}`);
    console.log(`Health check: http://localhost:${PORT}/health`);
    console.log(`Profile API: http://localhost:${PORT}/api/profile`);
    console.log(`Press CTRL+C to stop the server`);
});