
-- Crear la BD:
CREATE DATABASE peliculas;
USE peliculas; 

-- Tablas:
-- Tabla de géneros
CREATE TABLE genero (
    id_genero INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla de directores
CREATE TABLE director (
    id_director INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla de películas
CREATE TABLE pelicula (
    id_pelicula INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    anio INT,
    id_genero INT,
    id_director INT,
    FOREIGN KEY (id_genero) REFERENCES genero(id_genero),
    FOREIGN KEY (id_director) REFERENCES director(id_director)
);

-- Tabla de actores
CREATE TABLE actor (
    id_actor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

-- Relación muchos a muchos entre películas y actores
CREATE TABLE pelicula_actor (
    id_pelicula INT,
    id_actor INT,
    PRIMARY KEY (id_pelicula, id_actor),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
    FOREIGN KEY (id_actor) REFERENCES actor(id_actor)
);

-- 1) Vista: Listado de películas con su género y director
CREATE VIEW vista_peliculas_info AS
SELECT 
    p.id_pelicula,
    p.titulo,
    p.anio,
    g.nombre AS genero,
    d.nombre AS director
FROM pelicula p
JOIN genero g ON p.id_genero = g.id_genero
JOIN director d ON p.id_director = d.id_director;

-- 2) Vista: Actores con las películas en las que participan
CREATE VIEW vista_actores_peliculas AS
SELECT 
    a.id_actor,
    a.nombre AS actor,
    p.titulo AS pelicula,
    p.anio
FROM actor a
JOIN pelicula_actor pa ON a.id_actor = pa.id_actor
JOIN pelicula p ON pa.id_pelicula = p.id_pelicula;

-- 3) Vista: Cantidad de películas por género
CREATE VIEW vista_cantidad_peliculas_genero AS
SELECT 
    g.nombre AS genero,
    COUNT(p.id_pelicula) AS cantidad_peliculas
FROM genero g
LEFT JOIN pelicula p ON g.id_genero = p.id_genero
GROUP BY g.id_genero, g.nombre;

-- 4) Vista: Cantidad de películas dirigidas por cada director
CREATE VIEW vista_cantidad_peliculas_director AS
SELECT 
    d.nombre AS director,
    COUNT(p.id_pelicula) AS cantidad_peliculas
FROM director d
LEFT JOIN pelicula p ON d.id_director = p.id_director
GROUP BY d.id_director, d.nombre;

-- 5) Vista: Películas con sus actores listados
CREATE VIEW vista_peliculas_actores AS
SELECT 
    p.titulo AS pelicula,
    GROUP_CONCAT(a.nombre ORDER BY a.nombre SEPARATOR ', ') AS actores
FROM pelicula p
JOIN pelicula_actor pa ON p.id_pelicula = pa.id_pelicula
JOIN actor a ON pa.id_actor = a.id_actor
GROUP BY p.id_pelicula, p.titulo;

-- Función que devuelve la cantidad de películas de un género
DELIMITER //
CREATE FUNCTION cantidad_peliculas_genero(nombre_genero VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;
    SELECT COUNT(*)
    INTO cantidad
    FROM pelicula p
    JOIN genero g ON p.id_genero = g.id_genero
    WHERE g.nombre = nombre_genero;
    RETURN cantidad;
END //
DELIMITER ;

-- Función que devuelve el nombre del director de una película
DELIMITER //
CREATE FUNCTION director_de_pelicula(titulo_pelicula VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nombre_director VARCHAR(100);
    SELECT d.nombre
    INTO nombre_director
    FROM pelicula p
    JOIN director d ON p.id_director = d.id_director
    WHERE p.titulo = titulo_pelicula
    LIMIT 1;
    RETURN nombre_director;
END //
DELIMITER ;

-- Procedimiento para agregar una nueva película
DELIMITER //
CREATE PROCEDURE agregar_pelicula(
    IN p_titulo VARCHAR(100),
    IN p_anio INT,
    IN p_id_genero INT,
    IN p_id_director INT
)
BEGIN
    INSERT INTO pelicula (titulo, anio, id_genero, id_director)
    VALUES (p_titulo, p_anio, p_id_genero, p_id_director);
END //
DELIMITER ;

-- Procedimiento para obtener todas las películas de un actor
DELIMITER //
CREATE PROCEDURE peliculas_por_actor(
    IN p_nombre_actor VARCHAR(100)
)
BEGIN
    SELECT 
        a.nombre AS actor,
        p.titulo AS pelicula,
        p.anio
    FROM actor a
    JOIN pelicula_actor pa ON a.id_actor = pa.id_actor
    JOIN pelicula p ON pa.id_pelicula = p.id_pelicula
    WHERE a.nombre = p_nombre_actor;
END //
DELIMITER ;





