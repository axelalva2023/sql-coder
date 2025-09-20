-- Poblar tablas con datos de ejemplo
-- Insertar géneros
INSERT INTO genero (nombre) VALUES 
('Acción'),
('Comedia'),
('Drama'),
('Ciencia Ficción');

-- Insertar directores
INSERT INTO director (nombre) VALUES
('Christopher Nolan'),
('Steven Spielberg'),
('Quentin Tarantino'),
('Pedro Almodóvar');

-- Insertar actores
INSERT INTO actor (nombre) VALUES
('Leonardo DiCaprio'),
('Brad Pitt'),
('Tom Hanks'),
('Scarlett Johansson'),
('Penélope Cruz');

-- Insertar películas
CALL agregar_pelicula('Inception', 2010, 4, 1);     -- Nolan, Ciencia Ficción
CALL agregar_pelicula('Titanic', 1997, 3, 2);       -- Spielberg, Drama
CALL agregar_pelicula('Pulp Fiction', 1994, 1, 3);  -- Tarantino, Acción
CALL agregar_pelicula('Volver', 2006, 3, 4);        -- Almodóvar, Drama

-- Relacionar películas con actores
INSERT INTO pelicula_actor VALUES
(1, 1), -- Inception - Leonardo DiCaprio
(1, 4), -- Inception - Scarlett Johansson
(2, 1), -- Titanic - Leonardo DiCaprio
(2, 5), -- Titanic - Penélope Cruz
(3, 2), -- Pulp Fiction - Brad Pitt
(3, 3), -- Pulp Fiction - Tom Hanks
(4, 5); -- Volver - Penélope Cruz

-- Probar las vistas:
-- Listado de películas con género y director
SELECT * FROM vista_peliculas_info;

-- Actores con las películas en las que participan
SELECT * FROM vista_actores_peliculas;

-- Cantidad de películas por género
SELECT * FROM vista_cantidad_peliculas_genero;

-- Cantidad de películas por director
SELECT * FROM vista_cantidad_peliculas_director;

-- Películas con sus actores listados
SELECT * FROM vista_peliculas_actores;

-- Probar las funciones
-- Cantidad de películas del género "Drama"
SELECT cantidad_peliculas_genero('Drama') AS total_dramas;

-- Director de la película "Inception"
SELECT director_de_pelicula('Inception') AS director;

-- Probar los procedimientos:
-- Agregar nueva película con el procedimiento
CALL agregar_pelicula('Interstellar', 2014, 4, 1);

-- Verificar que se insertó correctamente
SELECT * FROM pelicula WHERE titulo = 'Interstellar';

-- Obtener películas de un actor específico
CALL peliculas_por_actor('Leonardo DiCaprio');
CALL peliculas_por_actor('Penélope Cruz');

