-- IMPLEMENTACIÓN DE PROCEDIMIENTOS ALMACENADOS --

USE Alquimia_Literaria;
GO
  
--Santiago Torres
-- PROCEDIMIENTO 1: Insertar tipo de identidad
CREATE PROCEDURE sp_InsertarTipoIdentidad
    @nombre_tipo VARCHAR(50)
AS
BEGIN
    INSERT INTO Tipo_Identidad (nombre_tipo)
    VALUES (@nombre_tipo);
END;
GO

-- PROCEDIMIENTO 2: Insertar referencia personal asociada a cliente
CREATE PROCEDURE sp_InsertarReferenciaCliente
    @nombre_referencia VARCHAR(100),
    @telefono VARCHAR(20),
    @id_cliente INT
AS
BEGIN
    INSERT INTO Referencias_Personales (nombre_referencia, telefono, id_cliente)
    VALUES (@nombre_referencia, @telefono, @id_cliente);
END;
GO
  
-- Santiago Sanchez Rojas
-- PROCEDIMIENTO 3: Crear una nueva compra
CREATE PROCEDURE InsertarCompra
    @id_cliente INT,
    @id_libro INT,
    @fecha_compra DATE
AS
BEGIN
    INSERT INTO Compras (id_cliente, id_libro, fecha_compra)
    VALUES (@id_cliente, @id_libro, @fecha_compra);
END;
GO

-- PROCEDIMIENTO 4 (de Josué): Obtener libros por precio
CREATE PROCEDURE ObtenerLibrosPorPrecio
    @precio INT
AS
BEGIN
    SELECT titulo, precio
    FROM Libros
    WHERE precio = @precio;
END;
GO

-- Ahora sí, ejecutas las pruebas

EXEC sp_InsertarTipoIdentidad 'Licencia de Conducción';
EXEC sp_InsertarReferenciaCliente 'María Gómez', '3214567890', 1;
EXEC InsertarCompra 1, 3, '2025-10-27';
EXEC ObtenerLibrosPorPrecio @precio = 50000;

-- Consulta de validación
SELECT * FROM Compras;
