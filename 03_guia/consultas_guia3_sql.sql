--creaciÃ³n de tablas
CREATE TABLE G3_ALUMNO ( 
	A_RUT VARCHAR(12) PRIMARY KEY,
	A_NOMBRE VARCHAR(20),
	A_SEXO VARCHAR(10),
	CHECK (A_SEXO IN ('M', 'F'))
);

CREATE TABLE G3_CARRERA(
	C_ID INT PRIMARY KEY,
	C_NOMBRE VARCHAR(20),
	C_COSTO INT
);

CREATE TABLE G3_SEMESTRE (
	S_ID INT PRIMARY KEY,
	S_COR INT,
	S_ANO INT,
CHECK (S_COR IN (1,2))
);

CREATE TABLE G3_MATRICULA (
	A_RUT VARCHAR(12),	
	C_ID INT,
	S_ID INT,
	M_VALOR INT,
	M_FORMAPAGO VARCHAR(10) ,
    PRIMARY KEY (A_RUT, C_ID, S_ID),
	FOREIGN KEY (A_RUT) REFERENCES G3_ALUMNO(A_RUT),
	FOREIGN KEY (C_ID) REFERENCES G3_CARRERA(C_ID),
	FOREIGN KEY (S_ID) REFERENCES G3_SEMESTRE(S_ID),
	CHECK (M_FORMAPAGO IN ('EFECTIVO','CHEQUE', 'OTRO'))
);
--inserciones
--esquema
--Alumno (a_rut, a_nombre, a_sexo), cuya clave primaria es a_rut
INSERT INTO G3_ALUMNO(A_RUT, A_NOMBRE, A_SEXO) VALUES('17.000.309-8','OMARO ABURTO', 'M');
INSERT INTO G3_ALUMNO(A_RUT, A_NOMBRE, A_SEXO) VALUES('19.030.109-K','LAURA ABARCA', 'F');
INSERT INTO G3_ALUMNO(A_RUT, A_NOMBRE, A_SEXO) VALUES('7.201.409-1','ADRIANA CISTERNA', 'F');
INSERT INTO G3_ALUMNO(A_RUT, A_NOMBRE, A_SEXO) VALUES('20.600.009-2','ALBERTO CRISTI', 'M');
INSERT INTO G3_ALUMNO(A_RUT, A_NOMBRE, A_SEXO) VALUES('15.505.307-7','ESTEBAN SANHUEZA', 'M');
INSERT INTO G3_ALUMNO(A_RUT, A_NOMBRE, A_SEXO) VALUES('16.010.987-5','MARCELO GALLARDO', 'M');


--Carrera ( c_id, c_nombre, c_costo), cuya clave primaria es c_id

INSERT INTO G3_CARRERA(C_ID, C_NOMBRE, C_COSTO)VALUES(1,'ENFERMERÍA',2000000);
INSERT INTO G3_CARRERA(C_ID, C_NOMBRE, C_COSTO)VALUES(2,'INFORMÁTICA',3000000);
INSERT INTO G3_CARRERA(C_ID, C_NOMBRE, C_COSTO)VALUES(3,'MEDICINA',3000000);
INSERT INTO G3_CARRERA(C_ID, C_NOMBRE, C_COSTO)VALUES(4,'PEDAGOGÍA',1500000);


--Semestre (s_id, s_cor, s_ano), cuya clave primaria es s_id 


--Matricula ( a_rut, c_id, s_id, m_valor, m_formapago), cuyas claves primarias son a_rut, c_id, s_id y foráneas respectivamente
SELECT * FROM G3_ALUMNO;
SELECT * FROM G3_CARRERA;
SELECT * FROM G3_SEMESTRE;
SELECT * FROM G3_MATRICULA;
--Consultas
--1.	Muestre el nombre de los estudiantes que son mujeres.
SELECT A.A_NOMBRE   
FROM G3_ALUMNO A
WHERE A.A_SEXO IN('F'); 
--2.	Muestre el nombre de los estudiantes que están matriculados en el semestre 2020-1.
SELECT A.A_NOMBRE   
FROM G3_MATRICULA M
INNER JOIN G3_ALUMNO A ON A.A_RUT = M.A_RUT
INNER JOIN G3_SEMESTRE S ON S.S_ID = M.S_ID
WHERE S.S_ANO = 2020 AND S.S_COR =1; 
--3.	Muestre el nombre de los alumnos que han realizado el pago de la matrícula en efectivo o en cheque en el semestre 2020-1.
--4.	Liste el nombre de las carreras donde el valor de las matriculas es mayor a $120.000.- durante el periodo 2019-2
--5.	Muestre el nombre de las carreras que al menos tienen dos alumnos matriculados durante el año 2020-1.
--6.	Muestre el número total de alumnos que se matricularon el semestre 2020-1
--7.	Muestre los alumnos que no se encuentran matriculados en el periodo 2020-1, pero sí en el 2018-1
--8.	Muestre los alumnos que no se han matriculado en IECI
--9.	Liste el nombre de las carreras y la cantidad de alumnos matriculados.
--10.	Muestre la cantidad de mujeres y la cantidad de varones.
--11.	Muestre la cantidad de dinero recibido en efectivo durante el semestre 2020-1
--12.	Muestre la cantidad de dinero recibido para cada forma de pago
--13.	Muestre los últimos dos semestres con la cantidad de alumnos matriculados y el monto promedio
--recibido por concepto de matrícula.
--14.	Liste el nombre de la carrera y el valor máximo que ha recibido por concepto de matrícula.
--15.	Liste el nombre de la carrera y el mayor valor (considere la suma del valor pagado por 
--matrícula, durante los últimos 4 semestres. Se recomienda usar vista.
