
CONSULTAS CON JOINS

CONSULTA 1

SELECT
    v.fecha,
    v.id_cliente,
    c.nombre AS nombre_cliente,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria;



    CONSULTA 2

    SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;



CONSULTA 3

SELECT
    p.nombre_producto,
    c.nombre_categoria AS categoria,
    p.precio
FROM productos AS p
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
INNER JOIN categorias AS c
    ON p.id_categoria = c.id_categoria
WHERE v.id_producto IS NULL;



CONSULTA 4

SELECT
    canal,
    SUM(total) AS total_por_canal
FROM (
    SELECT
        fecha,
        cantidad * precio_unitario AS total,
        'Online' AS canal
    FROM ventas
    WHERE cantidad <= 3

    UNION ALL

    SELECT
        fecha,
        cantidad * precio_unitario AS total,
        'Presencial' AS canal
    FROM ventas
    WHERE cantidad > 3
) AS ventas_consolidadas
GROUP BY canal;
