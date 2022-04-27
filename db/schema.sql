DROP DATABASE products;
CREATE DATABASE products;
\c products;


/* Product table */
CREATE TABLE IF NOT EXISTS product (
  id SERIAL PRIMARY KEY UNIQUE NOT NULL,
  product_id INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  slogan TEXT NOT NULL,
  description TEXT NOT NULL,
  category VARCHAR(50) NOT NULL,
  default_price INT NOT NULL
);
COPY product(product_id, name, slogan, description, category, default_price)
FROM '/Users/varun/Documents/rfp2202/sdc/SDC-products/data/product.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

/* Related Items table */
CREATE TABLE IF NOT EXISTS related (
  id SERIAL PRIMARY KEY UNIQUE NOT NULL,
  current_product_id INT NOT NULL,
  related_product_id INT NOT NULL,
  FOREIGN KEY ( current_product_id ) REFERENCES product ( id )
);
COPY related(id, current_product_id, related_product_id)
FROM '/Users/varun/Documents/rfp2202/sdc/SDC-products/data/related.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

/* Features table */
CREATE TABLE IF NOT EXISTS features (
  id SERIAL PRIMARY KEY UNIQUE NOT NULL,
  product_id INT NOT NULL,
  feature VARCHAR(50),
  value VARCHAR(50),
  FOREIGN KEY ( product_id ) REFERENCES product ( id )
);
COPY features(id, product_id, feature, value)
FROM '/Users/varun/Documents/rfp2202/sdc/SDC-products/data/features.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

/* Styles table */
CREATE TABLE IF NOT EXISTS styles (
  id SERIAL PRIMARY KEY UNIQUE NOT NULL,
  productId INT NOT NULL,
  name VARCHAR(50),
  sale_price INT,
  original_price INT,
  default_style BOOLEAN,
  FOREIGN KEY ( productId ) REFERENCES product ( id )
);
COPY styles(id, productId, name, sale_price, original_price, default_style)
FROM '/Users/varun/Documents/rfp2202/sdc/SDC-products/data/styles.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

/* Photos table */
CREATE TABLE IF NOT EXISTS photos (
  id SERIAL PRIMARY KEY UNIQUE NOT NULL,
  styleId INT NOT NULL,
  url TEXT NOT NULL,
  thumbnail_url TEXT NOT NULL,
  FOREIGN KEY ( styleId ) REFERENCES styles ( id )
);
COPY photos(id, styleId, url, thumbnail_url)
FROM '/Users/varun/Documents/rfp2202/sdc/SDC-products/data/photos.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

/* Stock table */
CREATE TABLE IF NOT EXISTS inventory (
  id SERIAL PRIMARY KEY UNIQUE NOT NULL,
  styleId INT NOT NULL,
  size VARCHAR(15) NOT NULL,
  quantity INT NOT NULL,
  FOREIGN KEY ( styleId ) REFERENCES styles ( id )
);
COPY inventory(id, styleId, size, quantity)
FROM '/Users/varun/Documents/rfp2202/sdc/SDC-products/data/skus.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

-- CREATE INDEX idx_style_productId ON styles (productId);

-- CREATE INDEX idx_photo_styleId ON photos (styleId);

-- CREATE INDEX idx_inventory_styleId ON inventory (styleId);

-- CREATE INDEX idx_related_currentId on related (current_product_id);