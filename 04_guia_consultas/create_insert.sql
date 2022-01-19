CREATE TABLE g4_arrendatario(
    a_rut VARCHAR(12), 
    a_nombre VARCHAR(20) NOT NULL, 
    a_apellido VARCHAR(20) NOT NULL,
    PRIMARY KEY(a_rut)
);



CREATE TABLE g4_propietario(
    d_rut VARCHAR(12), 
    d_nombre VARCHAR(20) NOT NULL, 
    d_apellido VARCHAR(20) NOT NULL,
    PRIMARY KEY(d_rut)
);

CREATE TABLE g4_casa(
    c_id integer, 
    d_rut VARCHAR(12), 
    c_direccion VARCHAR(20) NOT NULL, 
    c_comuna VARCHAR(20) NOT NULL,
    PRIMARY KEY (c_id) , 
    FOREIGN KEY (d_rut) REFERENCES g4_propietario
);

create table g4_arrienda(
    c_id integer, 
    a_rut VARCHAR(12) , 
    ar_deuda integer NOT NULL, 
    arr_fecha_i date,
    arr_fecha_t date, 
    PRIMARY KEY (c_id,a_rut, arr_fecha_i), 
    FOREIGN KEY (c_id) REFERENCES g4_casa, 
    FOREIGN KEY (a_rut) REFERENCES g4_arrendatario
); /*Deuda >=0 (si es 0, no hay deuda)*/


 
 
 
 
 
 

