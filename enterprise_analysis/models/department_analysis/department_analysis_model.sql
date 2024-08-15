WITH total_revenue AS (
    SELECT
        SUM(amount) AS total_revenue
    FROM
        {{ source('public', 'dw_revenues') }}
),

total_deliveries AS (
    SELECT
        COUNT(*) AS total_deliveries
    FROM
        {{ source('public', 'dw_deliveries') }}
    WHERE
        delivery_status = 'Delivered'
),

total_sales AS (
    SELECT
        SUM(total_amount) AS total_sales
    FROM
        {{ source('public', 'dw_sales') }}
    WHERE
        sale_status = 'Completed'
),

campaign_performance AS (
    SELECT
        c.campaign_name,
        SUM(m.metric_value) FILTER (WHERE m.metric_name = 'Impressions') AS total_impressions,
        SUM(m.metric_value) FILTER (WHERE m.metric_name = 'Clicks') AS total_clicks,
        ROUND(
            SUM(m.metric_value) FILTER (WHERE m.metric_name = 'Clicks')::DECIMAL / 
            NULLIF(SUM(m.metric_value) FILTER (WHERE m.metric_name = 'Impressions'), 0) * 100, 2
        ) AS ctr -- Click-through rate
    FROM
        {{ source('public', 'dw_campaigns') }} c
    JOIN
        {{ source('public', 'dw_campaign_metrics') }} m ON c.campaign_id = m.campaign_id
    GROUP BY
        c.campaign_name
)

-- top_products AS (
--     SELECT
--         p.product_name,
--         SUM(si.quantity) AS total_quantity_sold
--     FROM
--         {{ source('public', 'dw_sales_items') }} si
--     JOIN
--         {{ source('public', 'dw_products') }} p ON si.product_id = p.product_id
--     GROUP BY
--         p.product_name
--     ORDER BY
--         total_quantity_sold DESC
--     LIMIT 5
-- )

SELECT
    tr.total_revenue,
    td.total_deliveries,
    ts.total_sales,
    cp.campaign_name,
    cp.total_impressions,
    cp.total_clicks,
    cp.ctr
    -- tp.product_name,
    -- tp.total_quantity_sold
FROM
    total_revenue tr,
    total_deliveries td,
    total_sales ts
JOIN
    campaign_performance cp ON TRUE
-- JOIN
--     top_products tp ON TRUE
