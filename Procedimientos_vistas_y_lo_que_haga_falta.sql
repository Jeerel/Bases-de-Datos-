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
