CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    hotel VARCHAR(50),
    booking_date DATE,
    arrival_date DATE,
    lead_time INTEGER,
    nights INTEGER,
    guests INTEGER,
    distribution_channel VARCHAR(50),
    customer_type VARCHAR(50),
    country VARCHAR(50),
    deposit_type VARCHAR(50),
    avg_daily_rate DECIMAL(10, 2),
    status VARCHAR(50),
    status_update DATE,
    cancelled BOOLEAN,
    revenue DECIMAL(10, 2),
    revenue_loss DECIMAL(10, 2)
);
