/*
Universidad Nacional Autonoma de Mexico

Proyecto de Base de Datos

Base de datos de libreria 

Integrantes:
Herrejon Alarcon Jeerel Zalatiel
*/

CREATE TABLE autor
(
	id_autor CHAR(4) PRIMARY KEY,
	nomb_aut VARCHAR2(30) NOT NULL,
	nacionalidad VARCHAR2(30) NOT NULL 
);

CREATE TABLE lector(
	id_lector CHAR(4) PRIMARY KEY,
	nomb_lector VARCHAR2(30) NOT NULL,
	domicilio VARCHAR2(30) NOT NULL,
	telefono NUMBER(10,0) NOT NULL,
	fecha_alta DATE,
	fecha_vigencia DATE
	--adeudo no se como ponerlo tal vez con un check
);

CREATE TABLE prestamo(
	id_prestamo CHAR(4) PRIMARY KEY,
	id_lector CHAR(4) NOT NULL,
	fecha_real DATE,
	fecha_dev DATE,
	--id_tipoLect el mismo caso de adeudo para este
);

CREATE TABLE multa(
	id_multa CHAR(4) PRIMARY KEY,
	id_prestamo CHAR(4) NOT NULL,
	monto NUMBER(10,0) NOT NULL,
	--lect_multa NOT NULL,creo que aqui es id lect
	dias_retraso NOT NULL,
	fecha_multa DATE,
	--aqui iria su constraint
);

CREATE TABLE tipoLect(
	id_tipoLect CHAR(4) PRIMARY KEY,
	id_lector CHAR(4) NOT NULL,
	--tengo dudas en los siguientes atributos de esta tabla
);





