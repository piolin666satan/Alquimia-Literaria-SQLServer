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
