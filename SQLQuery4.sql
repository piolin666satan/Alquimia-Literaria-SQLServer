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
