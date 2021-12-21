-- Define un procedimiento con un cursor para sumar 10 a la vida de cada guerrero que haya derrotado al menos 50 goblins.

 DELIMITER $$
   CREATE PROCEDURE vida_g ()
   BEGIN
   DECLARE done INT DEFAULT FALSE;
   DECLARE id VARCHAR(30);
   DECLARE cur CURSOR FOR SELECT guerrero.id_g
								FROM guerrero_batalla_goblin, guerrero
                                WHERE guerrero_batalla_goblin.id_g = guerrero.id_g
                                GROUP BY guerrero.id_g
								HAVING COUNT(guerrero_batalla_goblin.id_g) > 2;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
     OPEN cur;
     read_loop : LOOP
       FETCH cur INTO id;
		UPDATE guerrero
		SET guerrero.vida = guerrero.vida + 100
        WHERE guerrero.id_g = id;
       IF done THEN
         LEAVE read_loop;
       END IF;
     END LOOP;
     CLOSE cur;
    END $$
DELIMITER ;

 CALL vida_g();
 
-- Añade un atributo ‘ultima conexion’ a la tabla de personajes. Luego, crea un procedimiento que elimine los jugadores que no se hayan conectado en los u ́ltimos 60 dıas. Puedes usar la funci ́on DATEDIFF1 para este fin.
 
ALTER TABLE personaje
ADD ultima_conexion DATE;

UPDATE personaje
SET ultima_conexion = '2020-08-05'
WHERE nombre_p = 'Xadel';
 
DELIMITER $$
CREATE PROCEDURE eliminar_jugadores()
BEGIN 
	DECLARE DONE INT DEFAULT FALSE;
    DECLARE n VARCHAR(30);
	DECLARE cur CURSOR FOR SELECT personaje.nombre_p
						   FROM personaje
                           WHERE datediff(CURDATE(),personaje.ultima_conexion)>=60;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=true;
    OPEN cur;
    read_loop: LOOP
       FETCH cur INTO n;
       DELETE personaje
       FROM personaje
       WHERE nombre_p=n;
       IF DONE THEN
	LEAVE read_loop;
	END IF;
   END LOOP;
   CLOSE cur;
END$$
DELIMITER ;

CALL eliminar_jugadores();