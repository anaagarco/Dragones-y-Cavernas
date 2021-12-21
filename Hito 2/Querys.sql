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