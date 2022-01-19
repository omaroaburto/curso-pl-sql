/*1. Mostrar el nombre y apellido de cada due�o y la cantidad de casas que tiene en
Concepci�n*/
SELECT p.d_nombre, p.d_apellido, COUNT(1) AS CANT_CASAS
FROM g4_propietario P
INNER JOIN g4_casa C ON C.D_RUT =  P.D_RUT
WHERE C.C_COMUNA='concepci�n'
GROUP BY p.d_nombre, p.d_apellido;