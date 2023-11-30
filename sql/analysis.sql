-- 1.Booking Patterns
-- Trend in booking patterns over time
SELECT EXTRACT(YEAR FROM booking_date) AS booking_year, COUNT(*) AS bookings_count
FROM bookings
GROUP BY booking_year
ORDER BY booking_year;

-- Months or seasons with increased booking activity
SELECT EXTRACT(MONTH FROM booking_date) AS booking_month, COUNT(*) AS bookings_count
FROM bookings
GROUP BY booking_month
ORDER BY booking_month;

-- Lead time across different booking channels and its correlation with customer type
SELECT distribution_channel, customer_type, AVG(lead_time) AS avg_lead_time
FROM bookings
GROUP BY distribution_channel, customer_type;

--2.Customer Behavior Analysis
-- Contribution of distribution channels to bookings and ADR differences
SELECT distribution_channel, COUNT(*) AS bookings_count, AVG(avg_daily_rate) AS avg_rate
FROM bookings
GROUP BY distribution_channel;

-- Patterns in the distribution of guests based on their country of origin
SELECT country, COUNT(*) AS guest_count, SUM(revenue) AS total_revenue
FROM bookings
GROUP BY country;

-- 3.Cancellation Analysis:
-- Factors correlated with cancellations and predictive analysis
-- Assuming factors are in columns like lead_time, distribution_channel, deposit_type, etc.
-- SELECT *
-- FROM (
--     SELECT *, CORR(cancelled::int, lead_time) AS corr_lead_cancel, CORR(cancelled::int, avg_daily_rate) AS corr_adr_cancel
--     -- Add other correlated factors
--     FROM bookings
-- ) AS corr_analysis;


-- Revenue loss comparison across customer segments and distribution channels
SELECT customer_type, distribution_channel, SUM(revenue_loss) AS total_loss
FROM bookings
WHERE cancelled = TRUE
GROUP BY customer_type, distribution_channel
ORDER BY total_loss;

--4.Revenue Optimization:
-- Overall revenue trend and significant contributors
SELECT EXTRACT(YEAR FROM booking_date) AS booking_year, SUM(revenue) AS total_revenue
FROM bookings
GROUP BY booking_year
ORDER BY booking_year;

-- Optimal pricing strategies based on ADR
SELECT customer_type, distribution_channel, AVG(avg_daily_rate) AS avg_rate
FROM bookings
GROUP BY customer_type, distribution_channel;

--5.Geographical Analysis:
-- Distribution of guests across countries and potential marketing targets:
SELECT country, COUNT(*) AS guest_count
FROM bookings
GROUP BY country
ORDER BY guest_count DESC;

-- Correlation between country of origin and cancellations or extended stays
SELECT country, AVG(nights) AS avg_stay, COUNT(*) FILTER(WHERE cancelled = TRUE) AS cancelled_bookings
FROM bookings
GROUP BY country;

-- 6.Operational Efficiency:
-- Average length of stay based on booking channels or customer types:
SELECT distribution_channel, AVG(nights) AS avg_stay
FROM bookings
GROUP BY distribution_channel;

-- Patterns in check-out dates
SELECT EXTRACT(DAY FROM status_update) AS checkout_day, COUNT(*) AS checkouts_count
FROM bookings
WHERE status = 'Check-Out'
GROUP BY checkout_day
ORDER BY checkout_day;


-- 7. Impact of Deposit Types:
-- Impact on cancellations and revenue generation
SELECT deposit_type, COUNT(*) FILTER(WHERE cancelled = TRUE) AS cancelled_count, SUM(revenue_loss) AS total_loss
FROM bookings
GROUP BY deposit_type;

-- Patterns in the use of deposit types across customer segments
SELECT customer_type, deposit_type, COUNT(*) AS deposit_count
FROM bookings
GROUP BY customer_type, deposit_type;

-- 8. Analysis of Corporate Bookings
-- Proportion and ADR comparison
SELECT customer_type, AVG(avg_daily_rate) AS avg_rate, COUNT(*) AS bookings_count
FROM bookings
WHERE customer_type = 'Corporate'
GROUP BY customer_type;

-- Trends related to corporate bookings:
SELECT EXTRACT(YEAR FROM booking_date) AS booking_year, COUNT(*) AS corporate_bookings
FROM bookings
WHERE customer_type = 'Corporate'
GROUP BY booking_year
ORDER BY booking_year;

-- 9. Time-to-Event Analysis
-- Effect of lead time on revenue and cancellations
SELECT lead_time, AVG(revenue) AS avg_revenue, COUNT(*) FILTER(WHERE cancelled = TRUE) AS cancelled_bookings
FROM bookings
GROUP BY lead_time;


-- 10. Comparison of Online and Offline Travel Agents:
-- Revenue contribution comparison
SELECT distribution_channel, SUM(revenue) AS total_revenue
FROM bookings
GROUP BY distribution_channel;

-- Cancellation rates and revenue variations
SELECT distribution_channel, COUNT(*) FILTER(WHERE cancelled = TRUE) AS cancelled_bookings, SUM(revenue_loss) AS total_loss
FROM bookings
GROUP BY distribution_channel;

