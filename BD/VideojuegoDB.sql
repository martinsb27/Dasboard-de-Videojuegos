/* Creo la Base de datos*/
CREATE DATABASE VideojuegoDB;
GO
Use VideojuegoDB
GO
/*CREAR TABLA: JUGADORES*/
CREATE TABLE Jugadores (
    id_jugador INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    nivel INT CHECK (nivel >= 1),
    fecha_registro DATE DEFAULT GETDATE()
);
GO
/*CREAR TABLA: PARTIDAS*/
CREATE TABLE Partidas (
    id_partida INT PRIMARY KEY IDENTITY(1,1),
    id_jugador INT NOT NULL,
    puntuacion INT CHECK (puntuacion >= 0),
    duracion_min INT CHECK (duracion_min > 0),
    fecha DATE DEFAULT GETDATE(),
    FOREIGN KEY (id_jugador) REFERENCES Jugadores(id_jugador)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO
/*INSERTAR DATOS EN JUGADORES*/
INSERT INTO Jugadores (nombre, pais, nivel, fecha_registro) VALUES
('Sergio', 'Perú', 3, '2025-01-10'),
('Lucía', 'México', 5, '2025-02-14'),
('Diego', 'Chile', 2, '2025-03-20'),
('Camila', 'Argentina', 4, '2025-04-01'),
('Andrés', 'Colombia', 1, '2025-05-05');
GO
/*INSERTAR DATOS EN PARTIDAS*/
INSERT INTO Partidas (id_jugador, puntuacion, duracion_min, fecha) VALUES
(1, 1200, 25, '2025-05-10'),
(1, 1800, 40, '2025-05-15'),
(2, 1500, 30, '2025-05-11'),
(2, 2200, 45, '2025-05-20'),
(3, 900, 20, '2025-06-01'),
(4, 2100, 35, '2025-06-03'),
(5, 800, 15, '2025-06-10'),
(5, 1100, 18, '2025-06-15');
GO
/*MOSTRAR DATOS DE LAS TABLAS*/
SELECT * FROM Jugadores;
SELECT * FROM Partidas;
/*Promedio de puntuación por jugador*/
SELECT 
    j.nombre AS Jugador,
    j.pais AS País,
    AVG(p.puntuacion) AS Promedio_Puntuacion
FROM Jugadores j
JOIN Partidas p ON j.id_jugador = p.id_jugador
GROUP BY j.nombre, j.pais
ORDER BY Promedio_Puntuacion DESC;
/*Total de partidas por país*/
SELECT 
    j.pais AS País,
    COUNT(p.id_partida) AS Total_Partidas
FROM Jugadores j
JOIN Partidas p ON j.id_jugador = p.id_jugador
GROUP BY j.pais
ORDER BY Total_Partidas DESC;
/*Duración promedio de partidas por nivel*/
SELECT 
    j.nivel AS Nivel,
    ROUND(AVG(p.duracion_min), 2) AS Duracion_Promedio
FROM Jugadores j
JOIN Partidas p ON j.id_jugador = p.id_jugador
GROUP BY j.nivel
ORDER BY j.nivel;
/*Top 3 jugadores con más puntuación total*/
SELECT TOP 3
    j.nombre AS Jugador,
    SUM(p.puntuacion) AS Puntuacion_Total
FROM Jugadores j
JOIN Partidas p ON j.id_jugador = p.id_jugador
GROUP BY j.nombre
ORDER BY Puntuacion_Total DESC;
/* Evolución de puntuaciones en el tiempo*/
SELECT 
    j.nombre AS Jugador,
    p.fecha AS Fecha,
    p.puntuacion AS Puntuacion
FROM Jugadores j
JOIN Partidas p ON j.id_jugador = p.id_jugador
ORDER BY p.fecha ASC;





