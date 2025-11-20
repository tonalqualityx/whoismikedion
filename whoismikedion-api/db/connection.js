require('dotenv').config();

const mysql = require('mysql2');

//==================================================
// CONNECTION POOL
//==================================================

const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME || 'whoismikedion',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
    timezone: 'Z'
});

const promisePool = pool.promise();

// TEST
promisePool.query('SELECT 1')
    .then(() => {
        console.log('Database connection established.');
        console.log(`Host: ${process.env.DB_HOST || 'localhost'}`);
        console.log(`Database: ${process.env.DB_NAME || 'whoismikedion'}`);
    })
    .catch((err) => {
        console.error('Unable to connect to the database:');
        console.error(`  Error: ${err.message}`);
        console.error(`  Code: ${err.code}`);

        if (err.code === 'ER_ACCESS_DENIED_ERROR') {
      console.error('\n   💡 Check your database credentials in .env file');
      console.error('   Make sure DB_USER and DB_PASSWORD are correct');
    } else if (err.code === 'ECONNREFUSED') {
      console.error('\n   💡 Make sure MySQL server is running');
      console.error('   Try: sudo systemctl start mysql');
    } else if (err.code === 'ER_BAD_DB_ERROR') {
      console.error('\n   💡 Database does not exist');
      console.error('   Create it with: CREATE DATABASE whoismikedion;');
    }

    process.exit(1);
});

pool.end = (callback) => {
    pool.end((err) => {
        if(err) {
            console.error('Error closing database connection pool:', err);
        } else {
            console.log('Database connection pool closed.');
        }

        if(callback) callback(err);
    });
};

module.exports = promisePool;