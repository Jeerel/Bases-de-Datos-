/*
Universidad Nacional Autonoma de Mexico

Proyecto de Base de Datos

Base de datos de libreria 

Integrantes:
Herrejón Alarcón Jeerel Zalatiel
Hernández Guevara Daniel Alberto
Quiróz Mendiola Metztli Iréti
*/

--CREACION DE TABLAS

CREATE TABLE autor
(
	id_autor CHAR(4) PRIMARY KEY,
	nombre_autor VARCHAR2(30) NOT NULL,
	nacionalidad VARCHAR2(30) NOT NULL 
);
	
CREATE TABLE material(
	id_material CHAR(4) PRIMARY KEY
);

CREATE TABLE lector(
	id_lector CHAR(4) PRIMARY KEY,
	nombre_lector VARCHAR2(30) NOT NULL,
	domicilio VARCHAR2(30) NOT NULL,
	telefono NUMBER(10,0) NOT NULL,
	fecha_alta DATE,
	fecha_vigencia DATE
);

CREATE TABLE tipo_lector(
	id_tipo CHAR(4) PRIMARY KEY,
	id_lector CHAR(4) NOT NULL,
	descripcion VARCHAR2(30) NOT NULL,
	profesor VARCHAR2(4) NULL,
	alumno VARCHAR2(4) NULL,
	investigador VARCHAR2(4) NULL,
	CONSTRAINT fkId_lector_tipo FOREIGN KEY(id_lector) REFERENCES lector(id_lector) ON DELETE CASCADE
);

CREATE TABLE multa(
	id_multa CHAR(4) NOT NULL,
	id_lector CHAR(4),
	fecha_multa DATE NOT NULL,
	dias_atraso NUMBER(5,0) NOT NULL,
	monto NUMBER(10,0) NOT NULL,
	CONSTRAINT fkId_lector_multa FOREIGN KEY(id_lector) REFERENCES lector(id_lector) ON DELETE CASCADE
);

CREATE TABLE ejemplar(
	id_material CHAR(4),
	no_ejemplar CHAR(4) UNIQUE,
	status VARCHAR2(20) NOT NULL,
	CONSTRAINT fkId_material_ejemplar FOREIGN KEY(id_material) REFERENCES material(id_material) ON DELETE CASCADE,
	CONSTRAINT pkEjemplar PRIMARY KEY(id_material,no_ejemplar)
);

CREATE TABLE director(
	id_director CHAR(4) PRIMARY KEY,
	nombre_director VARCHAR2(30) NOT NULL,
	gdo_acad VARCHAR2(20) NOT NULL	
);

CREATE TABLE tipoMaterial(
	id_material CHAR(4),
	tipoMaterial VARCHAR2(20) NOT NULL,
	CONSTRAINT fkId_material_tipoMaterial FOREIGN KEY(id_material) REFERENCES material(id_material) ON DELETE CASCADE,
	CONSTRAINT pkTipoMaterial PRIMARY KEY(id_material)
);

CREATE TABLE libro(
	id_material CHAR(4),
	isbn VARCHAR2(20) UNIQUE,
	edicion VARCHAR2(10) NOT NULL,
	tema VARCHAR2(30) NOT NULL,
	no_adqui NUMBER(3,0) NOT NULL,
	id_autor CHAR(4),
	titulo VARCHAR2(30) NOT NULL,
	ubicacion VARCHAR2(30) NOT NULL,
	colocacion VARCHAR2(30) NOT NULL,
	CONSTRAINT fkId_autor_libro FOREIGN KEY(id_autor) REFERENCES autor(id_autor) ON DELETE CASCADE,
	CONSTRAINT fkId_material_libro FOREIGN KEY(id_material) REFERENCES material(id_material) ON DELETE CASCADE,
	CONSTRAINT pk_numId_libro PRIMARY KEY(id_material)
);

CREATE TABLE tesis(
	id_material CHAR(4),
	id_tesis CHAR(4) UNIQUE,
	carrera VARCHAR2(20) NOT NULL,
	anio_pub NUMBER(4,0) NOT NULL,
	ubicacion VARCHAR2(20) NOT NULL,
	colocacion VARCHAR2(30) NOT NULL,
	titulo VARCHAR2(30) NOT NULL,
	id_autor CHAR(4),
	id_director CHAR(4),
	CONSTRAINT fkId_autor_tesis FOREIGN KEY(id_autor) REFERENCES autor(id_autor) ON DELETE CASCADE,
	CONSTRAINT fkId_director_tesis FOREIGN KEY(id_director) REFERENCES director(id_director) ON DELETE CASCADE,
	CONSTRAINT fkId_material_tesis FOREIGN KEY(id_material) REFERENCES material(id_material) ON DELETE CASCADE,
	CONSTRAINT pkTesis PRIMARY KEY(id_material)
);

CREATE TABLE prestamo(
	id_prestamo CHAR(4) PRIMARY KEY,
	no_ejemplar CHAR(4),
	fecha_real DATE,
	fecha_dev DATE,
	refrendos NUMBER(2) NOT NULL,
	id_lector CHAR(4),
	CONSTRAINT fkId_lector_prestamo FOREIGN KEY(id_lector) REFERENCES lector(id_lector) ON DELETE CASCADE,
	CONSTRAINT fkno_ejemplar_prestamo FOREIGN KEY(no_ejemplar) REFERENCES ejemplar(no_ejemplar) ON DELETE CASCADE
);

--LLENADO DE TABLAS

--Tabla material

INSERT INTO material VALUES('M001');
INSERT INTO material VALUES('M002');
INSERT INTO material VALUES('M003');
INSERT INTO material VALUES('M004');
INSERT INTO material VALUES('M005');
INSERT INTO material VALUES('M006');
INSERT INTO material VALUES('M007');
INSERT INTO material VALUES('M008');
INSERT INTO material VALUES('M009');
INSERT INTO material VALUES('M010');

--Tabla ejemplar

INSERT INTO ejemplar VALUES('M001','E001','DISPONIBLE');
INSERT INTO ejemplar VALUES('M002','E002','DISPONIBLE');
INSERT INTO ejemplar VALUES('M003','E003','DISPONIBLE');
INSERT INTO ejemplar VALUES('M004','E004','DISPONIBLE');
INSERT INTO ejemplar VALUES('M005','E005','DISPONIBLE');
INSERT INTO ejemplar VALUES('M006','E006','DISPONIBLE');
INSERT INTO ejemplar VALUES('M007','E007','DISPONIBLE');
INSERT INTO ejemplar VALUES('M008','E008','DISPONIBLE');
INSERT INTO ejemplar VALUES('M009','E009','DISPONIBLE');
INSERT INTO ejemplar VALUES('M010','E010','DISPONIBLE');

--Tabla lector

INSERT INTO lector VALUES('L001','Jeerel Herrejo','Iztaccihualt 108',5579001766,'07/10/19','07/10/20');
INSERT INTO lector VALUES('L002','Eduardo Uribe','Ecatepec 96',5517288391,'09/05/19','09/05/20');
INSERT INTO lector VALUES('L003','Jumma Hernandez','Real del valle 28',5518290192,'07/07/19','07/07/20');
INSERT INTO lector VALUES('L004','karen Cruz','Aztecas 11','LGomez 43',57852712,'28/08/19','28/08/20');
INSERT INTO lector VALUES('L005','Mendiola Metztli','Viaducto 84',5500981723,'12/05/19','12/05/20');
INSERT INTO lector VALUES('L006','Libna Thais','Brasil 33',1342642878,'16/07/19','16/07/20');
INSERT INTO lector VALUES('L007','Mario Morales','California 4',5561788923,'5/11/19','5/11/20');
INSERT INTO lector VALUES('L008','Daniel Hernandez','Bordo 1',2287771200,'23/09/19','23/09/20');
INSERT INTO lector VALUES('L009','Rodrigo Franca','Argentina 55',66152678,'16/04/19','16/04/20');
INSERT INTO lector VALUES('L010','Elizabeth Chavez','Chimalhuacan 90',1340911234,'16/05/19','16/05/20');

--LLENEN LAS TABLAS DE ACUERDO A COMO ESTAN ACOMODADOS LOS VALORES POR FA! HEHE SALU2

--Tabla tipo material
INSERT INTO tipoMaterial VALUES('M001','libro');
INSERT INTO tipoMaterial VALUES('M002','libro');
INSERT INTO tipoMaterial VALUES('M003','libro');
INSERT INTO tipoMaterial VALUES('M004','libro');
INSERT INTO tipoMaterial VALUES('M005','libro');
INSERT INTO tipoMaterial VALUES('M006','tesis');
INSERT INTO tipoMaterial VALUES('M007','tesis');
INSERT INTO tipoMaterial VALUES('M008','tesis');
INSERT INTO tipoMaterial VALUES('M009','tesis');
INSERT INTO tipoMaterial VALUES('M010','tesis');

--Tabla libro
--Falta num_adqui
INSERT INTO libro VALUES('M001','978843501','2a','Narrativa','010','A001','Todos los fuegos el fuego','AB12','Av. Churubusco 13');
INSERT INTO libro VALUES('M002','978607527','3a','Autoayuda','011','A002','Arte de la seduccion','AC12','Av. Churubusco 13'); 
INSERT INTO libro VALUES('M003','978987580','5a','Narrativa','012','A003','Metamorfosis','AD13','Av. Churubusco 13'); 
INSERT INTO libro VALUES('M004','978607445','4a','Autores Mexicanos','013','A004','Dias que no se noimbran','AE14','Av. Churubusco 13'); 
INSERT INTO libro VALUES('M005','978607314','1a','Narrativa','014','A005','Travesuras de la niña mala','AF15','Av. Churubusco 13'); 

--valores tabla tesis
INSERT INTO tesis VALUES('M006','T001','Medicina','2019','TA12','Av. Churubusco 13','Factores desencadenantes de crisis hipertensiva','A006','D001');
INSERT INTO tesis VALUES('M007','T002','Ingenieria en sistemas','2014','TB12','Av. Churubusco 13','Los sistemas ERP','A007','D002');
INSERT INTO tesis VALUES('M008','T003','Psicologia','2012','TC13','Av. Churubusco 13','Taller de liderazgo para atletas de alto rendimiento','A008','D003');
INSERT INTO tesis VALUES('M009','T004','Derecho','2019','TD13','Av. Churubusco 13','Asociaciones publico privadas','A009','D004');
INSERT INTO tesis VALUES('M010','T005','Fisica','2012','TE14','Av. Churubusco 13','Dosimetría ambiental en aula-laboratorio de radiología odontológica','A010','D005');

--Tabla Autor
INSERT INTO autor VALUES('A001','Julio Cortazar','Argentina');
INSERT INTO autor VALUES('A002','Robert Greene','Estadounidense');
INSERT INTO autor VALUES('A003','Franz Kafka','Austrohungara');
INSERT INTO autor VALUES('A004','Jose Emilio Pacheco','Mexicana');
INSERT INTO autor VALUES('A005','Mario Vargas Llosa','Peruana');
INSERT INTO autor VALUES('A006','Abel García Jarquín','Mexicana');
INSERT INTO autor VALUES('A007','Abel Reyes Ortiz','Mexicana');
INSERT INTO autor VALUES('A008','Daniel Aguirre Espinosa','Mexicana');
INSERT INTO autor VALUES('A009','Luis Acosta Perez','Mexicana');
INSERT INTO autor VALUES('A010','Felipe Alvarez Siordia','Mexicana');

--valores tabla director
INSERT INTO director VALUES('D001','Alberto Ruiz ','Doctor'); 
INSERT INTO director VALUES('D002','Arturo Fuentes','Doctor');
INSERT INTO director VALUES('D003','Aida Mendoza','Doctor');
INSERT INTO director VALUES('D004','Arturo Oropeza','Doctor');
INSERT INTO director VALUES('D005','Patricia Aviles','Doctor');

--Creacion de secuencias 

CREATE SEQUENCE tipo_lector_secuencia START WITH 1 INCREMENT BY 1
MINVALUE 0
MAXVALUE 1000;

CREATE SEQUENCE multa_secuencia START WITH 1 INCREMENT BY 1
MINVALUE 0
MAXVALUE 1000;

CREATE SEQUENCE tesis_secuencia START WITH 1 INCREMENT BY 1
MINVALUE 0
MAXVALUE 1000;

CREATE SEQUENCE autor_secuencia START WITH 1 INCREMENT BY 1
MINVALUE 0
MAXVALUE 1000;

CREATE SEQUENCE ejemplar_secuencia START WITH 1 INCREMENT BY 1
MINVALUE 0
MAXVALUE 1000;

CREATE SEQUENCE director_secuencia START WITH 1 INCREMENT BY 1
MINVALUE 0
MAXVALUE 1000;

CREATE SEQUENCE prestamo_secuencia START WITH 1 INCREMENT BY 1
MINVALUE 0
MAXVALUE 1000;

--FUNCIONES

--Funcion de multa

REATE OR REPLACE FUNCTION funcion_multa(vId_lector IN CHAR)
RETURN NUMBER
IS
	vtotal_multa NUMBER(3);
	vretraso NUMBER(3);
	vfecha_devol DATE;
BEGIN
	SELECT fecha_dev INTO vfecha_devol
	FROM prestamo WHERE id_lector = vId_lector;
	vretraso:=(TO_DATE(SYSDATE,'dd/MM/yyyy') - TO_DATE(vfecha_devol,'dd/MM/yyy'));
	IF vretraso=0 THEN
		RETURN 0;
	ELSE
		vtotal_multa:= 10 * vretraso;		--10 pesos por dia
		INSERT INTO multa
		VALUES('M'||multa_secuencia.NEXTVAL,SYSDATE,vretraso,vtotal_multa,vId_lector);
		RETURN vtotal_multa;
	END IF;
END;
/

--Funcion de fecha de devolucion

CREATE OR REPLACE FUNCTION funcion_fecha_dev(
vProfesor IN CHAR,
vAlumno IN CHAR,
vInvestigador IN CHAR)
RETURN DATE
IS
	vfecha_devol DATE;
BEGIN
	IF vProfesor = 'SI' THEN
		vfecha_devol := SYSDATE + 15;
	ELSIF vAlumno = 'SI' THEN
		vfecha_devol := SYSDATE + 8;
	ELSIF vInvestigador = 'SI' THEN
		vfecha_devol := SYSDATE + 30;
	END IF;
	RETURN vfecha_devol;
END;
/

--PROCEDIMIENTOS

--Procedimiento para dar de alta a lector

CREATE OR REPLACE PROCEDURE alta_usuario(
vId_lector lector.id_lector%TYPE,
vNombreLector lector.nombre_lector%TYPE,
vTelefono lector.telefono%TYPE,
vDireccion lector.direccion%TYPE,
vProfesor tipo_lector.profesor%TYPE,
vAlumno tipo_lector.alumno%TYPE,
vInvestigador tipo_lector.investigador%TYPE,
vDescripcion tipo_lector.descripcion%TYPE
)
AS
	vFechaActual DATE;
	vFechaVigencia DATE;
BEGIN
	vFechaActual := SYSDATE;
	vFechaVigencia := add_months(vFechaActual,12);
	INSERT INTO lector VALUES(vId_lector, vNombreLector, vTelefono, vDireccion, vFechaActual, vFechaVigencia);
	INSERT INTO tipo_lector
VALUES('T'||tipo_lector_secuencia.NEXTVAL,vDescrip,vProfesor,vAlumno,vInvestigador,vId_lector);
	COMMIT;
	DBMS_OUTPUT.PUT_LINE('El lector: ' || vNombreLector || ' se ha agregado');
END alta_usuario;
/

--Procedimiento para dar de baja a lector

CREATE OR REPLACE PROCEDURE baja_lector(vLector lector.id_lector%TYPE)
AS
	vNombreLector lector.nombre_lector%TYPE;
BEGIN
	SELECT nombreLec INTO vNombreLector 
	FROM lector WHERE id_lector=vLector;
	DELETE lector WHERE id_lector = vLector;
	DBMS_OUTPUT.PUT_LINE('El lector: ' || vNombreLector||' se ha dado de baja');
END baja_lector;
/

--Procedimiento para agregar un LIBRO

CREATE OR REPLACE PROCEDURE agrega_libro(
vId_material material.id_material%TYPE,
visbn libro.isbn%TYPE,
vedicion libro.edicion%TYPE,
vtema libro.tema%TYPE,
vcolocacion libro.colocacion%TYPE,
vubicacion libro.ubicacion%TYPE,
vautor autor.nombre_autor%TYPE,
vnacionalidad autor.nacionalidad%TYPE)
AS
	vid_autor CHAR(4);
BEGIN
	vid_autor := 'A'||autor_secuencia.NEXTVAL;
	INSERT INTO libro VALUES(vId_material,visbn,vedicion,vtema,vcolocacion,vubicacion,vid_autor);
	INSERT INTO tipoMaterial VALUES(vId_material,'libro');
	INSERT INTO material VALUES(vId_material);
	INSERT INTO ejemplar VALUES(vId_material,'E'||ejemplar_secuencia.NEXTVAL,'DISPONIBLE');
	INSERT INTO autor VALUES(vid_autor,vautor,vnacionalidad);
	COMMIT;
END;
/

--Procedimiento para agregar una TESIS

CREATE OR REPLACE PROCEDURE agregaTesis(
vId_material material.id_material%TYPE,
vtema tesis.tema%TYPE,
vanio tesis.anio_pub%TYPE,
vubicacion tesis.ubicacion%TYPE,
vautor autor.nombre_autor%TYPE,
vnacionalidad autor.nacionalidad%TYPE,
vnombre_director director.nombre_director%TYPE,
vgrado director.gdo_acad%TYPE)
AS
	vid_autor CHAR(4);
	vid_director CHAR(4);
BEGIN
	vid_autor := 'A'||autor_secuencia.NEXTVAL;
	vid_director:= 'D'||director_secuencia.NEXTVAL;
	INSERT INTO tesis
VALUES(vId_material,'T'||tesis_secuencia.NEXTVAL,vtema,vanio,vubicacion,vid_autor,'D'||vid_director);
	INSERT INTO tipoMaterial VALUES(vId_material,'tesis');
	INSERT INTO material VALUES(vId_material);
	INSERT INTO ejemplar VALUES(vId_material,'E'||ejemplar_secuencia.NEXTVAL,'DISPONIBLE');
	INSERT INTO director VALUES(vid_director,vnombre_director,vgrado);
	COMMIT;
END;
/

--Procedimiento para prestamo

CREATE OR REPLACE PROCEDURE prestamo(
vId_lector lector.id_lector%TYPE,
vno_ejem ejemplar.no_ejemplar%TYPE
)
AS
vmulta NUMBER(3);
vprof tipoLector.profesor%TYPE;
vAlumno tipoLector.alumno%TYPE;
vInvestigador tipoLector.investigador%TYPE;
vfecha_devol DATE;
BEGIN
SELECT profesor, alumno, investigador INTO vProfesor,vAlumno,vInvestigador
FROM tipo_lector WHERE id_lector=vId_lector;
vmulta:=funcion_multa(vId_lector);
IF(vmulta>0) THEN
DBMS_OUTPUT.PUT_LINE('El lector tiene multas, imposible hacer este procedimiento');
ELSE
vfecha_devol := funcion_fecha_dev(vProfesor,vAlumno,vInvestigador);
INSERT INTO prestamo
VALUES('P'||prestamoSec.NEXTVAL,vno_ejem,SYSDATE,vfecha_devol,'0',vId_lector);
END IF;
END;
/

--procedimiento para el resello

CREATE OR REPLACE PROCEDURE refrendos(
vid_lector lector.id_lector%TYPE)
AS
vrefrendos NUMBER(2);
BEGIN
SELECT refrendos INTO vrefrendos
FROM prestamo WHERE id_lector=vId_lector;
vrefrendos := vrefrendos - 1;
IF vrefrendos < 0 THEN
DBMS_OUTPUT.PUT_LINE('Refrendos agotados');
ELSE
UPDATE prestamo SET refrendos = vrefrendos WHERE id_lector = vid_lector;
UPDATE prestamo SET fecha_dev = SYSDATE WHERE id_lector = vId_lector;
END IF;
END;
/

--procedimiento para la devolucion

CREATE OR REPLACE PROCEDURE devolucion(
vid_lector lector.id_lector%TYPE,
vno_ejem prestamo.no_ejemplar%TYPE)
AS
BEGIN
DELETE prestamo WHERE id_lector = vId_lector
AND no_ejemplar = vno_ejem;
END;
/

--Parte de dany! si esta mal culpelo

CREATE OR REPLACE PROCEDURE prestamo(
vidLect lector.id_lector%TYPE,
vnumEjem ejemplar.no_ejemplar%TYPE
)
AS
multa NUMBER(3);
Prof tipoLector.profesor%TYPE;
Alumn tipoLector.alumno%TYPE;
Inves tipoLector.investigador%TYPE;
Fecha_dev DATE;
BEGIN
SELECT profesor, alumno, investigador INTO Prof,Alumn,Inves
FROM tipo_lector WHERE id_lector=vidLect;
multa:=fmulta(vidLect);
IF (multa>0) THEN
DBMS_OUTPUT.PUT_LINE('El usuario presenta un adeudo');
ELSE
Fecha_dev := ffechaDe(Prof,Alumn,Inves);
INSERT INTO prestamo VALUES('P'||prestamoSec.NEXTVAL,vnumEjem,SYSDATE,Fecha_dev,'0',vidLect);
END IF;
END;
/


--Punto 2
--Disparadoror para actualizar estado de prestamo
CREATE OR REPLACE TRIGGER registra_prestamo
AFTER INSERT
ON prestamo
FOR EACH ROW
BEGIN
UPDATE ejemplar SET status='PRESTADO'
WHERE no_ejemplar = :NEW.no_ejemplar;
DBMS_OUTPUT.PUT_LINE('Prestamo realizado');
END;
/

--Disparadoror para actualizar estado de devolución
CREATE OR REPLACE TRIGGER registra_devolucion
AFTER DELETE
ON prestamo
FOR EACH ROW
BEGIN
UPDATE ejemplar SET status='DISPONIBLE'
WHERE no_ejemplar = :OLD.no_ejemplar;
DBMS_OUTPUT.PUT_LINE('Ejemplar devuelto');
END;
/


--vista para libros disponibles
CREATE OR REPLACE VIEW VwLibrosDisponibles
AS
SELECT tema, edicion, colocacion, ubicacion, nombre_autor
FROM libro JOIN autor USING(id_autor)
WHERE id_material IN (
SELECT id_material FROM ejemplar
WHERE estatus = 'DISPONIBLE'
);

--SET PAGESIZE 80 SET LINE 132
--Ver los valores agregados a la vista.
SELECT * FROM VwLibrosDisponibles;


--vista para tesis disponibles
CREATE OR REPLACE VIEW VwTesisDisponibles
AS
SELECT titulo, carrera, colocacion, ubicacion,anio_pub, nombre_autor
FROM tesis JOIN autor USING(id_autor)
WHERE id_material IN (
SELECT id_material FROM ejemplar
WHERE estatus = 'DISPONIBLE'
);

--SET PAGESIZE 80 SET LINE 132
--Ver los valores agregados a la vista.
SELECT * FROM VwTesisDisponibles;

--Vista de tesis y sus aurtores
CREATE OR REPLACE VIEW vWAutoresTesis
AS
SELECT nombre_autor, titulo, anio_pub
FROM autor JOIN tesis USING (id_autor);


--Vista de librosy sus autores
CREATE OR REPLACE VIEW vWAutoresLibros
AS
SELECT nombre_autor, tema, ISBN
FROM autor JOIN libro USING (id_autor);

--Disparador de resello
CREATE OR REPLACE TRIGGER resello
AFTER INSERT
ON prestamo
FOR EACH ROW
BEGIN
UPDATE prestamo SET fecha_real:= SYSDATE;
EXEC funcion_fecha_dev;
UPDATE prestamo SET refrendos=refrendos+1;
END;
/