CREATE TABLE Navegante(idN INTEGER, nombreN VARCHAR2(10), categoría VARCHAR2(10), edad INTEGER, ciudad VARCHAR2(10));
CREATE TABLE Reservas (idN INTEGER, idB INTEGER, fecha DATE);
CREATE TABLE Botes (idB INTEGER, nombreB VARCHAR2(10), color VARCHAR2(10), cantidad_reservas integer);

-- Genere un trigger que no permita reservar a un cliente el mismo bote durante el mismo mes.
CREATE OR REPLACE TRIGGER TR_RESERVAS BEFORE INSERT ON RESERVAS
FOR EACH ROW
DECLARE
CURSOR C_FECHA_REV IS 
    SELECT FECHA FROM RESERVAS WHERE IDN= :NEW.IDN AND IDB= :NEW.IDB;
FECHA_REV DATE;
BEGIN

OPEN C_FECHA_REV;
FETCH C_FECHA_REV INTO FECHA_REV;
WHILE C_FECHA_REV%FOUND
LOOP
IF TO_CHAR(FECHA_REV,'MM') = TO_CHAR(:NEW.FECHA, 'MM') THEN
    RAISE_APPLICATION_ERROR(-20120, 'NO SE PUEDE RESERVAR EL MISMO BOTE EN UN MES');
END IF;
FETCH C_FECHA_REV INTO FECHA_REV;
END LOOP;
CLOSE C_FECHA_REV;
END;

SELECT * FROM RESERVAS

INSERT INTO RESERVAS VALUES (2,11,'08/04/2022')
UPDATE BOTES SET CANTIDAD_RESERVAS=1

-- Genere un trigger que controle que un navegante no puede tener más de 5 reservas en el mismo año
ALTER TRIGGER TR_RESERVAS ENABLE;

CREATE OR REPLACE TRIGGER TR_CANTIDAD_REV BEFORE INSERT ON RESERVAS FOR EACH ROW
DECLARE
NUM_RESERVA INTEGER :=0;
BEGIN
SELECT COUNT(1) INTO NUM_RESERVA FROM RESERVAS WHERE IDN= :NEW.IDN AND TO_CHAR(FECHA,'YY') = TO_CHAR(:NEW.FECHA, 'YY');
IF NUM_RESERVA >5 THEN
    RAISE_APPLICATION_ERROR(-20120, 'NO SE PUEDE TENER M�S DE 5 RESERVAS');
END IF;
END;

SELECT COUNT(1) FROM RESERVAS 
-- Genere un trigger que asigne automáticamente el Id de los navegantes, considerando el valor máximo registrado.
CREATE OR REPLACE TRIGGER TR_ID BEFORE INSERT ON NAVEGANTE FOR EACH ROW
DECLARE
ID INTEGER;
BEGIN
    SELECT MAX(IDN) INTO ID FROM NAVEGANTE;
    IF ID IS NULL THEN
        :NEW.IDN := 1;
    ELSE
        :NEW.IDN := ID+1;
    END IF;
END;

INSERT INTO NAVEGANTE VALUES (34,'FFF','SENIOR',65,'CONCE');


-- Cada vez que se realice una reserva, actualizar la cantidad de reservas en bote.

CREATE OR REPLACE TRIGGER TR_CANT_REV AFTER INSERT ON RESERVAS FOR EACH ROW
DECLARE

BEGIN
    UPDATE BOTES SET CANTIDAD_RESERVAS = CANTIDAD_RESERVAS+1 WHERE IDB=:NEW.IDB;
END;

SELECT MAX(IDN)FROM NAVEGANTE;
DELETE FROM NAVEGANTE WHERE IDN=1
