
M4_ CONSULTAS_NEGOCIO.SQL


CONSULTA 1



SELECT
    MONTH (fecha) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH (fecha)
ORDER BY mes;



CONSULTA 2

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;


CONSULTA 3


SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY cantidad_pedidos DESC;


CONSULTA 4

SELECT
    MONTH(fecha) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha)
ORDER BY mes;

 
SELECT
    MONTH(fecha) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) > 
             (SELECT AVG(total_mensual)
              FROM (
                  SELECT SUM(cantidad * precio_unitario) AS total_mensual
                  FROM ventas
                  GROUP BY MONTH(fecha)
              ) AS meses)
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas
GROUP BY MONTH(fecha)
ORDER BY mes;










WITH ventas_mensuales AS (
    SELECT
        MONTH(fecha) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha)
)

SELECT
    mes,
    total_facturado,
    CASE
        WHEN total_facturado > (
            SELECT AVG(total_facturado)
            FROM ventas_mensuales
        )
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas_mensuales
ORDER BY mes;




HALLASGOS

1)  EN MARZO SE REALIZAO  PEDIDOS

2) EL PRODUCTO 1 FUE EL QUE MAYOR FACTURO , PERO EL QUE MENOS SE VENDIERON

3) SE ENCOTRARON 5 CLIENTES Y CADA UNO REALIZO 2 PEDIDOS.

