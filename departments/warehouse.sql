CREATE TABLE public.dw_deliveries (
    delivery_id SERIAL PRIMARY KEY,
    delivery_date DATE,
    delivery_status VARCHAR(50),
    department VARCHAR(100),
    customer_id INT,
    delivery_address TEXT,
    delivery_cost DECIMAL(10, 2)
);

CREATE TABLE public.dw_delivery_items (
    delivery_item_id SERIAL PRIMARY KEY,
    delivery_id INT REFERENCES public.dw_deliveries(delivery_id),
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2)
);

CREATE TABLE public.dw_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100),
    price DECIMAL(10, 2)
);

CREATE TABLE public.dw_revenues (
    revenue_id SERIAL PRIMARY KEY,
    transaction_date DATE,
    amount DECIMAL(15, 2),
    department VARCHAR(100),
    revenue_type VARCHAR(100),
    customer_id INT
);

CREATE TABLE public.dw_revenue_sources (
    revenue_source_id SERIAL PRIMARY KEY,
    revenue_id INT REFERENCES public.dw_revenues(revenue_id),
    source_description TEXT
);

CREATE TABLE public.dw_campaigns (
    campaign_id SERIAL PRIMARY KEY,
    campaign_name VARCHAR(255),
    start_date DATE,
    end_date DATE,
    department VARCHAR(100),
    budget DECIMAL(15, 2)
);

CREATE TABLE public.dw_campaign_metrics (
    campaign_metric_id SERIAL PRIMARY KEY,
    campaign_id INT REFERENCES public.dw_campaigns(campaign_id),
    metric_name VARCHAR(255),
    metric_value DECIMAL(10, 2)
);

CREATE TABLE public.dw_sales (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE,
    total_amount DECIMAL(15, 2),
    department VARCHAR(100),
    customer_id INT,
    sale_status VARCHAR(50)
);

CREATE TABLE public.dw_sales_items (
    sale_item_id SERIAL PRIMARY KEY,
    sale_id INT REFERENCES public.dw_sales(sale_id),
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2)
);
