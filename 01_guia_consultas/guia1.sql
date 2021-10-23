--Tabla productos
CREATE TABLE Producto(
    pro_cod INTEGER PRIMARY KEY,
    pro_nombre VARCHAR2(20),
    pro_tipo VARCHAR2(10),
    pro_unidadmedida VARCHAR2(10)
);
--Insersiones
INSERT INTO Producto VALUES (1,'MANTEQUILLA','LACTEO','G');
INSERT INTO Producto VALUES (2,'HARINA','CEREAL','G');
INSERT INTO Producto VALUES (3,'AZUCAR','OTRO','G');
INSERT INTO Producto VALUES (4,'MANZANA', 'FRUTA', 'UNIDAD');
INSERT INTO Producto VALUES (5, 'HUEVO', 'HUEVO','UNIDAD');
INSERT INTO Producto VALUES (6,'PLATANO', 'FRUTA', 'UNIDAD');
INSERT INTO Producto VALUES (7, 'ACELGA','VERDURA','G');
INSERT INTO Producto VALUES (8, 'SAL', 'OTRO', 'G');

--tabla recetas
CREATE TABLE Receta(
    rec_cod INTEGER PRIMARY KEY,
    rec_nombre VARCHAR2(20),
    rec_tipo VARCHAR2(10)
);

--insersiones
INSERT INTO Receta VALUES (1, 'QUEQUE', 'PASTELERIA');
INSERT INTO Receta VALUES (2, 'SPAGUETTI','PASTA');
INSERT INTO Receta VALUES (3,'TORTILLA VER','VEGETARIA');
INSERT INTO Receta VALUES (4,'PAN', 'MASA'); 

CREATE TABLE Requiere(
    pro_cod INTEGER,
    rec_cod INTEGER,
    req_cantidad INTEGER,
    PRIMARY KEY (pro_cod, rec_cod),
    FOREIGN KEY (pro_cod) REFERENCES Producto,
    FOREIGN KEY (rec_cod) REFERENCES Receta
);

INSERT INTO Requiere VALUES (1,1,500);
INSERT INTO Requiere VALUES (2,1,600);
INSERT INTO Requiere VALUES (5,1,3);
INSERT INTO Requiere VALUES (6,1,3);
INSERT INTO Requiere VALUES (2,2,500);
INSERT INTO Requiere VALUES (5,2,6);
INSERT INTO Requiere VALUES (2,3,600);
INSERT INTO Requiere VALUES (5,3,3);
INSERT INTO Requiere VALUES (6,3,600);
INSERT INTO Requiere VALUES (1,4,100);
INSERT INTO Requiere VALUES (2,4,1000);
INSERT INTO Requiere VALUES (8,4,20);
