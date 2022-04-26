const express = require('express');
const router = express.Router();
const db = require('../db/index.js');

const getProducts = router.get('/products', async (req, res) => {
  let queryStr = `SELECT * FROM product LIMIT 5`;
  let result = await db.query(queryStr);
  res.send(result.rows);
})

const getOne = router.get('/products/:product_id', async (req, res) => {
  let queryStr =
  `SELECT p.*,
  ARRAY_AGG(JSON_BUILD_OBJECT('feature', (f.feature), 'value', (f.value)))
  AS features
  FROM product p
  JOIN features f ON p.id=f.product_id
  WHERE p.id=$1
  GROUP BY p.id`
  let result = await db.query(queryStr, [req.params.product_id]);
  res.send(result.rows[0]);
})

const getRelated = router.get('/products/:product_id/related', async (req, res) => {
  let queryStr =
  `SELECT ARRAY_AGG(related_product_id) related
  FROM related
  WHERE current_product_id=$1`;
  let result = await db.query(queryStr, [req.params.product_id]);
  res.send(result.rows[0].related);
})

module.exports = {
  getProducts,
  getOne,
  getRelated
};