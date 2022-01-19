-- Tema: Cursores

CREATE TABLE G8_CATEGORIA(
    COD_CAT INTEGER,
    NOMBRE_CAT VARCHAR(50) NOT NULL,
    PRIMARY KEY(COD_CAT)
);

INSERT INTO G8_CATEGORIA(COD_CAT, NOMBRE_CAT) VALUES(1,'ZAPATOS');
INSERT INTO G8_CATEGORIA(COD_CAT, NOMBRE_CAT) VALUES(2,'ZAPATILLAS');

CREATE TABLE G8_CLIENTE(
    RUT_CLI VARCHAR(11),
    NOMBRE_CLI VARCHAR(50) NOT NULL,
    PRIMARY KEY(RUT_CLI)
);

INSERT INTO G8_CLIENTE(RUT_CLI, NOMBRE_CLI) VALUES('17020309-K','OMARO ABURTO'); 
INSERT INTO G8_CLIENTE(RUT_CLI, NOMBRE_CLI) VALUES('18124700-9','PEDRO ABARCA'); 

CREATE TABLE G8_TEMPORADA(
    COD_TEMP INTEGER,
    NOMBRE_TEMP VARCHAR(50) NOT NULL,
    MES_INICIO DATE NOT NULL,
    MES_FIN DATE,
    PRIMARY KEY(COD_TEMP)
);

INSERT INTO G8_TEMPORADA(COD_TEMP, NOMBRE_TEMP, MES_INICIO, MES_FIN) VALUES(1,'OTO�O','20-03-2021', '21-06-2021');
INSERT INTO G8_TEMPORADA(COD_TEMP, NOMBRE_TEMP, MES_INICIO, MES_FIN) VALUES(2,'IVIERNO','22-06-2021', '21-09-2021');
INSERT INTO G8_TEMPORADA(COD_TEMP, NOMBRE_TEMP, MES_INICIO, MES_FIN) VALUES(3,'PRIMAVERA','22-09-2021', '21-09-2021');
INSERT INTO G8_TEMPORADA(COD_TEMP, NOMBRE_TEMP, MES_INICIO, MES_FIN) VALUES(4,'VERANO','21-12-2021', '20-03-2022');
 
CREATE TABLE G8_PRODUCTO(
    COD_PR INTEGER,
    NOMBRE_PR VARCHAR(50) NOT NULL,
    PRECIO_COMPRA INTEGER,
    PRECIO_VENTA INTEGER,
    STOCK INTEGER,
    COD_CAT_FK INTEGER,
    PRIMARY KEY(COD_PR),
    FOREIGN KEY(COD_CAT_FK) REFERENCES G8_CATEGORIA(COD_CAT)
);

INSERT INTO G8_PRODUCTO(COD_PR, NOMBRE_PR,PRECIO_COMPRA, PRECIO_VENTA, STOCK, COD_CAT_FK) 
VALUES(1, 'ZAPATILLAS TILLAS', 11000, 20000, 50, 2);
INSERT INTO G8_PRODUCTO(COD_PR, NOMBRE_PR,PRECIO_COMPRA, PRECIO_VENTA, STOCK, COD_CAT_FK) 
VALUES(2, 'ZAPATILLAS DEPORTIVAS', 21000, 35000, 75, 2);
INSERT INTO G8_PRODUCTO(COD_PR, NOMBRE_PR,PRECIO_COMPRA, PRECIO_VENTA, STOCK, COD_CAT_FK) 
VALUES(3, 'ZAPATITOS', 37330, 55000, 1050, 1);

CREATE TABLE G8_PROD_TEMP(
    COD_PR_FK INTEGER,
    COD_TEMP_FK INTEGER,
    PRIMARY KEY(COD_PR_FK, COD_TEMP_FK),
    FOREIGN KEY(COD_PR_FK) REFERENCES G8_PRODUCTO(COD_PR),
    FOREIGN KEY(COD_TEMP_FK) REFERENCES G8_TEMPORADA(COD_TEMP)
);

CREATE TABLE G8_VENTA(
    COD_PR_FK INTEGER,
    RUT_CLI_FK VARCHAR(11),
    FECHA DATE,
    VALOR_FINAL INTEGER,
    VALOR_DESCUENTO INTEGER,
    PRIMARY KEY(COD_PR_FK,RUT_CLI_FK, FECHA),
    FOREIGN KEY(COD_PR_FK) REFERENCES G8_PRODUCTO(COD_PR),
    FOREIGN KEY(RUT_CLI_FK) REFERENCES G8_CLIENTE(RUT_CLI)
);

INSERT INTO G8_VENTA(COD_PR_FK, RUT_CLI_FK, FECHA, VALOR_FINAL, VALOR_DESCUENTO) 
VALUES(1,'17020309-K', '10-03-2021',11000, 0);
INSERT INTO G8_VENTA(COD_PR_FK, RUT_CLI_FK, FECHA, VALOR_FINAL, VALOR_DESCUENTO) 
VALUES(1,'17020309-K', '15-03-2021',11000, 0);

CREATE TABLE PROD_TEMP(
    COD_PR_FK INTEGER,
    COD_TEMP_FK INTEGER,
    PRIMARY KEY(COD_PR_FK, COD_TEMP_FK),
    FOREIGN KEY(COD_PR_FK) REFERENCES G8_PRODUCTO(COD_PR),
    FOREIGN KEY(COD_TEMP_FK) REFERENCES G8_TEMPORADA(COD_TEMP)
);

INSERT INTO PROD_TEMP(COD_PR_FK, COD_TEMP_FK) VALUES(1,3);
INSERT INTO PROD_TEMP(COD_PR_FK, COD_TEMP_FK) VALUES(2,3);
--h 
--EJERCICIOS CURSORES 
--1. MUESTRE EL NOMBRE DE LOS PRODUCTOS Y LA CANTIDAD VENDIDA DURANTE LA TEMPORADA DE VERANO
DECLARE 
    CURSOR DATOS_TEMP_PRIMAVERA IS
        SELECT P.NOMBRE_PR, COUNT(1) AS CANTIDAD 
        FROM G8_PRODUCTO P
        INNER JOIN G8_VENTA V ON V.COD_PR_FK = P.COD_PR   
        WHERE P.COD_PR = (SELECT PT.COD_PR_FK  
                          FROM PROD_TEMP PT 
                          INNER JOIN G8_PRODUCTO P1 ON P1.COD_PR = PT.COD_PR_FK  
                          WHERE P.COD_PR = PT.COD_PR_FK AND PT.COD_TEMP_FK=3)
        GROUP BY P.NOMBRE_PR;
BEGIN
    IF() 
    DBMS_OUTPUT.PUT_LINE('¿Esto cómo lo imprimo?');  
END;
--2. IMPRIMA POR PANTALLA EL NOMBRE DE CADA CATEGORIA Y LA RENTABILIDAD DE VENTA(PRECIO DE VENTA- PRECIO DE COMPRA)
--QUE OBTENDR�A AL VENDER TODOS LOS PRODUCTOS. ADEM�S, INDIQUE CU�L ES LA CATEGORIA QUE TIENE M�S INGRESOS.

--3. MUESTRE POR PANTALLA EL VALOR TOTAL DE DESCUENTO APLICADO A UN DETERMINADO RUT INGRESADO POR TECLADO

--4. SE REALIZA UNA CLASIFICACI�N DE CLIENTES, CONSIDERANDO QUE SI EL CLIENTE HA REALIZADO M�S DE 3 COMPRAS SER�
--CONSIDERADO COMO CLIENTE PREFERENCIAL Y DE LO CONTRARIO REGULAR. POR LO QUE ES NECESARIO QUE IMPRIMA EL NOMBRE DE CADA
--CLIENTE Y LA CLASIFICACIóN ASIGNADA. ADEM�S, DE UN RESUMEN DE LA CANTIDAD DE CLIENTES PREFERENCIALES Y REGULARES.
