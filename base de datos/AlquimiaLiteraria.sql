CREATE DATABASE AlquimiaLiteraria;

USE AlquimiaLiteraria;

--No dependen de ninguno se ejecutan primero
CREATE TABLE Tipo_Identidad (
    id_tipo_identidad INT IDENTITY(1,1) PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL
);

CREATE TABLE Categoria (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

--Tablas con dependencias
CREATE TABLE Clientes (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    id_tipo_identidad INT NOT NULL,
    numero_documento VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_tipo_identidad) REFERENCES Tipo_Identidad(id_tipo_identidad)
);

CREATE TABLE Libros (
    id_libro INT IDENTITY(1,1) PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);
--Tablas que dependen de clientes y libros

CREATE TABLE Compras (
    id_compra INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_compra DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro)
);

CREATE TABLE Prestamos (
    id_prestamos INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro)
);

CREATE TABLE Referencias_Personales (
    id_referencias INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT NOT NULL,
    nombre_referencia VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

--Alterar las Tablas Primero: agregando nuevas columnas y restricciones

ALTER TABLE Libros
ADD precio INT NOT NULL CHECK (precio > 0),
    cantidad INT,
    estado_libro VARCHAR(30);

ALTER TABLE Clientes
ADD CONSTRAINT UQ_Clientes_numero_documento UNIQUE (numero_documento);

ALTER TABLE Compras
ADD CONSTRAINT CK_fecha_compra CHECK(fecha_compra <= GETDATE());

ALTER TABLE Compras
ADD CONSTRAINT UQ_Cliente_libro_fecha UNIQUE(id_cliente,id_libro,fecha_compra);

ALTER TABLE Compras
ADD metodo_pago VARCHAR(20) DEFAULT 'Efectivo';

ALTER TABLE Prestamos
ADD CONSTRAINT CK_fecha_prestamo CHECK(fecha_prestamo <= GETDATE());

ALTER TABLE Prestamos
ADD CONSTRAINT CK_fecha_devolucion CHECK(fecha_devolucion <= GETDATE());

ALTER TABLE Prestamos
ADD metodo_pago VARCHAR(20) DEFAULT 'Efectivo';

--INSERT DE LOS DATOS EN ORDEN LOGICO--
--1.--
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

--2.--
INSERT INTO Libros (titulo, autor, precio, cantidad, estado_libro, id_categoria)
VALUES
('El Senor de los Anillos', 'J.R.R. Tolkien', 80000, 5, 'Nuevo', 1),
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

--3.--

INSERT INTO Tipo_Identidad (nombre_tipo)
VALUES ('Cédula de Ciudadanía'), ('Tarjeta de Identidad'), ('Pasaporte');

--4.--
INSERT INTO Clientes (nombre, apellido, id_tipo_identidad, numero_documento)
VALUES
('Juan', 'Pérez', 1, '1001'),
('María', 'López', 2, '1002'),
('Carlos', 'Ramírez', 1, '1003'),
('Ana', 'González', 3, '1004'),
('Pedro', 'Martínez', 1, '1005'),
('Laura', 'Hernández', 2, '1006'),
('José', 'Santos', 3, '1007'),
('Elena', 'Castillo', 1, '1008'),
('Miguel', 'Torres', 2, '1009'),
('Sofía', 'Díaz', 3, '1010');

--5.--

INSERT INTO Compras (id_cliente, id_libro, fecha_compra)
VALUES
(1, 1, '2025-08-01'),
(2, 3, '2025-08-05'),
(1, 2, '2025-08-10'),
(3, 4, '2025-08-12'),
(4, 5, '2025-08-15'),
(2, 1, '2025-08-20'),
(5, 6, '2025-08-22'),
(3, 7, '2025-08-25'),
(1, 8, '2025-08-28'),
(4, 9, '2025-09-01');

--6.--
INSERT INTO Prestamos (id_cliente, id_libro, fecha_prestamo, fecha_devolucion, metodo_pago)
VALUES
(1, 3, '2025-07-10', '2025-07-20', 'Efectivo'),
(2, 5, '2025-07-12', '2025-07-25', 'Tarjeta'),
(3, 8, '2025-07-15', '2025-07-30', 'Transferencia'),
(4, 10, '2025-07-18', '2025-07-28', 'Efectivo'),
(5, 2, '2025-07-20', '2025-07-31', 'Tarjeta');