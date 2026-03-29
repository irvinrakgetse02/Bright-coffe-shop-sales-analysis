
    -- I want to see my table in the coding to start exploryting each column
    SELECT ,
    FROM `retail_analysis`.`default`.`bright_coffee_shop_analysis_case_study1`
    LIMIT 10;
    
    ------------------------------------------------
    -- 1. Checking the Date Range
    -------------------------------------------------
    -- They started collecting the data 2023-01-01
    SELECT MIN(transaction_date) AS min_date 
    FROM `retail_analysis`.`default`.`bright_coffee_shop_analysis_case_study1`;
    -- the duration of the data is 6 months
    --  They last collected the data 2023-06-30
    
    SELECT MAX(transaction_date) AS latest_date 
    FROM `retail_analysis`.`default`.`bright_coffee_shop_analysis_case_study1`;
    -------------------------------------------------
    -- 2. Checking the names of the different stores
    -----------------------------------------------
    --- we have 3 stores and their names are Lower Manhattan, Hell's Kitchen, Astoria
    SELECT DISTINCT store_location
    FROM `retail_analysis`.`default`.`bright_coffee_shop_analysis_case_study1`;
    
    SELECT COUNT(DISTINCT store_id) AS number_of_stores
    FROM `retail_analysis`.`default`.`bright_coffee_shop_analysis_case_study1`;
    -------------------------------------------------
    -- 3. Checking products sold at our stores 
    ------------------------------------------------
    SELECT DISTINCT product_category
    FROM `retail_analysis`.`default`.`bright_coffee_shop_analysis_case_study1`;
    
    SELECT DISTINCT product_detail
    FROM `retail_analysis`.`default`.`bright_coffee_shop_analysis_case_study1`;
    SELECT DISTINCT product_type"
    FROM `retail_analysis`.`default`.`bright_coffee_shop_analysis_case_study1`;
    
    SELECT DISTINCT product_category AS category,
                   product_detail AS product_name
    FROM `retail_analysis`.`default`.`bright_coffee_shop_analysis_case_study1`;
    
    -------------------------------------------------
    -- 1. Checking product prices
    ------------------------------------------------
    SELECT MIN(unit_price) As cheapest_price
    FROM `retail_analysis`.`default`.`bright_coffee_shop_analysis_case_study1`;
    
    SELECT MAX(unit_price) As expensive_price
    FROM `retail_analysis`.`default`.`bright_coffee_shop_analysis_case_study1`;
    
    ----------the master piece code
    
    SELECT transaction_id,
           transaction_date,
           transaction_time,
           transaction_qty,
           store_id,
           store_location,
           product_id,
           unit_price,
           product_type,
           product_category,
           product_detail,
           -----Adding columns to inhance the insights
           Dayname(transaction_date) AS day_name,
           Monthname(transaction_date) AS Month_name,
           Dayofmonth(transaction_date) AS day_of_month,
           COUNT(DISTINCT transaction_id) AS number_transactions,
           COUNT(DISTINCT store_id) AS number_of_stores,
           COUNT(DISTINCT product_id) AS number_of_products,
           SUM(transaction_qty *unit_price) AS revenue_per_day,
           date_format(transaction_time, 'HH:mm:ss') AS purchase_time,
    ---------------CHECKING IF ITS WEEKEND OR WEEKDAY
           CASE
           WHEN DAYOFWEEK(transaction_date) IN (1,  7) THEN 'weekend'
           ELSE 'weeekday'
           END AS day_type,
    -----------------CHECKING THE TIME BUCKET
           CASE\n",
           WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '05:00:00' AND '11:59:59' THEN 'Morning'
           WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '17:59:59' THEN 'afternoon'
           WHEN date_format(transaction_time, 'HH:mm:ss') >= '18:00:00' THEN 'evening'
           END AS time_buckets,
    ------------CHECKING THE SPEND BUCKET
    CASE 
           
          WHEN(transaction_qty * unit_price) < 5.00 THEN  '01. low spend'
           WHEN (transaction_qty * unit_price)  BETWEEN 5.00 AND 15.00 THEN '02. medium spend'
           WHEN (transaction_qty * unit_price) > 15.00 THEN '03. high spend'
           ELSE '04. review neede'
           END AS spend_buckets,
    --------CHECKING THE ORDER SIZE
    CASE 
            WHEN transaction_qty = 1 THEN ' 01. Single Order'
            WHEN transaction_qty = 2 THEN '02. Duo/Pair'
            WHEN transaction_qty >= 3 THEN '03 Group/Bulk'
        END AS order_size_type,
        ---------PRODUCT STRATEGIC GROUP
        CASE 
            WHEN product_category IN ('Coffee', 'Tea') THEN 'O1. High Volume (Beverage)'
            WHEN product_category = 'Bakery' THEN '02. High Margin (Food)'
            WHEN product_category = 'Drinking Chocolate' THEN '03. Seasonal Specialty'
            ELSE '04. Other'
        END AS strategic_group,
        ------------STORE PERFOMANCE
        CASE 
        WHEN store_location = 'Lower Manhattan' THEN '01. Tier 1 - Financial District'
        WHEN store_location = 'Hell''s Kitchen' THEN '02. Tier 2 - Residential/Tourist'
        WHEN store_location = 'Astoria' THEN '03. Tier 3 - Neighborhood'
        ELSE '04. Other'
    END AS store_segment
    
     FROM `retail_analysis`.`default`.`bright_coffee_shop_analysis_case_study1`
      GROUP BY  transaction_id,
           transaction_time,
           transaction_qty,
           store_id,
           store_location,
           product_id,
           unit_price,
           product_type,
           product_category,
           product_detail,    
           day_name,
           Month_name,
           day_of_month,
           purchase_time,
           spend_buckets,
           order_size_type,
           strategic_group,
           store_segment;
 
