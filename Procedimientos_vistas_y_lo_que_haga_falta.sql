--Dany estuvo aquí Ü y seguramente los salvará para que aprueben la materia de BD.

--Punto 1
--Procedimiento para realizar un préstamo 

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

--procedimiento para la devolucion
CREATE OR REPLACE PROCEDURE devolucion(
vidLect lector.id_lector%TYPE,
vnumEjem prestamo.no_ejemplar%TYPE)
AS
BEGIN
DELETE prestamo WHERE id_lector = vidLect
AND no_ejemplar = vnumEjem;
END;
/


