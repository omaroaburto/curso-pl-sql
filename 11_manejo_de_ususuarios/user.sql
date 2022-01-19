--Cree un usuario1 que pueda administrar la base de datos
CREATE USER usuario1 
IDENTIFIED BY usuario1;

GRANT CREATE SESSION TO usuario1;

--Cree un usuario2 que pueda crear procedimientos almacenados

CREATE USER usuario2 
IDENTIFIED BY usuario1;
GRANT CREATE SESSION, CREATE PROCEDURE TO usuario2;


--Cree dos roles uno de diseñador (manipular tablas ) y otro de consultor (sólo consultar).
--Al usuario2 quite el privilegio de crea procedimientos.
--Asigne al usuario2 el rol del consultor
 