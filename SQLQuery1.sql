-- Se crea la base de datos para poder realizar las consultas

CREATE DATABASE didi_challenge;
USE didi_challenge;

-- PREGUNTA 1 - ¿Cuáles son los cinco restaurantes con el mayor promedio de visitantes durante los días festivos?

-- Consultando los archivos a utilizar para responder la pregunta

SELECT * FROM restaurants_visitors_limpio;
SELECT * FROM date_info;

-- Query para consultar la lista de los cinco restaurantes con mayor promedio de visitantes en días festivos

SELECT TOP 5 
    rv.id AS restaurant_id,
    AVG(rv.reserve_visitors) AS avg_visitors_on_holidays
FROM restaurants_visitors_limpio AS rv
INNER JOIN date_info AS di ON rv.visit_date = di.calendar_date
WHERE di.holiday_flg = 1
GROUP BY rv.id
ORDER BY avg_visitors_on_holidays DESC;
