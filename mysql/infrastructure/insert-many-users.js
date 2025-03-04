const mysql = require('mysql2/promise');

// MySQL connection configuration
const dbConfig = {
  host: 'localhost',   // Docker service host
  port: 3306,         // MySQL port
  user: 'root',       // MySQL root user
  password: 'root',   // MySQL root password
  database: 'testdb',   // Change if using a different database
};

// Arrays for random selection
const statuses = ['active', 'inactive', 'pending'];
const subscriptionTypes = ['free', 'basic', 'premium', 'enterprise'];
const themes = ['light', 'dark', 'auto'];
const devices = ['mobile', 'desktop', 'tablet'];
const browsers = ['Chrome', 'Firefox', 'Safari', 'Edge'];

// Function to generate a random date within the last year
function randomDate() {
  const now = new Date();
  const past = new Date(now.getTime() - 365 * 24 * 60 * 60 * 1000);
  return new Date(past.getTime() + Math.random() * (now.getTime() - past.getTime()));
}

async function insertUsers() {
  const connection = await mysql.createConnection(dbConfig);

  try {
    const totalDocs = 20000; // 2m todo
    const batchSize = 10000;
    let batch = [];

    console.log('Starting data generation...');

    for (let i = 0; i < totalDocs; i++) {
      const createdAt = randomDate();
      const lastLogin = new Date(createdAt.getTime() + Math.random() * (new Date().getTime() - createdAt.getTime()));

      const user = [
        `user${i}`, // username
        `user${i}@example.com`, // email
        ['John', 'Jane', 'Bob', 'Alice'][Math.floor(Math.random() * 4)], // first_name
        ['Smith', 'Johnson', 'Brown', 'Davis'][Math.floor(Math.random() * 4)], // last_name
        `+1${Math.floor(Math.random() * 1000000000)}`, // phone
        `${Math.floor(Math.random() * 1000)} Main St`, // street
        ['New York', 'Los Angeles', 'Chicago', 'Houston'][Math.floor(Math.random() * 4)], // city
        ['NY', 'CA', 'IL', 'TX'][Math.floor(Math.random() * 4)], // state
        Math.floor(Math.random() * 90000 + 10000).toString(), // zip_code
        'USA', // country
        statuses[Math.floor(Math.random() * statuses.length)], // status
        subscriptionTypes[Math.floor(Math.random() * subscriptionTypes.length)], // subscription_type
        lastLogin, // last_login
        createdAt, // created_at
        Math.floor(Math.random() * 62) + 18, // age
        Math.random() > 0.5, // notifications
        Math.random() > 0.5, // newsletter
        themes[Math.floor(Math.random() * themes.length)], // theme
        new Date(), // last_updated
        devices[Math.floor(Math.random() * devices.length)], // device_type
        browsers[Math.floor(Math.random() * browsers.length)] // browser
      ];

      batch.push(user);

      // Insert batch into MySQL
      if (batch.length === batchSize) {
        await insertBatch(connection, batch);
        console.log(`Inserted batch ${Math.floor(i / batchSize) + 1}: ${batch.length} records`);
        batch = [];
      }
    }

    // Insert remaining records
    if (batch.length > 0) {
      await insertBatch(connection, batch);
      console.log(`Inserted final batch: ${batch.length} records`);
    }

    console.log(`Finished inserting ${totalDocs} records.`);
  } catch (error) {
    console.error('Error inserting records:', error);
  } finally {
    await connection.end();
  }
}

// Function to insert batch into MySQL
async function insertBatch(connection, batch) {
  const sql = `
    INSERT INTO users 
    (username, email, first_name, last_name, phone, street, city, state, zip_code, country, 
     status, subscription_type, last_login, created_at, age, notifications, newsletter, 
     theme, last_updated, device_type, browser) 
    VALUES ?`;

  await connection.query(sql, [batch]);
}

// Run the script
insertUsers().catch(console.error);
