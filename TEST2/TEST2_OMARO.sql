--creaci�n de tablas
CREATE TABLE C2_FACTURA(
    FAC_CODIGO INTEGER,
    FAC_FECHA DATE NOT NULL,
    CONSTRAINT PK_FACTURA PRIMARY KEY(FAC_CODIGO)
); 
CREATE TABLE C2_CLIENTE(
    CLI_CODIGO INTEGER NOT NULL,
    CLI_NOMBRE VARCHAR(50) NOT NULL,
    CONSTRAINT PK_C2_CLIENTE PRIMARY KEY(CLI_CODIGO)
); 

CREATE TABLE C2_PROVEEDOR(
    PRO_RUT VARCHAR(12) NOT NULL,
    PRO_NOMBRE VARCHAR(50) NOT NULL,
    PRO_REPRESENTANTE VARCHAR(50) NOT NULL,
    CONSTRAINT PK_PROVEEDOR PRIMARY KEY(PRO_RUT)
);

CREATE TABLE C2_PRODUCTO(
    PRD_CODIGO INTEGER NOT NULL,
    PRD_NOMBRE VARCHAR(50) NOT NULL,
    PRD_PRECIO INTEGER NOT NULL,
    PRO_RUT VARCHAR(12) NOT NULL,
    CONSTRAINT PK_PRODUCTO PRIMARY KEY(PRD_CODIGO),
    CONSTRAINT FK_PRODUCTO_PROVEEDOR FOREIGN KEY(PRO_RUT) REFERENCES C2_PROVEEDOR(PRO_RUT)
);

 alter table C2_PRODUCTO
  drop constraint FK_PRODUCTO_PROVEEDOR;


CREATE TABLE C2_TELEFONO(
    TEL_NUMERO VARCHAR(13) NOT NULL,
    TEL_COMPANIA VARCHAR(20) NOT NULL,
    CONSTRAINT PK_TELEFONO PRIMARY KEY(TEL_NUMERO)
);

CREATE TABLE C2_TIENE(
    PRO_RUT VARCHAR(12) NOT NULL,
    TEL_NUMERO VARCHAR(13) NOT NULL,
    CONSTRAINT PK_PROVEEDOR_TELEFONO PRIMARY KEY(PRO_RUT, TEL_NUMERO),
    CONSTRAINT FK_TIENE_PROVEEDOR FOREIGN KEY(PRO_RUT) REFERENCES C2_PROVEEDOR(PRO_RUT),
    CONSTRAINT FK_TIENE_TELEFONO  FOREIGN KEY(TEL_NUMERO) REFERENCES C2_TELEFONO(TEL_NUMERO)
);
 
 
CREATE TABLE C2_COMPRA(
    PRD_CODIGO INTEGER,
    CLI_CODIGO INTEGER, 
    FAC_CODIGO INTEGER,
    COM_CANTIDAD INTEGER NOT NULL,
    CONSTRAINT PK_COMPRA PRIMARY KEY(PRD_CODIGO,CLI_CODIGO,FAC_CODIGO),
    CONSTRAINT FK_COMPRA_CLIENTE  FOREIGN KEY(CLI_CODIGO) REFERENCES C2_CLIENTE,
    CONSTRAINT FK_COMPRA_FACTURA  FOREIGN KEY(FAC_CODIGO) REFERENCES C2_FACTURA,
    CONSTRAINT FK_COMPRA_PRODUCTO FOREIGN KEY(PRD_CODIGO) REFERENCES C2_PRODUCTO
); 
 
INSERT
INTO C2_PRODUCTO(PRD_CODIGO, PRD_NOMBRE,PRD_PRECIO,PRO_RUT) 
VALUES (1, 'AUTO', 3000000, '17000309-8' );
INSERT
INTO C2_PRODUCTO(PRD_CODIGO, PRD_NOMBRE,PRD_PRECIO,PRO_RUT) 
VALUES (2, 'MOTO', 300000, '17000309-8' );

INSERT
INTO C2_CLIENTE(CLI_CODIGO, CLI_NOMBRE)
VALUES(1,'OMARO ABURTO');

INSERT
INTO C2_CLIENTE(CLI_CODIGO, CLI_NOMBRE)
VALUES(2,'PEDRO ACU�A');

INSERT
INTO C2_FACTURA(FAC_CODIGO, FAC_FECHA)
VALUES(1,'10-10-2022');

INSERT
INTO C2_FACTURA(FAC_CODIGO, FAC_FECHA)
VALUES(2,'01-10-2022');
 
INSERT 
INTO C2_COMPRA(PRD_CODIGO, CLI_CODIGO, FAC_CODIGO,COM_CANTIDAD)
VALUES (1,1,1,1);
 
INSERT 
INTO C2_COMPRA(PRD_CODIGO, CLI_CODIGO, FAC_CODIGO,COM_CANTIDAD)
VALUES (2,2,2,1);
/*
a)	Cree un programa en PL/SQL que permita calcular el valor del IVA (19% del total de la compra) 
de una factura cuyo c�digo se ingrese por teclado. Debe imprimir por pantalla el valor calculado (25 ptos).
*/
DECLARE
    CURSOR  C_IVA(COD_FACT NUMBER) IS
        SELECT F.FAC_CODIGO, SUM(C.COM_CANTIDAD*P.PRD_PRECIO) 
        FROM C2_FACTURA F
        INNER JOIN C2_COMPRA C ON C.FAC_CODIGO = F.FAC_CODIGO
        INNER JOIN C2_PRODUCTO P ON P.PRD_CODIGO = C.PRD_CODIGO
        WHERE F.FAC_CODIGO = COD_FACT
        GROUP BY F.FAC_CODIGO;
    VALOR_TOTAL NUMBER;
    COD NUMBER;
    IVA NUMBER;
BEGIN
    OPEN C_IVA(2); 
        FETCH C_IVA INTO COD, VALOR_TOTAL; 
        IVA := VALOR_TOTAL*19/100;
        DBMS_OUTPUT.PUT_LINE('EL IVA DE LA FACTURA N�' || COD || ' ES : ' || IVA);
        FETCH C_IVA INTO COD, VALOR_TOTAL;
    CLOSE C_IVA;
END;





/*
b)	Cree un programa en PL/SQL que permita conocer la cantidad de clientes frecuentes 
y espor�dicos que se tienen. Los clientes frecuentes son quienes hayan comprado $500.000.- 
o m�s en total, durante el mes de octubre. Los clientes espor�dicos son quienes han realizado 
compras en el mes de octubre inferior a $500.000.-. Se debe mostrar por pantalla la cantidad 
de clientes frecuentes y espor�dicos (25ptos).
*/

CREATE VIEW  V_COMPRAS_OCTUBRE AS(
    SELECT B.CLI_CODIGO, SUM(A.COM_CANTIDAD*C.PRD_PRECIO) AS CANT_COMPRA
    FROM C2_COMPRA  A
    INNER JOIN C2_CLIENTE  B ON B.CLI_CODIGO = A.CLI_CODIGO
    INNER JOIN C2_PRODUCTO C ON C.PRD_CODIGO = A.PRD_CODIGO
    INNER JOIN C2_FACTURA  D ON D.FAC_CODIGO = A.FAC_CODIGO
    WHERE D.FAC_FECHA BETWEEN  '01-10-2022' AND '31-10-2022'
    GROUP BY B.CLI_CODIGO
);

  

DECLARE
    CURSOR C_CLASIFICAR_CLIENTES_OCTUBRE IS
        SELECT COUNT(
            CASE 
                WHEN A.CANT_COMPRA>=500000 THEN
                NULL ELSE A.CANT_COMPRA 
            END
        ) AS CANT_ESPONTANEO,
        COUNT(
            CASE 
                WHEN A.CANT_COMPRA<500000 THEN
                NULL ELSE A.CANT_COMPRA 
            END
        ) AS CANT_FRECUENTE
        FROM V_COMPRAS_OCTUBRE A;
    CANT_FRECUENTE NUMBER;
    CANT_ESPONTANEO NUMBER;
BEGIN
    OPEN C_CLASIFICAR_CLIENTES_OCTUBRE;
    FETCH C_CLASIFICAR_CLIENTES_OCTUBRE INTO CANT_ESPONTANEO, CANT_FRECUENTE;
    DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE CLIENTES FRECUENTES EN OCTUBRE ES ' || CANT_FRECUENTE ); 
    DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE CLIENTES ESPONTANEOS EN OCTUBRE ES ' || CANT_ESPONTANEO ); 
    CLOSE C_CLASIFICAR_CLIENTES_OCTUBRE;
END;





--c)	Cree un trigger que no permita ingresar un producto con precio 0 o menor (25 ptos). 


CREATE OR REPLACE TRIGGER TR_PRECIO_PRODUCTO BEFORE INSERT ON C2_PRODUCTO
FOR EACH ROW
 
BEGIN
    IF :NEW.PRD_PRECIO <=0 THEN
        RAISE_APPLICATION_ERROR(-20300,'NO SE PUEDEN INGRESAR VALORES MENORES O IGUALES A CERO');
    END IF;
END;

INSERT
INTO C2_PRODUCTO(PRD_CODIGO, PRD_NOMBRE,PRD_PRECIO,PRO_RUT) 
VALUES (3, 'AUTO', 0, '17000309-8' );
/*d)	Cree un trigger que genere autom�ticamente el c�digo de la factura,
el que debe ser consecutivo. La fecha debe ser similar a la del sistema (25 ptos). 
-- OBTENER FECHA ACTUAL SISTEMA SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY') FROM DUAL */
--SE CREA UNA SECUENCIA
CREATE SEQUENCE AUMENTAR_PK
START WITH 1
INCREMENT BY 1;

--CREA UN TRIGGER PARA AUMENTAR DE FORMA AUTOM�TICA LA PK DE FACTURA
CREATE OR REPLACE TRIGGER TR_AUTOCRIMENT_PK_C2_FACTURA
BEFORE INSERT ON C2_FACTURA
FOR EACH ROW
BEGIN
    SELECT AUMENTAR_PK.NEXTVAL INTO :NEW.FAC_CODIGO FROM DUAL;
END; 

CREATE OR REPLACE TRIGGER TR_CREAR_FACTURA
BEFORE INSERT ON C2_COMPRA
FOR EACH ROW
DECLARE
    FECHA_ACTUAL VARCHAR2(20);
 
BEGIN
    --CALCULA LA FECHA ACTUAL Y LA GUARDA EN LA VARIABLE FECHA_ACTUAL
    SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY') INTO FECHA_ACTUAL FROM DUAL;
    --CREA UNA NUEVA FACTURA
    INSERT
    INTO C2_FACTURA(FAC_FECHA)
    VALUES (FECHA_ACTUAL);
    --SE GUARDA EL FAVOR DE LA FACTURA EN COMPRAS
    SELECT last_number INTO :NEW.FAC_CODIGO
    FROM user_sequences 
    WHERE sequence_name = 'AUMENTAR_PK';
END; 
 
 