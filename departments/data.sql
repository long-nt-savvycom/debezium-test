INSERT INTO public.dw_deliveries (delivery_id, delivery_date, delivery_status, department, customer_id, delivery_address, delivery_cost) VALUES
(1, '2024-08-01', 'Delivered', 'Delivery Department', 101, '123 Elm St, Springfield', 50.00),
(2, '2024-08-02', 'Pending', 'Delivery Department', 102, '456 Oak St, Springfield', 35.00),
(3, '2024-08-03', 'In Transit', 'Delivery Department', 103, '789 Pine St, Springfield', 45.00);

INSERT INTO public.dw_products (product_id, product_name, category, price) VALUES
(1, 'Product A', 'Electronics', 25.00),  -- Corresponds to product_id 201
(2, 'Product B', 'Home Appliances', 50.00),  -- Corresponds to product_id 202
(3, 'Product C', 'Furniture', 35.00),  -- Corresponds to product_id 203
(4, 'Product D', 'Clothing', 15.00);  -- Corresponds to product_id 204

INSERT INTO public.dw_revenues (revenue_id, transaction_date, amount, department, revenue_type, customer_id) VALUES
(1, '2024-08-01', 2000.00, 'Revenue Department', 'Product Sale', 101),
(2, '2024-08-02', 500.00, 'Revenue Department', 'Subscription', 102),
(3, '2024-08-03', 1500.00, 'Revenue Department', 'Service Fee', 103);

INSERT INTO public.dw_campaigns (campaign_id, campaign_name, start_date, end_date, department, budget) VALUES
(1, 'Summer Sale', '2024-07-01', '2024-07-31', 'Marketing Department', 10000.00),
(2, 'New Product Launch', '2024-08-01', '2024-08-10', 'Marketing Department', 15000.00),
(3, 'Holiday Promotion', '2024-12-01', '2024-12-31', 'Marketing Department', 20000.00);

INSERT INTO public.dw_sales (sale_id, sale_date, total_amount, department, customer_id, sale_status) VALUES
(1, '2024-08-01', 150.00, 'Sales Department', 101, 'Completed'),
(2, '2024-08-02', 75.00, 'Sales Department', 102, 'Pending'),
(3, '2024-08-03', 200.00, 'Sales Department', 103, 'Completed');

INSERT INTO public.dw_delivery_items (delivery_item_id, delivery_id, product_id, quantity, price) VALUES
(1, 1, 201, 2, 25.00),
(2, 1, 202, 1, 50.00),
(3, 2, 203, 1, 35.00),
(4, 3, 204, 3, 15.00);

INSERT INTO public.dw_revenue_sources (revenue_source_id, revenue_id, source_description) VALUES
(1, 1, 'Online Store'),
(2, 2, 'Monthly Subscription'),
(3, 3, 'Consulting Service');

INSERT INTO public.dw_campaign_metrics (campaign_metric_id, campaign_id, metric_name, metric_value) VALUES
(1, 1, 'Impressions', 150000),
(2, 1, 'Clicks', 5000),
(3, 2, 'Impressions', 200000),
(4, 2, 'Clicks', 7000),
(5, 3, 'Impressions', 300000),
(6, 3, 'Clicks', 12000);

INSERT INTO public.dw_sales_items (sale_item_id, sale_id, product_id, quantity, price) VALUES
(1, 1, 301, 3, 50.00),
(2, 2, 302, 1, 75.00),
(3, 3, 303, 2, 100.00);
