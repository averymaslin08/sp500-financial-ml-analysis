CREATE DATABASE finance_db;
USE finance_db;

-- Importing the Data from Python;
SHOW TABLES;
SELECT COUNT(*) FROM sp500_stocks;
SELECT * FROM sp500_stocks LIMIT 10;

-- 1. Average Daily Return by Stock (rounded to 6 decimals)
SELECT Symbol, 
       ROUND(AVG(`Return`), 6) AS avg_return
FROM sp500_stocks
GROUP BY Symbol
ORDER BY avg_return DESC;


-- 2. Volatility Ranking (rounded to 6 decimals)
SELECT Symbol, 
       ROUND(STDDEV_SAMP(`Return`), 6) AS volatility
FROM sp500_stocks
GROUP BY Symbol
ORDER BY volatility DESC;


-- 3. Yearly Return Summary
SELECT Symbol, YEAR(Date) AS year,
       ROUND(AVG(`Return`), 6) AS avg_return,
       ROUND(STDDEV_SAMP(`Return`), 6) AS vol
FROM sp500_stocks
GROUP BY Symbol, year
ORDER BY year, Symbol;


-- 4. Monthly Performance Trends
SELECT Symbol, YEAR(Date) AS year, MONTH(Date) AS month,
       ROUND(AVG(`Return`), 6) AS avg_return,
       ROUND(SUM(`Return`), 6) AS cum_return
FROM sp500_stocks
GROUP BY Symbol, year, month
ORDER BY year, month, Symbol;


-- 5. Stock-Specific Query (Example: AAPL)
SELECT Date, Price, ROUND(`Return`, 6) AS daily_return, ROUND(MA_20, 6) AS MA_20, ROUND(Vol_20, 6) AS Vol_20
FROM sp500_stocks
WHERE Symbol = 'AAPL'
ORDER BY Date ASC
LIMIT 20;

-- Summary of Average Return and Volatility by Stock
SELECT Symbol,
       ROUND(AVG(`Return`), 6) AS avg_return,
       ROUND(STDDEV_SAMP(`Return`), 6) AS volatility
FROM sp500_stocks
WHERE Symbol IN ('AAPL', 'MSFT', 'AMZN')
GROUP BY Symbol
ORDER BY avg_return DESC;
