DROP TABLE IF EXISTS partidos CASCADE;
DROP TABLE IF EXISTS equipos_liga CASCADE;
DROP TABLE IF EXISTS ligas CASCADE;
DROP TABLE IF EXISTS equipos CASCADE;

CREATE TABLE equipos (
    id              SERIAL PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL UNIQUE,
    anio_fundacion  SMALLINT NOT NULL,
    comuna_local    VARCHAR(80) NOT NULL,
    historia        TEXT NOT NULL
);

CREATE TABLE ligas (
    id             SERIAL PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    anio           SMALLINT NOT NULL,
    fecha_inicio   DATE NOT NULL,
    fecha_fin      DATE NOT NULL,
    descripcion    TEXT
);

CREATE TABLE equipos_liga (
    liga_id     INT NOT NULL REFERENCES ligas(id),
    equipo_id   INT NOT NULL REFERENCES equipos(id),
    PRIMARY KEY (liga_id, equipo_id)
);

CREATE TABLE partidos (
    id                  SERIAL PRIMARY KEY,
    liga_id             INT NOT NULL REFERENCES ligas(id),
    jornada             SMALLINT NOT NULL,
    fecha               DATE NOT NULL,
    hora_inicio         TIME NOT NULL,
    equipo_local_id     INT NOT NULL REFERENCES equipos(id),
    equipo_visita_id    INT NOT NULL REFERENCES equipos(id),
    goles_local         SMALLINT,
    goles_visita        SMALLINT,
    estado              VARCHAR(20) DEFAULT 'PROGRAMADO',
    CONSTRAINT chk_equipos_distintos CHECK (equipo_local_id <> equipo_visita_id)
);


INSERT INTO equipos (nombre, anio_fundacion, comuna_local, historia) VALUES
('Atlético Nueva Providencia', 1962, 'Providencia',
 'Fundado por comerciantes y estudiantes del sector Nueva Providencia, surgió como un club de barrio que buscaba unir a la comunidad en torno al fútbol amateur.'),
('Unión San Miguel', 1974, 'San Miguel',
 'Nació tras la fusión de dos equipos juveniles del sector norte de San Miguel, con una fuerte identidad ligada a las escuelas públicas de la comuna.'),
('Deportivo Lo Prado Unido', 1981, 'Lo Prado',
 'Creado por vecinos de distintas villas de Lo Prado, el club se consolidó gracias a campeonatos internos organizados en canchas de tierra.'),
('Municipal Cerro Navia Sur', 1990, 'Cerro Navia',
 'Impulsado por la municipalidad y dirigentes sociales, buscó dar una alternativa deportiva a niños y jóvenes de los barrios del sur de Cerro Navia.'),
('Juventud Estación Central', 1958, 'Estación Central',
 'Su origen está ligado a trabajadores ferroviarios y pequeños comerciantes del entorno de la Estación Central, con una tradición de fútbol aguerrido.'),
('Real Independencia', 1968, 'Independencia',
 'Fundado por hinchas apasionados de diversos clubes profesionales, quisieron crear su propio "real" de barrio en las canchas municipales de Independencia.'),
('Club Social Barrio Yungay', 1949, 'Santiago',
 'Nació como un club social y cultural del histórico Barrio Yungay, donde el fútbol se transformó en su principal actividad comunitaria.'),
('Unión Recoleta Norte', 1987, 'Recoleta',
 'Formado por equipos de pasaje y pasaje del sector norte de Recoleta, se unieron para competir en ligas barriales más organizadas.'),
('Huracán La Cisterna', 1971, 'La Cisterna',
 'Inspirado en el viento que suele azotar la zona, el club adoptó un estilo de juego ofensivo que lo hizo famoso en campeonatos locales.'),
('Deportivo Parque O''Higgins', 2003, 'Santiago',
 'Fundado por deportistas aficionados que entrenaban en el Parque O''Higgins, mezclando trote recreativo y fútbol amateur de fin de semana.'),
('Estrella de Pedro Aguirre Cerda', 1995, 'Pedro Aguirre Cerda',
 'Nació en una población emblemática de la comuna, buscando ser la "estrella" deportiva de los jóvenes del sector.'),
('Atlético Santiago Centro', 1952, 'Santiago',
 'Formado por oficinistas y estudiantes del centro de la ciudad, compite hace décadas en ligas empresariales y barriales de la capital.'),
('Municipal San Joaquín Oriente', 2001, 'San Joaquín',
 'Proyecto impulsado por la oficina de deportes de la comuna para potenciar el fútbol formativo en los barrios del sector oriente de San Joaquín.'),
('Club Deportivo Villa Portales', 1965, 'Estación Central',
 'Nació dentro del conjunto habitacional Villa Portales, con un fuerte arraigo comunitario y una tradición de torneos internos muy competitivos.'),
('Unión Macul Viejo', 1979, 'Macul',
 'Creado por familias tradicionales del sector conocido como Macul Viejo, representa la historia y memoria futbolera de la comuna.'),
('Deportivo Franklin Unido', 1983, 'Santiago',
 'Tiene sus raíces en el barrio comercial de Franklin, donde locatarios y cargadores formaron un equipo para representar al sector en campeonatos.'),
('Atlético Parque Forestal', 1999, 'Santiago',
 'Fundado por jóvenes que jugaban fútbol callejero en el entorno del Parque Forestal, se formalizó para participar en ligas organizadas.'),
('Sporting Ñuñoa Sur', 1976, 'Ñuñoa',
 'Club con vocación multideportiva del sector sur de Ñuñoa, donde el fútbol se convirtió en la disciplina principal.'),
('Municipal Providencia Cordillera', 2005, 'Providencia',
 'Proyecto deportivo municipal orientado a deportistas del eje oriente y precordillerano de Providencia, con énfasis en trabajo juvenil.'),
('Ferroviarios de Quinta Normal', 1956, 'Quinta Normal',
 'Formado por trabajadores vinculados al mundo ferroviario que residían en Quinta Normal, heredando la mística del esfuerzo y el sacrificio.');

INSERT INTO ligas (nombre, anio, fecha_inicio, fecha_fin, descripcion) VALUES
('Liga Provincial de Santiago 2026', 2026, '2026-03-07', '2026-12-20',
 'Liga de ida y vuelta entre 20 clubes de la provincia de Santiago.');

INSERT INTO equipos_liga (liga_id, equipo_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(1, 18),
(1, 19),
(1, 20);

INSERT INTO partidos 
(liga_id, jornada, fecha, hora_inicio, equipo_local_id, equipo_visita_id, goles_local, goles_visita)
VALUES
(1, 1, '2026-03-07', '12:00',  1,  2, NULL, NULL),
(1, 1, '2026-03-07', '15:00',  3,  4, NULL, NULL),
(1, 1, '2026-03-07', '18:00',  5,  6, NULL, NULL),
(1, 1, '2026-03-08', '12:00',  7,  8, NULL, NULL),
(1, 1, '2026-03-08', '15:00',  9, 10, NULL, NULL),
(1, 1, '2026-03-08', '18:00', 11, 12, NULL, NULL),
(1, 1, '2026-03-08', '20:30', 13, 14, NULL, NULL),
(1, 1, '2026-03-07', '20:30', 15, 16, NULL, NULL),
(1, 1, '2026-03-08', '10:00', 17, 18, NULL, NULL),
(1, 1, '2026-03-07', '10:00', 19, 20, NULL, NULL),

(1, 2, '2026-03-14', '12:00',  2,  3, NULL, NULL),
(1, 2, '2026-03-14', '15:00',  4,  5, NULL, NULL),
(1, 2, '2026-03-14', '18:00',  6,  7, NULL, NULL),
(1, 2, '2026-03-15', '12:00',  8,  9, NULL, NULL),
(1, 2, '2026-03-15', '15:00', 10, 11, NULL, NULL),
(1, 2, '2026-03-15', '18:00', 12, 13, NULL, NULL),
(1, 2, '2026-03-15', '20:30', 14, 15, NULL, NULL),
(1, 2, '2026-03-14', '20:30', 16, 17, NULL, NULL),
(1, 2, '2026-03-15', '10:00', 18, 19, NULL, NULL),
(1, 2, '2026-03-14', '10:00', 20,  1, NULL, NULL),

(1, 3, '2026-03-21', '10:00',  1,  3, NULL, NULL),
(1, 3, '2026-03-21', '12:00',  2,  5, NULL, NULL),
(1, 3, '2026-03-21', '15:00',  4,  6, NULL, NULL),
(1, 3, '2026-03-21', '18:00',  7,  9, NULL, NULL),
(1, 3, '2026-03-21', '20:30',  8, 11, NULL, NULL),
(1, 3, '2026-03-22', '10:00', 10, 12, NULL, NULL),
(1, 3, '2026-03-22', '12:00', 13, 15, NULL, NULL),
(1, 3, '2026-03-22', '15:00', 14, 16, NULL, NULL),
(1, 3, '2026-03-22', '18:00', 17, 19, NULL, NULL),
(1, 3, '2026-03-22', '20:30', 18, 20, NULL, NULL),

(1, 4, '2026-03-28', '10:00',  1,  4, NULL, NULL),
(1, 4, '2026-03-28', '12:00',  2,  6, NULL, NULL),
(1, 4, '2026-03-28', '15:00',  3,  5, NULL, NULL),
(1, 4, '2026-03-28', '18:00',  7, 10, NULL, NULL),
(1, 4, '2026-03-28', '20:30',  8, 12, NULL, NULL),
(1, 4, '2026-03-29', '10:00',  9, 11, NULL, NULL),
(1, 4, '2026-03-29', '12:00', 13, 16, NULL, NULL),
(1, 4, '2026-03-29', '15:00', 14, 18, NULL, NULL),
(1, 4, '2026-03-29', '18:00', 15, 19, NULL, NULL),
(1, 4, '2026-03-29', '20:30', 17, 20, NULL, NULL),

(1, 5, '2026-04-04', '10:00',  1,  5, NULL, NULL),
(1, 5, '2026-04-04', '12:00',  2,  4, NULL, NULL),
(1, 5, '2026-04-04', '15:00',  3,  6, NULL, NULL),
(1, 5, '2026-04-04', '18:00',  7, 11, NULL, NULL),
(1, 5, '2026-04-04', '20:30',  8, 10, NULL, NULL),
(1, 5, '2026-04-05', '10:00',  9, 12, NULL, NULL),
(1, 5, '2026-04-05', '12:00', 13, 17, NULL, NULL),
(1, 5, '2026-04-05', '15:00', 14, 19, NULL, NULL),
(1, 5, '2026-04-05', '18:00', 15, 18, NULL, NULL),
(1, 5, '2026-04-05', '20:30', 16, 20, NULL, NULL);
