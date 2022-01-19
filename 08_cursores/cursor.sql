create table Departamento (cod_depto INT primary key, nombre_depto varchar2(10));
create table Empleado (cod_emp int primary key, nombre varchar2(10), salario INT , cod_dep int, foreign key (cod_dep) references departamento);
INSERT INTO DEPARTAMENTO VALUES (1, 'SISTEMAS');
INSERT INTO EMPLEADO values (1, 'Juan',1000,1);
INSERT INTO EMPLEADO values (2, 'Mar�a',2000,1);
INSERT INTO EMPLEADO values (3, 'Juanp',90,1);
INSERT INTO EMPLEADO values (4, 'Mar�af',120,1);

SET SERVEROUTPUT ON

--Cree un cursor que permita mostrar por pantalla la cantidad de empleados que tiene cada uno de los departamentos.

DECLARE

CURSOR C_EMP IS 
    SELECT D.NOMBRE_DEPTO, COUNT(1) FROM DEPARTAMENTO D INNER JOIN EMPLEADO E ON D.COD_DEPTO=E.COD_DEP GROUP BY  D.NOMBRE_DEPTO;
NOMBRE DEPARTAMENTO.NOMBRE_DEPTO%TYPE;
CANTIDAD INTEGER;
BEGIN
    OPEN C_EMP;
    FETCH C_EMP INTO NOMBRE, CANTIDAD;
    WHILE C_EMP%FOUND
    LOOP
        DBMS_OUTPUT.PUT_LINE('EL DEPARTAMENTO '|| NOMBRE|| ' TIENE ' || CANTIDAD ||' EMPLEADOS');
        FETCH C_EMP INTO NOMBRE, CANTIDAD;
    END LOOP;
    CLOSE C_EMP;
END;
--OPCI�N 1 DE FOR
DECLARE

CURSOR C_EMP IS 
    SELECT D.NOMBRE_DEPTO, COUNT(1) AS CANTIDAD FROM DEPARTAMENTO D INNER JOIN EMPLEADO E ON D.COD_DEPTO=E.COD_DEP GROUP BY  D.NOMBRE_DEPTO;

BEGIN
   FOR CEMP IN C_EMP 
    LOOP
        DBMS_OUTPUT.PUT_LINE('EL DEPARTAMENTO '|| CEMP.NOMBRE_DEPTO|| ' TIENE ' || CEMP.CANTIDAD ||' EMPLEADOS');
    END LOOP;
END;
-- OPCI�N 2 FOR

  
BEGIN
   FOR CEMP IN (SELECT D.NOMBRE_DEPTO, COUNT(1) AS CANTIDAD FROM DEPARTAMENTO D INNER JOIN EMPLEADO E ON D.COD_DEPTO=E.COD_DEP GROUP BY  D.NOMBRE_DEPTO)
 
    LOOP
        DBMS_OUTPUT.PUT_LINE('EL DEPARTAMENTO '|| CEMP.NOMBRE_DEPTO|| ' TIENE ' || CEMP.CANTIDAD ||' EMPLEADOS');
    END LOOP;
END;

--Cree un programa que permita definir el cuartil de cada departamento  seg�n la cantidad de empleados, de acuerdo a la 
--siguiente clasificaci�n

DECLARE

CURSOR C_EMP IS 
    SELECT D.NOMBRE_DEPTO, COUNT(1) FROM DEPARTAMENTO D INNER JOIN EMPLEADO E ON D.COD_DEPTO=E.COD_DEP GROUP BY  D.NOMBRE_DEPTO;
NOMBRE DEPARTAMENTO.NOMBRE_DEPTO%TYPE;
CANTIDAD INTEGER;
Q1 INTEGER :=0;
Q2 INTEGER :=0;
Q3 INTEGER :=0;
Q4 INTEGER :=0;
BEGIN
    OPEN C_EMP;
    FETCH C_EMP INTO NOMBRE, CANTIDAD;
    WHILE C_EMP%FOUND
    LOOP
        IF CANTIDAD <=10 THEN
            Q1 := Q1+1;
        ELSIF CANTIDAD>=11 AND CANTIDAD <=30 THEN
            Q2 := Q2+1;
        ELSIF CANTIDAD >= 31 AND CANTIDAD <=40 THEN
            Q3:= Q3+1;
        ELSE
            Q4 := Q4+1;
       END IF;
        FETCH C_EMP INTO NOMBRE, CANTIDAD;
    END LOOP;
    CLOSE C_EMP;
     DBMS_OUTPUT.PUT_LINE('Q1 = '|| Q1);
     DBMS_OUTPUT.PUT_LINE('Q2 = '|| Q2);
     DBMS_OUTPUT.PUT_LINE('Q3 = '|| Q3);
     DBMS_OUTPUT.PUT_LINE('Q4 = '|| Q4);
END;


--Cree un programa que permita aumentar el salario en un 15% a las personas 
--que ganan menos de 300


DECLARE
    CURSOR C_SALARIO IS SELECT COD_EMP, SALARIO FROM EMPLEADO WHERE SALARIO <300 FOR UPDATE;
    CODIGO EMPLEADO.COD_EMP%TYPE;
    SAL EMPLEADO.SALARIO%TYPE;
BEGIN
    OPEN C_SALARIO;
    FETCH C_SALARIO INTO CODIGO, SAL;
    WHILE C_SALARIO%FOUND
    LOOP
        UPDATE EMPLEADO SET SALARIO=SAL*1.15 WHERE CURRENT OF C_SALARIO;
        FETCH C_SALARIO INTO CODIGO, SAL;
    END LOOP;
    CLOSE C_SALARIO;
    COMMIT;
END;
SELECT * FROM EMPLEADO;