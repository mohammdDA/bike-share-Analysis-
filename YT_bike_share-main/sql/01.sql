
CREATE OR REPLACE VIEW bike_share_view AS

WITH bike_share AS (

    SELECT
        dteday,
        season,
        yr,
        mnth,
        hr,
        holiday,
        weekday,
        workingday,
        weathersit,
        temp,
        atemp,
        hum,
        windspeed,
        rider_type,
        riders
    FROM bike_share_yr_0

    UNION ALL

    SELECT
        dteday,
        season,
        yr,
        mnth,
        hr,
        holiday,
        weekday,
        workingday,
        weathersit,
        temp,
        atemp,
        hum,
        windspeed,
        rider_type,
        riders
    FROM bike_share_yr_1
)

SELECT
    STR_TO_DATE(b.dteday, '%e/%c/%Y') AS dteday,
    b.season,
    b.yr,
    b.weekday,
    b.hr,
    b.rider_type,
    b.riders,
    c.price,
    c.COGS,

    ROUND(b.riders * c.price, 2) AS revenue,

    ROUND(
        (b.riders * c.price) - c.COGS,
        2
    ) AS profit

FROM bike_share b

LEFT JOIN cost_table c
    ON b.yr = c.yr;
