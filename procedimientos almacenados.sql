--Implementacion de Procedimientos almacenados--

USE AlquimiaLiteraria

--CREA UNA NUEVA COMPRA--

CREATE PROCEDURE InsertarCompra
@id_cliente INT,
@id_libro INT,
@fecha_compra DATE

AS
BEGIN
INSERT INTO Compras (id_cliente,id_libro,fecha_compra)
VALUES(@id_cliente,@id_libro,@fecha_compra);
END;

EXEC InsertarCompra 1, 3, '2025-10-27';

SELECT * FROM Compras;
