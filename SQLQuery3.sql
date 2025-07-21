-- PREGUNTA 3 - ¿Cuál fue el porcentaje de crecimiento semana a semana en la cantidad de visitantes durante las últimas cuatro semanas?

-- Consultando la tabla a utilizar

SELECT * FROM restaurants_visitors_limpio;

-- En esta parte se agrupan las visitas por año y semana, y se suma la cantidad total de visitantes por semana

WITH WeeklyTotals AS (
    SELECT 
        DATEPART(YEAR, visit_date) AS year,
        DATEPART(WEEK, visit_date) AS week,
        SUM(reserve_visitors) AS total_visitors
    FROM restaurants_visitors_limpio
    GROUP BY DATEPART(YEAR, visit_date), DATEPART(WEEK, visit_date)
),

-- Se hacen los cálculos para comparar los visitantes de cada semana con los de la semana anterior para calcular el porcentaje de crecimiento

WeekComparison AS (
    SELECT 
        curr.year,
        curr.week,
        curr.total_visitors,
        prev.total_visitors AS previous_visitors,
        CASE 
            WHEN prev.total_visitors = 0 THEN NULL
            ELSE CAST(curr.total_visitors - prev.total_visitors AS FLOAT) / prev.total_visitors * 100
        END AS growth_percentage
    FROM WeeklyTotals AS curr
    LEFT JOIN WeeklyTotals AS prev
        ON curr.year = prev.year AND curr.week = prev.week + 1
)

-- Se realiza el último para que consiste en dar formato para las últimas cuatro semanas con su crecimiento semana a semana

SELECT TOP 4
    year,
    week,
    total_visitors,
    previous_visitors,
    growth_percentage
FROM WeekComparison
ORDER BY year DESC, week DESC;