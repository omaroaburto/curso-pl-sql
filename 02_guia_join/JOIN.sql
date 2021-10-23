-- Nombr: Omaro Aburto --
-- Fecha: 01-10-2021   --
-- Tema : Gu�a join    --

--Creaci�n de tablas
--CLIENTE (NCLIENTE, NOMBRE)
CREATE TABLE G2_CLIENTE(
    NCLIENTE INTEGER GENERATED ALWAYS AS IDENTITY,
    NOMBRE VARCHAR(20),
    PRIMARY KEY(NCLIENTE)
); 
--PRODUCTO (COD, DESCRIPCI�N, TIPO, PRECIO)
CREATE TABLE G2_PRODUCTO(
    COD INTEGER GENERATED ALWAYS AS IDENTITY,
    DESCRIPCION VARCHAR(20),
    TIPO VARCHAR(20),
    PRECIO INTEGER,
    PRIMARY KEY(COD)
); 
--VENTA (COD, NCLIENTE, FECHA, CANTIDAD)
CREATE TABLE G2_VENTA(
    COD INTEGER,
    NCLIENTE INTEGER,
    FECHA DATE,
    CANTIDAD INTEGER,
    PRIMARY KEY(COD, NCLIENTE, FECHA),
    FOREIGN KEY(COD) REFERENCES G2_PRODUCTO,
    FOREIGN KEY(NCLIENTE) REFERENCES G2_CLIENTE 
);

--INSERT CLIENTE
INSERT INTO G2_CLIENTE(NOMBRE) VALUES('JUAN');
INSERT INTO G2_CLIENTE(NOMBRE) VALUES('MAR�A');
INSERT INTO G2_CLIENTE(NOMBRE) VALUES('PEDRO');

--INSERT PRODUCTO (COD, DESCRIPCI�N, TIPO, PRECIO)
INSERT INTO G2_PRODUCTO(DESCRIPCION, TIPO, PRECIO) VALUES('TV','ELECTRO',100000);
INSERT INTO G2_PRODUCTO(DESCRIPCION, TIPO, PRECIO) VALUES('PC','TECNO',70000);
INSERT INTO G2_PRODUCTO(DESCRIPCION, TIPO, PRECIO) VALUES('LAVADORA','ELECTRO',100000);

--INSERT VENTA (COD, NCLIENTE, FECHA, CANTIDAD)
INSERT INTO G2_VENTA(COD, NCLIENTE, FECHA, CANTIDAD) VALUES(1,1,'10-10-2020',1);
INSERT INTO G2_VENTA(COD, NCLIENTE, FECHA, CANTIDAD) VALUES(1,1,'01-02-2021',3);

SELECT * FROM G2_VENTA

------PREGUNTAS GU�A DE JOIN-----------------------------------------------------
--1. Listar el nombre de los clientes no tienen ventas asociadas
SELECT C.NOMBRE
FROM  G2_CLIENTE C
LEFT JOIN G2_VENTA V  ON V.NCLIENTE = C.NCLIENTE 
WHERE V.COD IS NULL;
--2. Listar los tipos de productos que se han vendido.
SELECT P.TIPO
FROM G2_PRODUCTO P
INNER JOIN G2_VENTA V ON P.COD = V.COD;
--3. Mostrar el nombre y tipo de productos que se tienen registrados, independiente si se han vendido o no.

--4. Mostrar la cantidad de clientes tienen asociadas ventas
SELECT COUNT(1)
FROM G2_CLIENTE C
INNER JOIN G2_VENTA V ON C.NCLIENTE = V.NCLIENTE;
--5. Muestre el nombre del cliente y total recibido de sus ventas asociadas (precio*cantidad) 
SELECT C.NOMBRE, (P.PRECIO* V.CANTIDAD) 
FROM G2_VENTA V
INNER JOIN  G2_CLIENTE  C ON C.NCLIENTE = V.NCLIENTE
INNER JOIN  G2_PRODUCTO P ON P.COD      = V.COD;
--6. Calcule la tasa de inefectividad de los clientes (clientes sin ventas vs total de clientes)
CREATE VIEW V2_CANT_CLIENTES AS(
    SELECT COUNT(1) AS TOTAL_CLIENTES
    FROM G2_CLIENTE
);

CREATE VIEW V2_CANT_CLIENTE_SIN_VENTAS AS (
    SELECT COUNT(1) AS CANT_CLIENTES_SIN_VENTAS
    FROM G2_CLIENTE C
    LEFT JOIN G2_VENTA V ON C.NCLIENTE = V.NCLIENTE 
    WHERE V.NCLIENTE IS NULL
);
--tasa de inefectividad
SELECT (CANT_CLIENTES_SIN_VENTAS/TOTAL_CLIENTES) AS TASA_INEFECTIVIDAD
FROM V2_CANT_CLIENTE_SIN_VENTAS, V2_CANT_CLIENTES
