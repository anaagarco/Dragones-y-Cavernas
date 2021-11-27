-- a) Obtener los dragones que tengan nombre “Griffin” u “Ocho Cabezas”

SELECT *
FROM dragon
WHERE nombre_d = "Griffin" OR nombre_d = "Ocho Cabezas";

-- b) Obtener los guerreros que haya comprado dagas en la “Tienda de Rolla” y forjado espadas en la “Forja del enano risueño"

SELECT guerrero.id_g,tienda.nombre_t,forja.nombre_f
FROM guerrero INNER JOIN espada ON guerrero.id_g = espada.id_g
			  INNER JOIN guerrero_crea_en_forja ON guerrero.id_g=guerrero_crea_en_forja.id_g
			  INNER JOIN personaje ON personaje.id_g=guerrero.id_g
			  INNER JOIN personaje_compra_daga ON personaje.nombre_p = personaje_compra_daga.nombre_p
			  INNER JOIN forja ON forja.nombre_f=espada.nombre_f
			  INNER JOIN forja_se_encuentra_ciudad ON forja_se_encuentra_ciudad.nombre_f=forja.nombre_f
			  INNER JOIN ciudad ON ciudad.nombre_c=forja_se_encuentra_ciudad.nombre_c
			  INNER JOIN tienda ON tienda.nombre_c=ciudad.nombre_c
WHERE tienda.nombre_t="Tienda de Rolla" AND forja.nombre_f="Forja del enano risueño";

-- c)Obtener el oro total ganado por los personajes ordenado de mayor a menor.
 
SELECT SUM(espectro.oro_soltado) as oro_total, personaje.nombre_p
FROM personaje INNER JOIN mago ON personaje.id_m = mago.id_m
              INNER JOIN mago_derrota_espectro ON mago_derrota_espectro.id_m = mago.id_m
              INNER JOIN espectro ON espectro.cod_me = mago_derrota_espectro.cod_me
              GROUP BY personaje.nombre_p
UNION
SELECT SUM(goblin.oro_soltado) as oro_total, personaje.nombre_p
FROM personaje INNER JOIN guerrero ON personaje.id_g = guerrero.id_g
              INNER JOIN guerrero_batalla_goblin ON guerrero_batalla_goblin.id_g = guerrero.id_g
              INNER JOIN goblin ON goblin.cod_mg = guerrero_batalla_goblin.cod_mg
              GROUP BY personaje.nombre_p
UNION
SELECT SUM(trol.oro_soltado) as oro_total, personaje.nombre_p
FROM personaje INNER JOIN tanque ON personaje.id_t = tanque.id_t
              INNER JOIN tanque_enfrenta_trol ON tanque_enfrenta_trol.id_t = tanque.id_t
              INNER JOIN trol ON trol.cod_mt = tanque_enfrenta_trol.cod_mt
              GROUP BY personaje.nombre_p
 
ORDER BY oro_total DESC;

-- d) Obtener el número total de dragones que ha matado cada jugador con cualquier personaje

SELECT COUNT(nombre_d) as dragones_derrotados, jugador.nickname
FROM 	mago_pertenece_escuadron INNER JOIN personaje ON personaje.id_m = mago_pertenece_escuadron.id_m
                    INNER JOIN escuadron ON mago_pertenece_escuadron.id_e=escuadron.id_e
					INNER JOIN escuadron_vence_dragon ON escuadron_vence_dragon.id_e = escuadron.id_e
                    INNER JOIN jugador ON personaje.mail = jugador.mail
					GROUP BY jugador.nickname
UNION ALL
SELECT COUNT(nombre_d) as dragones_derrotados, jugador.nickname
FROM 	guerrero_pertenece_escuadron INNER JOIN personaje ON personaje.id_g = guerrero_pertenece_escuadron.id_g
                    INNER JOIN escuadron ON guerrero_pertenece_escuadron.id_e=escuadron.id_e
					INNER JOIN escuadron_vence_dragon ON escuadron_vence_dragon.id_e = escuadron.id_e
                    INNER JOIN jugador ON personaje.mail = jugador.mail
					GROUP BY jugador.nickname
UNION ALL         
SELECT COUNT(nombre_d) as dragones_derrotados, jugador.nickname
FROM 	tanque_pertenece_escuadron INNER JOIN personaje ON personaje.id_t = tanque_pertenece_escuadron.id_t
                    INNER JOIN escuadron ON tanque_pertenece_escuadron.id_e=escuadron.id_e
					INNER JOIN escuadron_vence_dragon ON escuadron_vence_dragon.id_e = escuadron.id_e
                    INNER JOIN jugador ON personaje.mail = jugador.mail
					GROUP BY jugador.nickname;

-- e) Obtener el nombre de los jugadores cuyos personajes no hayan comprado en tiendas de ciudades con mas de dos forjas.

SELECT jugador.nickname,COUNT(DISTINCT forja.nombre_f) AS ha_forjado
FROM jugador INNER JOIN personaje ON jugador.mail=personaje.mail
			 INNER JOIN daga ON daga.nombre_p=personaje.nombre_p
			 INNER JOIN tienda_compra_daga ON tienda_compra_daga.id_daga=daga.id_daga
			 INNER JOIN tienda ON tienda.nombre_t=tienda_compra_daga.nombre_t
			 INNER JOIN ciudad ON tienda.nombre_c=ciudad.nombre_c
			 INNER JOIN forja_se_encuentra_ciudad ON ciudad.nombre_c=forja_se_encuentra_ciudad.nombre_c
			 INNER JOIN forja ON forja.nombre_f=forja_se_encuentra_ciudad.nombre_f
group by jugador.nickname
HAVING COUNT(forja.Nombre_F)<=2;

-- f) Obtener los tanques que únicamente portan hachas de doble punta.

SELECT tanque.id_t
FROM tanque INNER JOIN hacha ON hacha.id_t=tanque.id_t
WHERE hacha.nombre_h IN ('Hacha de doble punta')
AND hacha.nombre_h NOT IN (SELECT nombre_h
						   FROM hacha
                           WHERE nombre_h <> 'Hacha de doble punta');
 
-- g) Obtener nombres, vida y fuerza de guerreros que hayan recibido una pocion de todos los druidas existentes.
 
SELECT guerrero.id_g, guerrero.vida, personaje.fuerza
FROM guerrero INNER JOIN personaje ON personaje.id_g = guerrero.id_g
WHERE NOT EXISTS (SELECT *
                 FROM npc
                 WHERE tipo = 'druida' AND NOT EXISTS( SELECT *
                                   FROM personaje_entrega_npc_pocion
                                   WHERE personaje_entrega_npc_pocion.nombre_p = personaje.nombre_p
                                       AND personaje_entrega_npc_pocion.id_npc = npc.id_npc));
 
-- h) Obtener el nivel de los magos que han derrotado a todos los espectros y han comprado todas las dagas disponibles.

SELECT nivel
FROM mago INNER JOIN personaje ON personaje.id_m = mago.id_m
WHERE NOT EXISTS(SELECT cod_me
                      FROM espectro
                      WHERE NOT EXISTS(SELECT *
                                       FROM mago_derrota_espectro
                                       WHERE mago_derrota_espectro.id_m = mago.id_m
                                       AND mago_derrota_espectro.cod_me = espectro.cod_me))
       AND NOT EXISTS(SELECT *
                       FROM daga
                       WHERE NOT EXISTS(SELECT *
                                       FROM personaje_compra_daga
                                       WHERE personaje_compra_daga.nombre_p = personaje.nombre_p
                                       AND personaje_compra_daga.id_daga = daga.id_daga));
                                       
-- i) Obtener el tanque que ha participado en el maximo numero de escuadrones.
SELECT tanque.id_t
FROM tanque INNER JOIN tanque_pertenece_escuadron ON tanque.id_t=tanque_pertenece_escuadron.id_t
INNER JOIN escuadron ON tanque_pertenece_escuadron.id_e=escuadron.id_e
GROUP BY tanque.id_t
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
                    FROM escuadron
                    GROUP BY escuadron.id_e);
                    
-- j) Obtener el hacha con menor peso y el dueño de la forja donde se hizo

SELECT hacha.nombre_h,forja.id_npc,hacha.peso
FROM hacha INNER JOIN forja ON hacha.nombre_f=forja.nombre_f
WHERE hacha.peso <= ALL (SELECT peso
						 FROM hacha);

-- ---------------------------------------- Procedimientos y Funciones -----------------------------------------------

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

-- ------------------------------- Triggers -----------------------------------

-- a) Define un trigger para que cuando un jugador haya matado al menos 3 dragones, su vida aumente en 5.

DROP TRIGGER IF EXISTS Update_Life;

DELIMITER $$
CREATE TRIGGER Update_Life AFTER INSERT ON escuadron_vence_dragon
FOR EACH ROW
BEGIN
	IF (SELECT COUNT(id_m)
			FROM mago_pertenece_escuadron
			INNER JOIN escuadron ON escuadron.id_e = mago_pertenece_escuadron.id_e
			INNER JOIN escuadron_vence_dragon ON escuadron_vence_dragon.id_e = escuadron.id_e
			WHERE mago_pertenece_escuadron.id_e = NEW.id_e AND escuadron_vence_dragon.fecha BETWEEN mago_pertenece_escuadron.fecha_inicio AND mago_pertenece_escuadron.fecha_fin
			HAVING COUNT(mago_pertenece_escuadron.id_m) >= 3) THEN
	UPDATE mago INNER JOIN mago_pertenece_escuadron on mago.id_m = mago_pertenece_escuadron.id_m
    SET mago.vida = mago.vida + 5
    WHERE mago_pertenece_escuadron.id_e = NEW.id_e;
	END IF;
    IF (SELECT COUNT(id_g)
			FROM guerrero_pertenece_escuadron
			INNER JOIN escuadron ON escuadron.id_e = guerrero_pertenece_escuadron.id_e
			INNER JOIN escuadron_vence_dragon ON escuadron_vence_dragon.id_e = escuadron.id_e
			WHERE guerrero_pertenece_escuadron.id_e = NEW.id_e AND escuadron_vence_dragon.fecha BETWEEN guerrero_pertenece_escuadron.fecha_inicio AND guerrero_pertenece_escuadron.fecha_fin
			HAVING COUNT(guerrero_pertenece_escuadron.id_g) >= 3) THEN
	UPDATE guerrero INNER JOIN guerrero_pertenece_escuadron on guerrero.id_g = guerrero_pertenece_escuadron.id_g
    SET guerrero.vida = guerrero.vida + 5
    WHERE guerrero_pertenece_escuadron.id_e = NEW.id_e;
	END IF;
    IF (SELECT COUNT(id_t)
			FROM tanque_pertenece_escuadron
			INNER JOIN escuadron ON escuadron.id_e = tanque_pertenece_escuadron.id_e
			INNER JOIN escuadron_vence_dragon ON escuadron_vence_dragon.id_e = escuadron.id_e
			WHERE tanque_pertenece_escuadron.id_e = NEW.id_e AND escuadron_vence_dragon.fecha BETWEEN tanque_pertenece_escuadron.fecha_inicio AND tanque_pertenece_escuadron.fecha_fin
			HAVING COUNT(tanque_pertenece_escuadron.id_t) >= 3) THEN
	UPDATE tanque INNER JOIN tanque_pertenece_escuadron on tanque.id_t = tanque_pertenece_escuadron.id_t
    SET tanque.vida = tanque.vida + 5
    WHERE tanque_pertenece_escuadron.id_e = NEW.id_e;
	END IF;
END $$
DELIMITER ;

-- b) Define un trigger para impedir que un escuadron mate un dragon que no haya sido desbloqueado por alguno de sus integrantes.

DROP TRIGGER IF EXISTS escuadron_mata_dragon;

DELIMITER $$
CREATE TRIGGER escuadron_mata_dragon BEFORE INSERT ON escuadron_vence_dragon
FOR EACH ROW
BEGIN
IF NOT EXISTS (SELECT dragon.nombre_d
				FROM escuadron_vence_dragon
						INNER JOIN dragon ON dragon.nombre_d = escuadron_vence_dragon.nombre_d
						INNER JOIN escuadron ON escuadron.id_e = escuadron_vence_dragon.id_e
                        INNER JOIN mago_pertenece_escuadron ON mago_pertenece_escuadron.id_e = escuadron.id_e
                WHERE dragon.nombre_d_desbloqueado = NEW.nombre_d AND escuadron_vence_dragon.id_e = NEW.id_e AND escuadron_vence_dragon.fecha BETWEEN mago_pertenece_escuadron.fecha_inicio AND mago_pertenece_escuadron.fecha_fin) 
		AND NOT EXISTS(SELECT dragon.nombre_d
						FROM escuadron_vence_dragon
							INNER JOIN dragon ON dragon.nombre_d = escuadron_vence_dragon.nombre_d
							INNER JOIN escuadron ON escuadron.id_e = escuadron_vence_dragon.id_e
							INNER JOIN guerrero_pertenece_escuadron ON guerrero_pertenece_escuadron.id_e = escuadron.id_e
                WHERE dragon.nombre_d_desbloqueado = NEW.nombre_d AND escuadron_vence_dragon.id_e = NEW.id_e AND escuadron_vence_dragon.fecha BETWEEN guerrero_pertenece_escuadron.fecha_inicio AND guerrero_pertenece_escuadron.fecha_fin) 
		AND NOT EXISTS(SELECT dragon.nombre_d
						FROM escuadron_vence_dragon
							INNER JOIN dragon ON dragon.nombre_d = escuadron_vence_dragon.nombre_d
							INNER JOIN escuadron ON escuadron.id_e = escuadron_vence_dragon.id_e
							INNER JOIN tanque_pertenece_escuadron ON tanque_pertenece_escuadron.id_e = escuadron.id_e
                WHERE dragon.nombre_d_desbloqueado = NEW.nombre_d AND escuadron_vence_dragon.id_e = NEW.id_e AND escuadron_vence_dragon.fecha BETWEEN tanque_pertenece_escuadron.fecha_inicio AND tanque_pertenece_escuadron.fecha_fin)
	THEN 
	SIGNAL SQLSTATE '02010'
    SET MESSAGE_TEXT = 'ERROR, alguno de los integrantes del escuadron no desbloqueo al dragon.';
END IF;
END$$
DELIMITER ;