CREATE SCHEMA DragonesyCavernas
DEFAULT CHARACTER SET utf8
COLLATE utf8_spanish2_ci;
USE DragonesyCavernas;

/*Jugador (Mail, pass, nickname)*/

CREATE TABLE jugador (
    mail VARCHAR(30) UNIQUE NOT NULL,
    pass VARCHAR(30) NOT NULL,
    nickname VARCHAR(30) NOT NULL,
    PRIMARY KEY (mail)
);

/*NPC (ID_NPC, tipo)*/

CREATE TABLE npc (
    id_npc VARCHAR(40) UNIQUE NOT NULL,
    tipo VARCHAR(15) NOT NULL,
    PRIMARY KEY (id_npc)
);

/*Zona (ID_Zona)*/

CREATE TABLE zona (
    id_zona INTEGER NOT NULL,
    PRIMARY KEY (id_zona)
);

/*Ciudad (Nombre_c,ID_zona)*/

CREATE TABLE ciudad (
    nombre_c VARCHAR(30) UNIQUE NOT NULL,
    id_zona INTEGER NOT NULL,
    PRIMARY KEY (nombre_c),
    CONSTRAINT FOREIGN KEY (id_zona)
        REFERENCES zona (id_zona)
);

/*Tienda (id_t,ID_NPC,Nombre_C)*/

CREATE TABLE tienda (
    nombre_t VARCHAR(30) NOT NULL,
    id_npc VARCHAR(40) NOT NULL,
    nombre_c VARCHAR(30) NOT NULL,
    PRIMARY KEY (nombre_t,nombre_c),
    CONSTRAINT FOREIGN KEY (id_npc)
        REFERENCES npc (id_npc),
    CONSTRAINT FOREIGN KEY (nombre_c)
        REFERENCES ciudad (nombre_c)
        ON DELETE CASCADE ON UPDATE CASCADE
); 

/*Espectro (Cod_ME,vida, oro_soltado)*/

CREATE TABLE espectro (
    cod_me VARCHAR(30) UNIQUE NOT NULL,
    vida INTEGER NOT NULL,
    oro_soltado INTEGER NOT NULL,
    PRIMARY KEY (cod_me)
);

/*Trol (Cod_MT,vida, oro_soltado)*/

CREATE TABLE trol (
    cod_mt VARCHAR(30) UNIQUE NOT NULL,
    vida INTEGER NOT NULL,
    oro_soltado INTEGER NOT NULL,
    PRIMARY KEY (cod_mt)
);

/*Goblin (Cod_mg,vida, oro_soltado)*/

CREATE TABLE goblin (
    cod_mg VARCHAR(30) UNIQUE NOT NULL,
    vida INTEGER NOT NULL,
    oro_soltado INTEGER NOT NULL,
    PRIMARY KEY (cod_mg)
);

/*Hab_mago (Nombre, descripción)*/

CREATE TABLE hab_mago (
    nombre_hm VARCHAR(30) UNIQUE NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    PRIMARY KEY (nombre_hm)
);

/*Hab_guerrero (Nombre, descripción)*/

CREATE TABLE hab_guerrero (
    nombre_hg VARCHAR(30) UNIQUE NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    PRIMARY KEY (nombre_hg)
);
/*Hab_tanque (Nombre, descripción)*/
CREATE TABLE hab_tanque (
    nombre_ht VARCHAR(30) UNIQUE NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    PRIMARY KEY (nombre_ht)
);

/*Poción (Cod_P, valores_regeneración, tipo)*/

CREATE TABLE pocion (
    cod_p INTEGER UNIQUE NOT NULL,
    valores_regeneracion INTEGER NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    PRIMARY KEY (cod_p)
);

/*Dragón (Nombre_D, vida,Nombre_D_Desbloqueado)*/

CREATE TABLE dragon (
    nombre_d VARCHAR(30) UNIQUE NOT NULL,
    vida INTEGER NOT NULL,
    nombre_d_desbloqueado VARCHAR(30),
    PRIMARY KEY (nombre_d),
    CONSTRAINT FOREIGN KEY (nombre_d_desbloqueado)
        REFERENCES dragon (nombre_d)
);

/*Mago (id__m, Mana,vida,nivel)*/

-- LOS ROLES SON FUERTES DE IDENTIDAD PERO NO DE EXISTENCIA Y COMO CON PERSONAJE LA RELACION ES 1:N -- 

CREATE TABLE mago (
    id_m VARCHAR(30) UNIQUE NOT NULL,
    mana INTEGER NOT NULL,
    vida INTEGER NOT NULL,
    nivel INTEGER NOT NULL,
    PRIMARY KEY (id_m)
);

/*Guerrero (id_g,Mana, vida,nivel)*/

-- LOS ROLES SON FUERTES DE IDENTIDAD PERO NO DE EXISTENCIA Y COMO CON PERSONAJE LA RELACION ES 1:N -- 

CREATE TABLE guerrero (
    id_g VARCHAR(30) UNIQUE NOT NULL,
    mana INTEGER NOT NULL,
    vida INTEGER NOT NULL,
    nivel INTEGER NOT NULL,
    PRIMARY KEY (id_g)
);

/*Tanque (id_t,Mana, vida,nivel)*/

-- LOS ROLES SON FUERTES DE IDENTIDAD PERO NO DE EXISTENCIA Y COMO CON PERSONAJE LA RELACION ES 1:N -- 

CREATE TABLE tanque (
    id_t VARCHAR(30) UNIQUE NOT NULL,
    mana INTEGER NOT NULL,
    vida INTEGER NOT NULL,
    nivel INTEGER NOT NULL,
    PRIMARY KEY (id_t)
);

/*Personaje (Nombre_P,fuerza,Mail,id_m,id_g,id_t)*/

CREATE TABLE personaje (
    nombre_p VARCHAR(30) UNIQUE NOT NULL,
    fuerza INTEGER NOT NULL,
    mail VARCHAR(30) UNIQUE NOT NULL,
    id_m VARCHAR(30),
    id_g VARCHAR(30),
    id_t VARCHAR(30),
    PRIMARY KEY (nombre_p),
    CONSTRAINT FOREIGN KEY (mail)
        REFERENCES jugador (mail),
    CONSTRAINT FOREIGN KEY (id_m)
        REFERENCES mago (id_m),
    CONSTRAINT FOREIGN KEY (id_g)
        REFERENCES guerrero (id_g),
    CONSTRAINT FOREIGN KEY (id_t)
        REFERENCES tanque (id_t)
);

/*Escuadrón (id_e)*/

CREATE TABLE escuadron (
    id_e INTEGER UNIQUE NOT NULL,
    PRIMARY KEY (id_e)
);

/*Mago_pertenece_escuadron(id_m,id_e,fecha_inicio,fecha_fin)*/

CREATE TABLE mago_pertenece_escuadron(
id_e INTEGER NOT NULL,
id_m VARCHAR(30) NOT NULL,
fecha_inicio DATE,
fecha_fin DATE,
PRIMARY KEY(id_e,id_m),
 CONSTRAINT FOREIGN KEY (id_e)
        REFERENCES escuadron (id_e),
	CONSTRAINT FOREIGN KEY (id_m)
        REFERENCES mago (id_m)
);

/*guerrero_pertenece_escuadron(id_g,id_e,fecha_inicio,fecha_fin)*/

CREATE TABLE guerrero_pertenece_escuadron(
id_e INTEGER NOT NULL,
id_g VARCHAR(30) NOT NULL,
fecha_inicio DATE,
fecha_fin DATE,
PRIMARY KEY(id_e,id_g),
 CONSTRAINT FOREIGN KEY (id_e)
        REFERENCES escuadron (id_e),
	CONSTRAINT FOREIGN KEY (id_g)
        REFERENCES guerrero (id_g)
);

/*Tanque_pertenece_escuadron(id_t,id_e,fecha_inicio,fecha_fin)*/

CREATE TABLE tanque_pertenece_escuadron(
id_e INTEGER NOT NULL,
id_t VARCHAR(30) NOT NULL,
fecha_inicio DATE,
fecha_fin DATE,
PRIMARY KEY(id_e,id_t),
 CONSTRAINT FOREIGN KEY (id_e)
        REFERENCES escuadron (id_e),
	CONSTRAINT FOREIGN KEY (id_t)
        REFERENCES tanque (id_t)
);

    
/*Escuadrón_vence_dragón (Nombre,ID_E,fecha)*/

CREATE TABLE escuadron_vence_dragon (
    nombre_d VARCHAR(30) NOT NULL,
    id_e INTEGER NOT NULL,
    fecha DATE,
    PRIMARY KEY (nombre_d,id_e),
    CONSTRAINT FOREIGN KEY (nombre_d)
        REFERENCES dragon (nombre_d),
	CONSTRAINT FOREIGN KEY (id_e)
        REFERENCES escuadron (id_e)
);

/*Tanque_tiene_Hab_Tanque (Nombre_HT,id_t,Nombre_P)*/

CREATE TABLE tanque_tiene_hab_tanque (
    nombre_ht VARCHAR(30) NOT NULL,
    id_t VARCHAR(30) NOT NULL,
    PRIMARY KEY (nombre_ht,id_t),
    CONSTRAINT FOREIGN KEY (id_t)
        REFERENCES tanque (id_t)
);

/*Mago_tiene_Hab_Mago(Nombre_HM,id_m,Nombre_P)*/

CREATE TABLE mago_tiene_hab_mago (
    nombre_hm VARCHAR(30) NOT NULL,
    id_m VARCHAR(30) NOT NULL,
    PRIMARY KEY (nombre_hm,id_m),
    CONSTRAINT FOREIGN KEY (id_m)
        REFERENCES mago (id_m)
);

/*Guerrero_tiene_Hab_Guerrero(Nombre_HG,id_g,Nombre_P)*/

CREATE TABLE guerrero_tiene_hab_guerrero (
    nombre_hg VARCHAR(30) NOT NULL,
    id_g VARCHAR(30) NOT NULL,
    PRIMARY KEY (nombre_hg,id_g),
    CONSTRAINT FOREIGN KEY (id_g)
        REFERENCES guerrero (id_g)
);

/*Personaje_entrega_NPC_Pocion(ID_NPC,codP,Nombre,fecha)*/

CREATE TABLE personaje_entrega_npc_pocion (
    id_npc VARCHAR(40) NOT NULL,
    cod_p INTEGER NOT NULL,
    nombre_p VARCHAR(30) NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (id_npc,cod_p,nombre_p),
    CONSTRAINT FOREIGN KEY (id_npc)
        REFERENCES npc (id_npc),
    CONSTRAINT FOREIGN KEY (cod_p)
        REFERENCES pocion (cod_p),
    CONSTRAINT FOREIGN KEY (nombre_p)
        REFERENCES personaje (nombre_p)
);

/*Daga (ID_Daga,tipo, Nombre_P)*/

CREATE TABLE daga (
    id_daga INTEGER NOT NULL,
    tipo VARCHAR(15),
    nombre_p VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_daga),
    CONSTRAINT FOREIGN KEY (nombre_p)
        REFERENCES personaje (nombre_p)
);

/*Tanque_enfrenta_Trol(codMT,id_t,Nombre_P)*/

CREATE TABLE tanque_enfrenta_trol (
    cod_mt VARCHAR(30) NOT NULL,
    id_t VARCHAR(30) NOT NULL,
    PRIMARY KEY (cod_mt,id_t),
    CONSTRAINT FOREIGN KEY (id_t)
        REFERENCES tanque (id_t),
    CONSTRAINT FOREIGN KEY (cod_mt)
        REFERENCES trol (cod_mt)
);

/*Guerrero_batalla_Goblin(codMG,id_t,Nombre_P)*/

CREATE TABLE guerrero_batalla_goblin (
    cod_mg VARCHAR(30) NOT NULL,
    id_g VARCHAR(30) NOT NULL,
    PRIMARY KEY (cod_mg,id_g),
    CONSTRAINT FOREIGN KEY (id_g)
        REFERENCES guerrero (id_g),
    CONSTRAINT FOREIGN KEY (cod_mg)
        REFERENCES goblin (cod_mg)
);

/*Mago_derrota_Espectro(codME,id_m,Nombre_P)*/

CREATE TABLE mago_derrota_espectro (
    cod_me VARCHAR(30) NOT NULL,
    id_m VARCHAR(30) NOT NULL,
    PRIMARY KEY (cod_me,id_m),
    CONSTRAINT FOREIGN KEY (id_m)
        REFERENCES mago (id_m),
    CONSTRAINT FOREIGN KEY (cod_me)
        REFERENCES espectro (cod_me)
);

/*Forja (Nombre_F,ID_NPC,Nombre_B,Nombre_H,nombre_E)*/

CREATE TABLE forja (
    nombre_f VARCHAR(30) UNIQUE NOT NULL,
    id_npc VARCHAR(40) NOT NULL,
    PRIMARY KEY (nombre_f),
    CONSTRAINT FOREIGN KEY (id_npc)
		REFERENCES npc (id_npc)
);

/*Báculo (Nombre_B, año, peso,id_m,Nombre_P,id_m,Nombre_P)*/


CREATE TABLE baculo (
    nombre_b VARCHAR(30) UNIQUE NOT NULL,
    anio INTEGER,
    peso INTEGER,
    id_m VARCHAR(30) NOT NULL,
    nombre_f VARCHAR(30) NOT NULL,
    PRIMARY KEY (nombre_b),
    CONSTRAINT FOREIGN KEY (id_m)
        REFERENCES mago (id_m),
    CONSTRAINT FOREIGN KEY (nombre_f)
		REFERENCES forja (nombre_f)
);

/*Hacha (Nombre_H, año, peso,id_t,Nombre_P,id_t,Nombre_P)*/
CREATE TABLE hacha (
    nombre_h VARCHAR(30) UNIQUE NOT NULL,
    anio INTEGER,
    peso INTEGER,
    id_t VARCHAR(30) NOT NULL,
    nombre_f VARCHAR(30) NOT NULL,
    PRIMARY KEY (nombre_h),
    CONSTRAINT FOREIGN KEY (id_t)
        REFERENCES tanque (id_t),
    CONSTRAINT FOREIGN KEY (nombre_f)
		REFERENCES forja (nombre_f)
);


/*Espada (Nombre_E, año, peso,id_g,Nombre_P,id_g,Nombre_P)*/

CREATE TABLE espada (
    nombre_e VARCHAR(30) UNIQUE NOT NULL,
    anio INTEGER,
    peso INTEGER,
    id_g VARCHAR(30) NOT NULL,
    nombre_f VARCHAR(30) NOT NULL,
    PRIMARY KEY (nombre_e),
    CONSTRAINT FOREIGN KEY (id_g)
        REFERENCES guerrero (id_g),
    CONSTRAINT FOREIGN KEY (nombre_f)
		REFERENCES forja (nombre_f)
);


/*Tienda_compra_Daga(id_t,Nombre_C,ID_Daga)*/

CREATE TABLE tienda_compra_daga (
    nombre_t VARCHAR(30) NOT NULL,
    nombre_c VARCHAR(30) NOT NULL,
    id_daga INTEGER NOT NULL,
    PRIMARY KEY (nombre_t,nombre_c,id_daga),
    CONSTRAINT FOREIGN KEY (nombre_t)
        REFERENCES tienda (nombre_t),
    CONSTRAINT FOREIGN KEY (nombre_c)
        REFERENCES ciudad (nombre_c),
    CONSTRAINT FOREIGN KEY (id_daga)
        REFERENCES daga (id_daga)
);

/*Forja_se_encuentra_ciudad(Nombre_C,Nombre_F)*/

CREATE TABLE forja_se_encuentra_ciudad (
    nombre_c VARCHAR(30) NOT NULL,
    nombre_f VARCHAR(30) NOT NULL,
    PRIMARY KEY (nombre_c,nombre_f),
    CONSTRAINT FOREIGN KEY (nombre_c)
        REFERENCES ciudad (nombre_c),
    CONSTRAINT FOREIGN KEY (nombre_f)
        REFERENCES forja (nombre_f)
);

/*Mago_fabrica_en_Forja(Nombre_F,id_m,Nombre_P,fecha)*/

CREATE TABLE mago_fabrica_en_forja (
    nombre_f VARCHAR(30) NOT NULL,
    id_m VARCHAR(30) NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (nombre_f,id_m),
    CONSTRAINT FOREIGN KEY (nombre_f)
        REFERENCES forja (nombre_f),
    CONSTRAINT FOREIGN KEY (id_m)
        REFERENCES mago (id_m)
);

/*Guerrero_crea_en_forja(id_g,Nombre_P,Nombre_F,fecha)*/

CREATE TABLE guerrero_crea_en_forja (
    nombre_f VARCHAR(30) NOT NULL,
    id_g VARCHAR(30) NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (nombre_f,id_g),
    CONSTRAINT FOREIGN KEY (nombre_f)
        REFERENCES forja (nombre_f),
    CONSTRAINT FOREIGN KEY (id_g)
        REFERENCES guerrero (id_g)
);

/*Tanque_hace_en_Forja(id_t,Nombre_P,Nombre_F,fecha)*/

CREATE TABLE tanque_hace_en_forja (
    nombre_f VARCHAR(30) NOT NULL,
    id_t VARCHAR(30) NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (nombre_f,id_t),
    CONSTRAINT FOREIGN KEY (nombre_f)
        REFERENCES forja (nombre_f),
    CONSTRAINT FOREIGN KEY (id_t)
        REFERENCES tanque (id_t)
);

/*personaje_compra_daga(id_daga, nombre_p)*/
CREATE TABLE personaje_compra_daga (
    id_daga INT NOT NULL,
    nombre_p VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_daga,nombre_p),
    CONSTRAINT FOREIGN KEY (nombre_p)
        REFERENCES personaje (nombre_p),
    CONSTRAINT FOREIGN KEY (id_daga)
        REFERENCES daga (id_daga)
);

-- ---------------------------------------------- INSERTS -------------------------------------------------------------

INSERT INTO DragonesyCavernas.zona VALUES
(0);

INSERT INTO DragonesyCavernas.dragon VALUES
('Ocho Cabezas',1004,null),
('Kystorm',1003,'Ocho Cabezas'),
('Griffin',1002,'Kystorm'),
('Pastan',1001,'Griffin'),
('Rannyexbea',1000,'Pastan'),
('Dehiss',999,'Rannyexbea');

INSERT INTO DragonesyCavernas.mago VALUES
('Raendan',10,20,0),
('Manddin',30,40,10),
('Xadel',50,60,20),
('Enso',70,80,30);

INSERT INTO DragonesyCavernas.guerrero VALUES
('Stanto',10,20,0),
('Makwi',10,20,10),
('Carorhall',10,20,20),
('Dryto',10,20,30);

INSERT INTO DragonesyCavernas.tanque VALUES
('Ahkarg',10,20,0),
('Bucksel',10,20,10),
('Mashgor',10,20,20),
('Gim',10,20,30);

INSERT INTO DragonesyCavernas.ciudad VALUES
('Glider',0),
('Forgesand',0),
('Hiltore',0),
('Gazegreenelven',0),
('Greenbat',0),
('Huntdwarf',0);

INSERT INTO DragonesyCavernas.npc VALUES
('Zucsur','druida'),
('Losla','druida'),
('Tar','druida'),
('Pikduk','druida'),
('Pepe', 'herrero'),
('Aravis', 'herrero'),
('Tyrion', 'herrero'),
('Galadriel', 'dependiente'),
('Eowin', 'dependiente'),
('Junyous', 'dependiente');


INSERT INTO DragonesyCavernas.tienda VALUES
('Tienda de Rolla','Galadriel','Forgesand'),
('Tienda de Swithron','Eowin','Gazegreenelven'),
('Tienda de Aldlas','Junyous','Huntdwarf');

INSERT INTO DragonesyCavernas.forja VALUES
('Forja de Harmek','Pepe'),
('Forja del enano risueño','Tyrion'),
('Forja de Tebez','Aravis');

INSERT INTO DragonesyCavernas.hacha VALUES
('Hacha de mano',2000,50,'Ahkarg','Forja de Tebez'),
('Hacha Arrojadiza',1950,30,'Mashgor','Forja de Tebez'),
('Hacha de doble Punta',2010,10,'Gim','Forja del enano risueño');

INSERT INTO DragonesyCavernas.baculo VALUES
('Baculo de Madera',2000,50,'Raendan','Forja de Harmek'),
('Mensajero de Mana',1950,30,'Xadel','Forja de Harmek'),
('Raiz de Oscuridad',2010,10,'Enso','Forja de Harmek');

INSERT INTO DragonesyCavernas.espada VALUES
('Alfanje',2000,50,'Stanto', 'Forja del enano risueño'),
('Espada Flamigera',1950,30,'Makwi','Forja del enano risueño'),
('Bracamarte',2010,10,'Carorhall','Forja del enano risueño');

INSERT INTO DragonesyCavernas.jugador VALUES
('prueba0@prueba.com',12345678,'Breakfury'),
('prueba1@prueba.com',12345678,'Hammerpowerthunder'),
('prueba2@prueba.com',12345678,'Battlerboar'),
('prueba3@prueba.com',12345678,'Cloakbane'),
('prueba4@prueba.com',12345678,'Greyblade'),
('prueba5@prueba.com',12345678,'Magnus'),
('prueba6@prueba.com',12345678,'SiriusBlack');

INSERT INTO DragonesyCavernas.personaje VALUES
('Raendan',10,'prueba0@prueba.com','Raendan',NULL,NULL),
('Manddin',10,'prueba4@prueba.com','Manddin',NULL,NULL),
('Stanto',20,'prueba1@prueba.com',NULL,'Stanto',NULL),
('Makwi',20,'prueba5@prueba.com',NULL,'Makwi',NULL),
('Ahkarg',30,'prueba2@prueba.com',NULL,NULL,'Ahkarg'),
('Bucksel',30,'prueba6@prueba.com',NULL,NULL,'Bucksel'),
('Xadel',30,'prueba3@prueba.com','Xadel',NULL,NULL);

INSERT INTO DragonesyCavernas.daga VALUES
(1,'Madera','Xadel'),
(2,'Hierro','Stanto'),
(3,'Fuego','Ahkarg'),
(4,'Hielo','Raendan');

INSERT INTO DragonesyCavernas.personaje_compra_daga VALUES
(1, 'Raendan'),
(2,'Stanto'),
(2,'Raendan'),
(3,'Raendan'),
(3,'Ahkarg'),
(4,'Raendan');

INSERT INTO DragonesyCavernas.espectro VALUES
('Ligos',100,200),
('Bachpai',200,400),
('Lira',300,600),
('Hana',400,800);

INSERT INTO DragonesyCavernas.goblin VALUES
('Kruulha',100,200),
('Rargbal',200,400),
('Aalor',300,600),
('Goleth',400,800);

INSERT INTO DragonesyCavernas.trol VALUES
('Ibe',100,200),
('Ry',200,400),
('Ulne',300,600),
('Fargan',400,800);

INSERT INTO DragonesyCavernas.hab_mago VALUES
('Intelecto Arcano','buf de ataque'),
('Traslacion','pequeño teletransporte'),
('Nova de Escarcha','ataque que congela enemigos');

INSERT INTO DragonesyCavernas.hab_guerrero VALUES
('Tajo de mandoble','Tajo doble con el mandoble'),
('Impacto abrumador','golpe en la tierra'),
('Ataque en torbellino','ataca dando vueltas sobre si mismo');

INSERT INTO DragonesyCavernas.hab_tanque VALUES
('Impacto feroz','aturde al enemigo'),
('Rompespaldas','Abrazo del oso'),
('Seismo','golpea al suelo creandolo');

INSERT INTO DragonesyCavernas.escuadron VALUES
(1),
(2);

INSERT INTO DragonesyCavernas.mago_pertenece_escuadron VALUES
(1,'Raendan','2004-08-23','2021-11-28'),
(2,'Manddin','2006-10-23','2021-11-28');

INSERT INTO DragonesyCavernas.guerrero_pertenece_escuadron VALUES
(1,'Stanto','2004-08-21','2021-11-28'),
(2,'Makwi','2006-08-23','2021-11-28');

INSERT INTO DragonesyCavernas.tanque_pertenece_escuadron VALUES
(1,'Ahkarg','2004-08-20','2021-11-28'),
(2,'Bucksel','2006-10-21','2021-11-28');

INSERT INTO DragonesyCavernas.escuadron_vence_dragon VALUES
('Dehiss',1,'2004-08-25'),
('Rannyexbea',1,'2005-09-04'),
('Pastan',1,'2006-02-28'),
('Dehiss',2,'2006-11-25');

INSERT INTO DragonesyCavernas.forja_se_encuentra_ciudad VALUES
('Glider','Forja de Harmek'),
('Forgesand','Forja del enano risueño'),
('Hiltore','Forja de Tebez');

INSERT INTO DragonesyCavernas.guerrero_batalla_goblin VALUES
('Kruulha','Stanto'),
('Rargbal','Makwi'),
('Aalor','Carorhall'),
('Goleth','Dryto'),
('Goleth', 'Stanto'),
('Rargbal', 'Stanto');

INSERT INTO DragonesyCavernas.guerrero_crea_en_forja VALUES
('Forja de Harmek','Stanto','2000-03-04'),
('Forja del enano risueño','Carorhall','2002-07-30'),
('Forja de Tebez','Dryto','2001-04-16');

INSERT INTO DragonesyCavernas.guerrero_tiene_hab_guerrero VALUES
('Tajo de mandoble','Dryto'),
('Impacto abrumador','Stanto'),
('Ataque en torbellino','Carorhall');

INSERT INTO DragonesyCavernas.mago_derrota_espectro VALUES
('Ligos','Raendan'),
('Bachpai','Raendan'),
('Lira','Raendan'),
('Hana','Raendan'),
('Bachpai','Manddin'),
('Lira','Xadel'),
('Hana','Enso');

INSERT INTO DragonesyCavernas.mago_fabrica_en_forja VALUES
('Forja de Harmek','Raendan','2000-03-04'),
('Forja del enano risueño','Manddin','2002-07-30'),
('Forja de Tebez','Xadel','2001-04-16');

INSERT INTO DragonesyCavernas.mago_tiene_hab_mago VALUES
('Intelecto Arcano','Raendan'),
('Traslacion','Enso'),
('Ataque en torbellino','Xadel');

INSERT INTO DragonesyCavernas.pocion VALUES
(1,10,'Vida'),
(2,30,'Vida'),
(3,50,'Vida'),
(4,10,'Mana'),
(5,30,'Mana'),
(6,50,'Mana');

INSERT INTO DragonesyCavernas.personaje_entrega_npc_pocion VALUES
('Pikduk',1,'Stanto','2001-12-25'),
('Losla',2,'Stanto','2001-12-26'),
('Zucsur',3,'Stanto','2001-12-27'),
('Tar',4,'Stanto','2001-12-24'),
('Losla',2,'Xadel','2002-01-10'),
('Tar',4,'Ahkarg','2003-02-15'),
('Zucsur',6,'Xadel','2001-03-20');

INSERT INTO DragonesyCavernas.tanque_enfrenta_trol VALUES
('Ibe','Gim'),
('Ry','Mashgor'),
('Ulne','Bucksel'),
('Fargan','Ahkarg');

INSERT INTO DragonesyCavernas.tanque_tiene_hab_tanque VALUES
('Impacto feroz','Mashgor'),
('Rompespaldas','Gim'),
('Seismo','Ahkarg');

INSERT INTO DragonesyCavernas.tienda_compra_daga VALUES
('Tienda de Rolla','Forgesand',2),
('Tienda de Swithron','Gazegreenelven',3),
('Tienda de Aldlas','Huntdwarf',4);