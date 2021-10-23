
--1. Muestra el nombre de las recetas que utilizan de tipo cereal o lácteos.
SELECT r.rec_nombre
FROM receta r, producto p, requiere x
WHERE r.rec_cod = x.rec_cod AND p.pro_cod = x.pro_cod
      AND (p.pro_tipo ='CEREAL' OR p.pro_tipo = 'LACTEO');  

--2. Muestre la cantidad de productos que utiliza cada receta agrupando por tipo de producto

SELECT r.rec_nombre ,p.pro_tipo, count(p.pro_tipo)
FROM receta r, producto p, requiere x
WHERE r.rec_cod = x.rec_cod AND p.pro_cod = x.pro_cod
GROUP BY r.rec_nombre, p.pro_tipo;

--3. Muestra el nombre de las recetas que no utilizan más de 500 gramos de harina

SElECT r.rec_nombre
FROM receta r, requiere x, producto p
WHERE   r.rec_cod = x.rec_cod AND p.pro_cod = x.pro_cod 
        AND x.req_cantidad<=500 AND p.pro_nombre='HARINA';

--4. Muestre el nombre de las recetas y la cantidad de productos que requieren las recetas que no sean de
--tipo masa y que utilizan más de 2 productos.

SElECT  r.rec_nombre, COUNT(x.req_cantidad)
FROM    receta r, requiere x, producto p
WHERE   r.rec_cod = x.rec_cod AND p.pro_cod = x.pro_cod 
        AND r.rec_tipo <> 'MASA'
GROUP BY r.rec_nombre
HAVING count(x.rec_cod)> 2;


--5. Muestre el nombre y tipo de las recetas que no contienen el producto manzana y que sea de tipo distinto
--a pastelería.

SElECT  DISTINCT r.rec_nombre, r.rec_tipo
FROM    receta r, requiere x, producto p
WHERE   r.rec_cod = x.rec_cod AND p.pro_cod = x.pro_cod 
        AND p.pro_nombre <>'MANZANA' AND r.rec_tipo <> 'PASTELERIA';

--6. Muestre los tipos de recetas que han utilizado la mayor cantidad de producto de tipo lácteos
CREATE VIEW REC_LACT AS(
    SELECT R.REC_TIPO, COUNT(1) AS CANTIDAD
    FROM RECETA R, REQUIERE RE, PRODUCTO P
    WHERE R.REC_COD = RE.REC_COD AND P.PRO_COD = RE.PRO_COD
          AND P.PRO_TIPO IN('LACTEO')
    GROUP BY R.REC_TIPO
); 

SELECT RL.REC_TIPO, MAX(RL.CANTIDAD)
FROM REC_LACT RL
GROUP BY RL.REC_TIPO;

--7. Muestre el nombre de los productos y el porcentaje de uso de productos con respecto al total de recetas

CREATE VIEW TOTAL_REC AS(
    SELECT COUNT(1) AS CANT_REC
    FROM RECETA
);

CREATE VIEW PROD_UTILIZADOS AS (
    SELECT P.PRO_NOMBRE, COUNT(1) AS CANT_PROD 
    FROM PRODUCTO P, REQUIERE RE, RECETA R
    WHERE R.REC_COD = RE.REC_COD AND P.PRO_COD = RE.PRO_COD
    GROUP BY P.PRO_NOMBRE
);

SELECT P.PRO_NOMBRE AS PRODUCTO, (P.CANT_PROD/T.CANT_REC)*100 AS PORCENTAJE 
FROM TOTAL_REC T, PROD_UTILIZADOS P
