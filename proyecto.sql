/*
Universidad Nacional Autonoma de Mexico

Proyecto de Base de Datos

Base de datos de libreria 

Integrantes:
Herrejon Alarcon Jeerel Zalatiel
Hernández Guevara Daniel Alberto
Quiróz Mendiola Metztli Iréti
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
	--id_lector CHAR(4),
	dias_retraso NOT NULL,
	fecha_multa DATE,
	--aqui iria su constraint
	--CONSTRAINT fk_id_lector_multa FOREIGN KEY(id_lector) REFERENCES lector(id_lector) ON DELETE CASCADE
);

CREATE TABLE tipoLect(
	id_tipoLect CHAR(4) PRIMARY KEY,
	id_lector CHAR(4) NOT NULL,
	--tengo dudas en los siguientes atributos de esta tabla
	
	--profesor VARCHAR2(4) NULL,
	--alumno VARCHAR2(4) NULL,
	--investigador VARCHAR2(4) NULL,
	--CONSTRAINT fk_id_lector_tipoLect FOREIGN KEY(id_lector) REFERENCES lector(id_lector) ON DELETE CASCADE

CREATE TABLE ejemplar(
	no_ejemplar NUMBER(4), 
	id_material NUUMBER(4) NOT NULL,
	status VARCHAR2(20) NOT NULL,
	CONSTRAINT PkEjemplar PRIMARY KEY no_ejemplar,
	--CONSTRAINT PkEjemplar PRIMARY KEY (no_ejemplar,id_material),
	CONSTRAINT FkEjemplar FOREIGN KEY id_material REFERENCES material,
	--CONSTRAINT FkEjemplar FOREIGN KEY (id_material) REFERENCES material (id_material) ON DELETE CASCADE,
	CONSTRAINT Estado CHECK status IN ('Disponible','Prestamo','No sale','Mantenimiento'));
	--Tengo dudas de la sintaxis de los constraints ↑
	

CREATE TABLE material(
	id_material NUMBER(4),
	titulo VARCHAR2(30) NOT NULL,
	ubicacion VARCHAR2(30) NOT NULL,
	colocacion VARCHAR2(30) NOT NULL,
	CONSTRAINT PkMaterial PRIMARY KEY id_material
	
	
);

CREATE TABLE tesis(
	id_tesis NUMBER(4),
	id_material NUMBER(4),
	carrera VARCHAR2(30) NOT NULL,
	anio_pub VARCHAR2(30) NOT NULL,
	--ubicacion VARCHAR2(20) NOT NULL,
	--id_autor CHAR(4),
	--id_director CHAR(4),
	CONSTRAINT FkTesis FOREIGN KEY id_material REFERENCES material,
	CONSTRAINT PkTesis PRIMARY KEY id_tesis
	
);

CREATE TABLE libro(
	no_adqui NUMBER(4),
	id_Material NUMBER(4),
	ISBN NUMBER(13) NOT NULL,
	edicion NUMBER(2) NOT NULL,
	tema VARCHAR2(30) NOT NULL,
	CONSTRAINT FkLibro FOREIGN KEY id_material REFERENCES material,
	CONSTRAINT PkLibro PRIMARY KEY no_adqui

	
);

CREATE TABLE director (
	id_director NUMBER(4),
	id_tesis NUMBER(4),
	id_material NUMBER(4),
	nomb_direct VARCHAR2(50) NOT NULL,
	gdo_acad VARCHAR2(30) NOT NULL,
	CONSTRAINT FkTesis FOREIGN KEY id_tesis REFERENCES tesis,
	CONSTRAINT FkMaterial FOREIGN KEY id_material REFERENCES material,
	CONSTRAINT PkDirector PRIMARY KEY (id_director, id_tesis, id_material)
	
	
);





