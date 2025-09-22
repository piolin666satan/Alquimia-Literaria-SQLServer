CREATE DATABASE AlquimiaLiteraria;

USE AlquimiaLiteraria;

CREATE TABLE Tipo_Identidad (
    id_tipo_identidad INT PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL
);


CREATE TABLE Categoria (
    id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);


CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    id_tipo_identidad INT NOT NULL,
    numero_documento VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_tipo_identidad) REFERENCES Tipo_Identidad(id_tipo_identidad)
);


CREATE TABLE Libros (
    id_libro INT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);


CREATE TABLE Compras (
    id_compra INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_compra DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro)
);


CREATE TABLE Prestamos (
id_prestamos INT PRIMARY KEY,
id_cliente INT NOT NULL,
id_libro INT NOT NULL,
fecha_prestamo DATE NOT NULL,
fecha_devolucion DATE NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
FOREIGN KEY (id_libro) REFERENCES Libros(id_libro)
);

CREATE TABLE Referencias_Personales (
id_referencias INT PRIMARY KEY,
id_cliente INT NOT NULL,
nombre_referencia VARCHAR(100) NOT NULL,
telefono VARCHAR(20) NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

--===============CAMBIOS JOSUE=========---
 ---=====LIBROS=====---
--==== Ajustar tabla Categoria====---
ALTER TABLE Categoria
DROP COLUMN id_categoria;

ALTER TABLE Categoria
ADD id_categoria INT IDENTITY(1,1) PRIMARY KEY;

--=== Ajustar tabla Libros====---
ALTER TABLE Libros
DROP COLUMN id_libro;

ALTER TABLE Libros
ADD id_libro INT IDENTITY(1,1) PRIMARY KEY,
    precio INT NOT NULL CHECK (precio > 0),
    cantidad INT,
    estado_libro VARCHAR(30);

--===== Insertar categor as===---
INSERT INTO Categoria (nombre_categoria)
VALUES
('Fantas a'),
('Programaci n'),
('Historia'),
('Terror'),
('Ciencia ficci n'),
('Psicolog a'),
('Romance'),
('Aventura'),
('Misterio/Suspenso'),
('Comedia'),
('Novela hist rica'),
('Ficci n er tica'),
('Distop a'),
('Drama');

INSERT INTO Libros (titulo, autor, precio, cantidad, estado_libro, id_categoria)
VALUES
('El Se or de los Anillos', 'J.R.R. Tolkien', 80000, 5, 'Nuevo', 1),
('Harry Potter y el Prisionero de Azkaban', 'J.K. Rowling', 50000, 7, 'Nuevo', 1),
('Clean Code', 'Robert C. Martin', 90000, 10, 'Nuevo', 2),
('Eloquent JavaScript', 'Marijn Haverbeke', 60000, 8, 'Usado', 2),
('Historia de Roma', 'Mary Beard', 70000, 3, 'Nuevo', 3),
('La Segunda Guerra Mundial', 'Antony Beevor', 95000, 4, 'Usado', 3),
('It', 'Stephen King', 65000, 6, 'Nuevo', 4),
('El Resplandor', 'Stephen King', 60000, 5, 'Usado', 4),
('Dune', 'Frank Herbert', 85000, 6, 'Nuevo', 5),
('Fundaci n', 'Isaac Asimov', 78000, 5, 'Nuevo', 5),
('El hombre en busca de sentido', 'Viktor Frankl', 55000, 10, 'Nuevo', 6),
('Pensar r pido, pensar despacio', 'Daniel Kahneman', 68000, 4, 'Usado', 6),
('Orgullo y Prejuicio', 'Jane Austen', 50000, 7, 'Nuevo', 7),
('Bajo la misma estrella', 'John Green', 45000, 6, 'Nuevo', 7),
('La Isla del Tesoro', 'Robert Louis Stevenson', 52000, 5, 'Nuevo', 8),
('Viaje al centro de la Tierra', 'Julio Verne', 56000, 4, 'Usado', 8),
('El C digo Da Vinci', 'Dan Brown', 60000, 10, 'Nuevo', 9),
('Sherlock Holmes: Estudio en Escarlata', 'Arthur Conan Doyle', 48000, 6, 'Nuevo', 9),
('Sin noticias de Gurb', 'Eduardo Mendoza', 40000, 8, 'Nuevo', 10),
('Good Omens', 'Neil Gaiman y Terry Pratchett', 65000, 5, 'Nuevo', 10),
('Los Pilares de la Tierra', 'Ken Follett', 78000, 6, 'Nuevo', 11),
('La Catedral del Mar', 'Ildefonso Falcones', 72000, 4, 'Usado', 11),
('50 Sombras de Grey', 'E.L. James', 50000, 8, 'Nuevo', 12),
('Delta de Venus', 'Ana s Nin', 62000, 3, 'Usado', 12),
('1984', 'George Orwell', 55000, 12, 'Nuevo', 13),
('Un Mundo Feliz', 'Aldous Huxley', 53000, 10, 'Nuevo', 13),
('Cien a os de soledad', 'Gabriel Garc a M rquez', 85000, 6, 'Nuevo', 14),
('La Casa de los Esp ritus', 'Isabel Allende', 70000, 4, 'Usado', 14);

SELECT L.titulo, L.autor, L.precio, L.estado_libro, C.nombre_categoria
FROM Libros L
INNER JOIN Categoria C
    ON L.id_categoria = C.id_categoria;

--Sebastian-herrera
ALTER TABLE Clientes
ADD CONSTRAINT UQ_Clientes_numero_documento UNIQUE (numero_documento);

INSERT INTO Clientes (id_cliente, nombre, apellido, numero_documento)
VALUES
(1, 'Juan', 'Pérez', '1001'),
(2, 'María', 'López', '1002'),
(3, 'Carlos', 'Ramírez', '1003'),
(4, 'Ana', 'González', '1004'),
(5, 'Pedro', 'Martínez', '1005'),
(6, 'Laura', 'Hernández', '1006'),
(7, 'José', 'Santos', '1007'),
(8, 'Elena', 'Castillo', '1008'),
(9, 'Miguel', 'Torres', '1009'),
(10, 'Sofía', 'Díaz', '1010');

UPDATE Clientes
SET apellido = 'Rodríguez'
WHERE id_cliente = 1;

SELECT 
    c.id_cliente,
    c.nombre + ' ' + c.apellido AS cliente,
    l.titulo AS libro,
    comp.fecha_compra
FROM Clientes c
INNER JOIN Compras comp 
    ON c.id_cliente = comp.id_cliente
INNER JOIN Libros l 
    ON comp.id_libro = l.id_libro;
--=======

--==========CAMBIOS SANTIAGO SANCHEZ ROJAS==============-----
--==========COMPRAS Y PRESTAMOS=========================-----
ALTER TABLE Compras
ADD CONSTRAINT CK_fecha_compra CHECK(fecha_compra <= GETDATE());

ALTER TABLE Compras
ADD CONSTRAINT UQ_Cliente_libro_fecha UNIQUE(id_cliente,id_libro,fecha_compra);

--Agrego los datos--
INSERT INTO Compras (id_compra, id_cliente, id_libro, fecha_compra) VALUES
(1, 1, 1, '2025-08-01'),
(2, 2, 3, '2025-08-05'),
(3, 1, 2, '2025-08-10'),
(4, 3, 4, '2025-08-12'),
(5, 4, 5, '2025-08-15'),
(6, 2, 1, '2025-08-20'),
(7, 5, 6, '2025-08-22'),
(8, 3, 7, '2025-08-25'),
(9, 1, 8, '2025-08-28'),
(10, 4, 9, '2025-09-01');

--ALTER TABLES--
ALTER TABLE Compras
ADD metodo_pago VARCHAR(20) DEFAULT 'Efectivo'

UPDATE Compras
SET id_libro = 5
WHERE id_compra = 2;

--INNER JOIN--
SELECT c.nombre, c.apellido, l.titulo, comp.fecha_compra
FROM Clientes c
INNER JOIN Compras comp ON c.id_cliente = comp.id_cliente
INNER JOIN Libros l ON comp.id_libro = l.id_libro;

--PRESTAMOS--
ALTER TABLE Prestamos
ADD CONSTRAINT CK_fecha_prestamo CHECK(fecha_prestamo <= GETDATE());

ALTER TABLE Prestamos
ADD CONSTRAINT CK_fecha_devolucion CHECK(fecha_devolucion <= GETDATE());

INSERT INTO Prestamos (id_prestamos, id_cliente, id_libro, fecha_prestamo, fecha_devolucion) VALUES
(1, 1, 3, '2025-08-01', '2025-08-15'),
(2, 2, 5, '2025-08-05', '2025-08-19'),
(3, 3, 1, '2025-08-08', '2025-08-22'),
(4, 1, 2, '2025-08-10', '2025-08-24'),
(5, 4, 4, '2025-08-12', '2025-08-26'),
(6, 5, 6, '2025-08-15', '2025-08-29'),
(7, 2, 7, '2025-08-18', '2025-09-01'),
(8, 3, 8, '2025-08-20', '2025-09-03'),
(9, 4, 9, '2025-08-22', '2025-09-05'),
(10, 5, 10, '2025-08-25', '2025-09-08');

ALTER TABLE Prestamos
ADD metodo_pago VARCHAR(20) DEFAULT 'Efectivo'

SELECT c.nombre, c.apellido, p.fecha_prestamo, p.fecha_devolucion
FROM Clientes c
INNER JOIN Prestamos p ON c.id_cliente = p.id_cliente;
