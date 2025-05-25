CREATE TABLE users (
user_id BIGINT PRIMARY KEY,
user_first_transaction_channel TEXT
);

CREATE TABLE transactions (
 order_id BIGINT PRIMARY KEY,
    transaction_created_date DATE,
    user_id BIGINT REFERENCES users(user_id),
    net_amount NUMERIC(12,2),
    email TEXT,
    store_name TEXT,
    city TEXT,
    country TEXT
);

/* Check after importing the CSV files */

SELECT * 
FROM users;

SELECT COUNT(*) 
FROM transactions;

SELECT * 
FROM transactions LIMIT 10;

SELECT COUNT(*) 
FROM users;

SELECT * 
FROM users LIMIT 10;

SELECT 
MIN(transaction_created_date), 
MAX(transaction_created_date) 
FROM transactions;

/* Recency */
WITH last_purchase_per_customer AS (
  SELECT user_id, MAX(transaction_created_date) AS last_purchase_date
  FROM transactions
  GROUP BY user_id
)
SELECT
user_id,
(CURRENT_DATE - last_purchase_date) AS recency_days
FROM last_purchase_per_customer
ORDER BY recency_days DESC;

/* Frequency */
SELECT user_id, COUNT(order_id) AS frequency
FROM transactions
GROUP BY user_id
ORDER BY frequency DESC;

/* Monatery */
SELECT user_id, SUM(net_amount) AS monetary
FROM transactions
GROUP BY user_id
ORDER BY monetary DESC;

/* Check */
SELECT MIN(frequency), MAX(frequency)
FROM (
SELECT user_id, COUNT(order_id) AS frequency
FROM transactions
GROUP BY user_id
);

SELECT MIN(monetary), MAX(monetary)
FROM (
	SELECT user_id, SUM(net_amount) AS monetary
	FROM transactions
	GROUP BY user_id
);

/* RFM segmentation CTE */
WITH rfm_base AS (
  SELECT
    user_id,
    CURRENT_DATE - MAX(transaction_created_date) AS recency_days,
    COUNT(order_id) AS frequency,
    SUM(net_amount) AS monetary
  FROM transactions
  GROUP BY user_id
),
rfm_scored AS (
  SELECT *,
    -- Recency score
    CASE 
      WHEN recency_days <= 2350 THEN 5
      WHEN recency_days <= 2423 THEN 4
      WHEN recency_days <= 2496 THEN 3
      WHEN recency_days <= 2569 THEN 2
      ELSE 1
    END AS r_score,
    -- Frequency score
    CASE
      WHEN frequency <= 32 THEN 1
      WHEN frequency <= 64 THEN 2
      WHEN frequency <= 96 THEN 3
      WHEN frequency <= 128 THEN 4
      ELSE 5
    END AS f_score,
    -- Monetary score
    CASE
      WHEN monetary <= 8768.22 THEN 1
      WHEN monetary <= 17522.97 THEN 2
      WHEN monetary <= 26277.72 THEN 3
      WHEN monetary <= 35032.47 THEN 4
      ELSE 5
    END AS m_score
  FROM rfm_base
)
SELECT *,
  CONCAT(r_score, f_score, m_score) AS rfm_score,
  CASE
    WHEN r_score = 5 AND f_score = 5 AND m_score >= 4 THEN 'Top'
    WHEN r_score >= 4 AND f_score >= 4 THEN 'Loyal'
    WHEN r_score <= 2 AND f_score <= 2 THEN 'Fading'
    WHEN r_score = 5 AND f_score = 1 THEN 'New Customer'
    ELSE 'Other'
  END AS segment
FROM rfm_scored;


