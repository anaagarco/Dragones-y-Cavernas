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