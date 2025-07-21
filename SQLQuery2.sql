-- PREGUNTA 2 - ¿Qué día de la semana suele haber más visitantes en promedio en los restaurantes?

-- Consultando los archivos a utilizar para responder la pregunta

SELECT * FROM restaurants_visitors_limpio;
SELECT * FROM date_info;

-- Query para obtener el promedio de visitantes por día de la semana

SELECT di.day_of_week,
    AVG(rv.reserve_visitors) AS avg_visitors
FROM restaurants_visitors_limpio AS rv
INNER JOIN date_info AS di ON rv.visit_date = di.calendar_date
GROUP BY di.day_of_week
ORDER BY avg_visitors DESC;