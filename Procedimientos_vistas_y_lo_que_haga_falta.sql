--Dany estuvo aquí Ü y seguramente los salvará para que aprueben la materia de BD.

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
DBMS_OUTPUT.PUT_LINE('El usuario presentaun adeudo');
ELSE
Fecha_dev := ffechaDe(Prof,Alumn,Inves);
INSERT INTO prestamo VALUES('P'||prestamoSec.NEXTVAL,vnumEjem,SYSDATE,Fecha_dev,'0',vidLect);
END IF;
END;
/

