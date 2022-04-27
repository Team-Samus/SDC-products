const express = require('express');
const router = express.Router();
const db = require('../db/index.js');

const getProducts = router.get('/products', async (req, res) => {
  let page = req.query.page || 1;
  let count = req.query.count || 5;
  let realPage = (page * count) - count;
  let queryStr = `SELECT * FROM product OFFSET $1 LIMIT $2`;
  let result = await db.query(queryStr, [realPage, count]);
  res.send(result.rows);
})

const getOne = router.get('/products/:product_id', async (req, res) => {
  let queryStr =
  `SELECT p.id, p.name, p.slogan, p.description, p.category, p.default_price,
  ARRAY_AGG(
    JSON_BUILD_OBJECT(
      'feature', (f.feature),
      'value', (f.value)
    )
  )
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

const getStyles = router.get('/products/:product_id/styles', async (req, res) => {
  let queryStr = `
  SELECT s.productId AS product_id,
  JSON_AGG(
    JSON_BUILD_OBJECT(
      'style_id', s.id,
      'name', s.name,
      'original_price', s.original_price,
      'sale_price', s.sale_price,
      'default?', s.default_style,
      'photos', (
        SELECT JSON_AGG(
          JSON_BUILD_OBJECT(
            'thumbnail_url', photos.thumbnail_url,
            'url', photos.url
          )
        )
        FROM photos WHERE photos.styleId=s.id
      ),
      'skus', (
        SELECT JSON_OBJECT_AGG(
          inventory.id, JSON_BUILD_OBJECT(
            'quantity', inventory.quantity,
            'size', inventory.size
          )
        )
        FROM inventory WHERE inventory.styleId=s.id
      )
    )
  ) AS results
  FROM styles s
  WHERE s.productId=$1
  GROUP BY s.productId
  `;
  let result = await db.query(queryStr, [req.params.product_id]);
  res.send(result.rows[0]);
})

module.exports = {
  getProducts,
  getOne,
  getRelated,
  getStyles
};