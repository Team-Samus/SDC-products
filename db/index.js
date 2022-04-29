const { Pool } = require('pg');

const db = new Pool({
  user: 'ubuntu',
  host: '18.144.169.98',
  database: 'products',
  password: null,
  port: 5432
});

// var testConnection = function() {}
// pool.connect((err, client, release) => {
//   if (err) {
//     return console.error('Error acquiring client', err.stack)
//   }
//   client.query('SELECT NOW()', (err, result) => {
//     release()
//     if (err) {
//       return console.error('Error executing query', err.stack)
//     }
//     console.log(result.rows)
//   })
// })

// pool.query(`SELECT * FROM product`, (err, result) => {
//   if (err) {
//     console.log(err, 'fail');
//   } else {
//     console.log(result, 'success');
//   }
// });

module.exports = db;