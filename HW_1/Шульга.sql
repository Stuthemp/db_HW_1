CREATE TABLE addresses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    postcode INTEGER NOT NULL,
    state VARCHAR(30) NOT NULL,
    country VARCHAR(30) NOT NULL
);

CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NULL,
    gender VARCHAR(10) NOT NULL,
    dob TIMESTAMP NULL,
    job_title VARCHAR(50) NULL,
    job_industry_category VARCHAR(50) NULL,
    welth_segment VARCHAR(50) not null, 
    deceased_indicator BOOLEAN NOT NULL,
    owns_car BOOLEAN NOT NULL,
    address_id INTEGER REFERENCES addresses(id) NOT NULL,
    property_valuation INTEGER NOT NULL
);

CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    brand VARCHAR(30) NULL,
    product_line VARCHAR(10) NULL,
    product_class VARCHAR(10) NULL,
    product_size VARCHAR(10) NULL
);

CREATE TABLE transaction (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES product(id) NOT NULL,
    customer_id INTEGER REFERENCES customer(id) NOT NULL,
    transaction_date TIMESTAMP NOT NULL,
    online_order BOOLEAN NULL,
    order_status VARCHAR(10) NOT NULL,
    list_price FLOAT NOT NULL,
    standard_cost FLOAT NULL
);

INSERT INTO addresses (name, postcode, state, country)
VALUES 
    ('060 Morning Avenue', 2016, 'New South Wales', 'Australia'),
    ('6 Meadow Vale Court', 2153, 'New South Wales', 'Australia'),
    ('0 Holy Cross Court', 4211, 'QLD', 'Australia'),
    ('17979 Del Mar Point', 2448, 'New South Wales', 'Australia'),
    ('9 Oakridge Court', 3216, 'VIC', 'Australia'),
    ('4 Delaware Trail', 2210, 'New South Wales', 'Australia'),
    ('49 Londonderry Lane', 2650, 'New South Wales', 'Australia'),
    ('97736 7th Trail', 2023, 'New South Wales', 'Australia'),
    ('93405 Ludington Park', 3044, 'VIC', 'Australia'),
    ('44339 Golden Leaf Alley', 4557, 'QLD', 'Australia');

INSERT INTO customer (first_name, last_name, gender, dob, job_title, job_industry_category, welth_segment, deceased_indicator, owns_car, address_id, property_valuation)
VALUES
    ('Laraine', 'Medendorp', 'Female', '1953-10-12', 'Executive Secretary', 'Health', 'Mass Customer', FALSE, TRUE, 1, 10),
    ('Eli', 'Bockman', 'Male', '1980-12-16', 'Administrative Officer', 'Financial Services', 'Mass Customer', FALSE, TRUE, 2, 10),
    ('Arlin', 'Dearle', 'Male', '1954-01-20', 'Recruiting Manager', 'Property', 'Mass Customer', FALSE, TRUE, 3, 9),
    ('Talbot', NULL, 'Male', '1961-10-03', NULL, 'IT', 'Mass Customer', FALSE, FALSE, 4, 4),
    ('Sheila-kathryn', 'Calton', 'Female', '1977-05-13', 'Senior Editor', NULL, 'Affluent Customer', FALSE, TRUE, 5, 9),
    ('Curr', 'Duckhouse', 'Male', '1966-09-16', NULL, 'Retail', 'High Net Worth', FALSE, TRUE, 6, 9),
    ('Fina', 'Merali', 'Female', '1976-02-23', NULL, 'Financial Services', 'Affluent Customer', FALSE, TRUE, 7, 4),
    ('Rod', 'Inder', 'Male', '1962-03-30', 'Media Manager I', NULL, 'Mass Customer', FALSE, FALSE, 8, 12),
    ('Mala', 'Lind', 'Female', '1973-03-10', 'Business Systems Development Analyst', 'Argiculture', 'Affluent Customer', FALSE, TRUE, 9, 8),
    ('Fiorenze', 'Birdall', 'Female', '1988-10-11', 'Senior Quality Engineer', 'Financial Services', 'Mass Customer', FALSE, TRUE, 10, 4);

INSERT INTO product (brand, product_line, product_class, product_size)
VALUES
    ('OHM Cycles', 'Standard', 'medium', 'medium'),
    ('Giant Bicycles', 'Standard', 'medium', 'medium'),
    ('Giant Bicycles', 'Standard', 'medium', 'small'),
    ('Giant Bicycles', 'Standard', 'medium', 'large'),
    ('Norco Bicycles', 'Road', 'high', 'large'),
    ('Trek Bicycles', 'Standard', 'high', 'medium'),
    ('Trek Bicycles', 'Mountain', 'low', 'medium'),
    ('Norco Bicycles', 'Standard', 'low', 'medium'),
    ('Solex', 'Standard', 'medium', 'large'),
    ('Trek Bicycles', 'Mountain', 'low', 'medium');

INSERT INTO transaction (product_id, customer_id, transaction_date, online_order, order_status, list_price, standard_cost)
VALUES
    (1, 1, '2017-12-23', FALSE, 'Approved', 235.63, 125.07),
    (2, 2, '2017-05-04', TRUE, 'Approved', 1403.50, 954.82),
    (3, 3, '2017-02-23', FALSE, 'Approved', 1311.44, 1167.18),
    (4, 4, '2017-04-03', FALSE, 'Approved', 569.56, 528.43),
    (5, 5, '2017-08-16', FALSE, 'Approved', 774.53, 464.72),
    (6, 6, '2017-05-21', FALSE, 'Approved', 358.39, 215.03),
    (7, 7, '2017-04-21', FALSE, 'Approved', 574.64, 459.71),
    (8, 8, '2017-09-22', TRUE, 'Approved', 958.74, 748.90),
    (9, 9, '2017-05-10', FALSE, 'Approved', 1061.56, 733.58),
    (10, 10, '2017-08-26', FALSE, 'Approved', 574.64, 459.71);