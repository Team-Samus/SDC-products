DROP DATABASE products;
CREATE DATABASE products;


/* Product table */
CREATE TABLE IF NOT EXISTS product (
  id SERIAL PRIMARY KEY UNIQUE NOT NULL,
  name VARCHAR(50) NOT NULL,
  slogan TEXT NOT NULL,
  description TEXT NOT NULL,
  category VARCHAR(50) NOT NULL,
  default_price INT NOT NULL
);

/* Related Items table */
CREATE TABLE IF NOT EXISTS related (
  id SERIAL PRIMARY KEY UNIQUE NOT NULL,
  product_id INT NOT NULL,
  related_id INT NOT NULL,
  FOREIGN KEY ( product_id ) REFERENCES product ( id )
);

/* Features table */
CREATE TABLE IF NOT EXISTS features (
  id SERIAL PRIMARY KEY UNIQUE NOT NULL,
  product_id INT NOT NULL,
  feature VARCHAR(50),
  value VARCHAR(50),
  FOREIGN KEY ( product_id ) REFERENCES product ( id )
);

/* Styles table */
CREATE TABLE IF NOT EXISTS styles (
  id SERIAL PRIMARY KEY UNIQUE NOT NULL,
  product_id INT NOT NULL,
  name VARCHAR(50),
  original_price INT NOT NULL,
  sale_price INT NOT NULL,
  FOREIGN KEY ( product_id ) REFERENCES product ( id )
);

/* Photos table */
CREATE TABLE IF NOT EXISTS photos (
  id SERIAL PRIMARY KEY UNIQUE NOT NULL,
  style_id INT NOT NULL,
  url TEXT NOT NULL,
  thumbnail_url TEXT NOT NULL,
  FOREIGN KEY ( style_id ) REFERENCES styles ( id )
);

/* Stock table */
CREATE TABLE IF NOT EXISTS inventory (
  id SERIAL PRIMARY KEY UNIQUE NOT NULL,
  style_id INT NOT NULL,
  size VARCHAR(15) NOT NULL,
  quantity INT NOT NULL,
  FOREIGN KEY ( style_id ) REFERENCES styles ( id )
);