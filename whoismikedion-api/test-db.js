require('dotenv').config();
const db = require('./db/connection');

async function testDatabase() {
    try {
        console.log('testing database connection...\n');

        const [rows] = await db.query('SELECT 1 + 1 AS result');
        console.log('Test 1: Basic query');
        console.log('  Result:', [rows[0].result]);

        const [tables] = await db.query("SHOW TABLES");
        console.log('\nTest 2: Tabeles in database');
        if(tables.length === 0) {
            console.log(' (No tables yet)')
        } else {
            tables.forEach(table => {
                console.log(' -', Object.values(table)[0]);
            });
        }

        const [dbInfo] = await db.query('SELECT DATABASE() as current_db,  VERSION() as mysql_version');
        console.log('\n Test 3: Database Info:');
        console.log(' - Current Database:', dbInfo[0].current_db);
        console.log(' - MySQL Version  :', dbInfo[0].mysql_version);

        console.log('\n ✅ All database tests passed.');
        process.exit(0);
    } catch (error) {
        console.error('\n ❌ Database test failed:');
        console.error('  Error:', error.message);
        process.exit(1);
    }

}

testDatabase();