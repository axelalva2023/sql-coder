
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



