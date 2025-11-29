require('dotenv').config();

// Imports
const express = require('express');
const cors = require('cors');
const path = require('path');
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

const profileRoutes = require('./routes/profile');
app.use('/api/profile', profileRoutes);

const storiesRoutes = require('./routes/stories');
app.use('/api/stories', storiesRoutes);

const workRoutes = require('./routes/work');
app.use('/api/work-history', workRoutes);

const chatRoutes = require('./routes/chat');
app.use('/api/chat', chatRoutes);

// // Root endpoint - welcome message
// app.get('/', (req, res) => {
//     res.json({
//         message: 'Who Is Mike Dion API IS',
//         version: '1.0.0',
//         endpoints: {
//             health: '/health',
//             profile: '/api/profile'
//         }
//     });
// });

if (process.env.NODE_ENV === 'production' ) {
    app.use(express.static(path.join(__dirname, '../whoismikedion-web/dist')));

    app.get('/{*splat}', (req, res) => {
        res.sendFile(path.join(__dirname, '../whoismikedion-web/dist/index.html'));
    });
}

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