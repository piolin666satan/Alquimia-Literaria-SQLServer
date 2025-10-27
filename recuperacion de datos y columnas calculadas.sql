USE AlquimiaLiteraria

-- CONSULTAS DE RECUPERACIÓN DE DATOS Y COLUMNAS CALCULADAS

-- 1️⃣ Recuperar todos los libros con su categoría
SELECT 
    L.titulo AS Título,
    L.autor AS Autor,
    C.nombre_categoria AS Categoría,
    L.precio AS Precio
FROM Libros L
JOIN Categoria C ON L.id_categoria = C.id_categoria;

-- 2️⃣ Mostrar las compras con nombre completo del cliente y el total pagado (columna calculada)
SELECT 
    CO.id_compra AS ID_Compra,
    CL.nombre + ' ' + CL.apellido AS Cliente,
    L.titulo AS Libro,
    L.precio AS Precio_Unitario,
    L.cantidad AS Stock,
    L.precio * 1 AS Total_Pagado  -- columna calculada
FROM Compras CO
JOIN Clientes CL ON CO.id_cliente = CL.id_cliente
JOIN Libros L ON CO.id_libro = L.id_libro;

-- 3️⃣ Mostrar préstamos con días transcurridos (columna calculada)
SELECT 
    P.id_prestamos AS ID_Prestamo,
    CL.nombre + ' ' + CL.apellido AS Cliente,
    L.titulo AS Libro,
    DATEDIFF(DAY, P.fecha_prestamo, P.fecha_devolucion) AS Dias_Prestamo, -- columna calculada
    P.metodo_pago AS Metodo_Pago
FROM Prestamos P
JOIN Clientes CL ON P.id_cliente = CL.id_cliente
JOIN Libros L ON P.id_libro = L.id_libro;