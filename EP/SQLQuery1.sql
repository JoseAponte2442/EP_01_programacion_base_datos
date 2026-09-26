-- ACTIVIDAD 1
--Creamos la base de datos
CREATE DATABASE AdministracionEP01;
GO
--La usamos
USE AdministracionEP01;
GO

-- Se procede a crear cada tabla a partir de los datos brindados en el caso:
--1. Tabla Clientes
-- De los clientes tenemos el ClienteId, el número de DNI, Nombre, Telefono
--El ClienteID lo elegimos como primary key y el identity para generar de forma automática e incremental un número único para cada nuevo registro que se inserta en la tabla.
--not null para dni porque necesitamos que siempre esté completo al igual que el Nombre y el telefono.
--Dni varchar 8 porque son 8 los caracteres máximos y en el telefono son 9. Ambos son únicos.
CREATE TABLE Clientes (
    ClienteID int identity primary key,
    DNI varchar(8) NOT NULL unique,
    NombreCompleto VARCHAR(100) NOT NULL,
    Telefono varchar(9) NOT NULL unique,
);
go
-- 2. Tabla Productos
-- De la tabla productos necesitamos productoID, Nombre del producto, Precio, stock.
--En este caso se emplea el Producto ID como primary key y el identity para generar de forma automática e incremental un número único para cada nuevo registro que se inserta en la tabla.
--not null para precio y nombre de producto.
-- en el caso del precio y el stock emplamos el check para impedir registrar o actualizar un producto con precio 0 o en el caso dwl o negativo.

    
CREATE TABLE Productos (
    ProductoID int identity primary key,
    NombreProducto varchar(50) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL CHECK (Precio > 0),
    Stock int NOT NULL DEFAULT 0 CHECK (Stock >= 0)
);

-- 3. Tabla Ventas 
-- -- De la tabla Ventas necesitamos VentaID y ClienteID.
-- En este caso se emplea VentaID como primary key y el identity para generar de forma automática e incremental un número único para cada nueva venta que se registra en el sistema.
-- not null en ClienteID, ya que toda venta debe estar asociada obligatoriamente a un cliente.
-- se emplea una Foreign Key para garantizar la integridad referencial, asegurando que solo se puedan registrar ventas asociadas a clientes que realmente existan en la tabla Clientes.
CREATE TABLE Ventas (
    VentaID int identity primary key,
    ClienteID int NOT NULL,
    CONSTRAINT FK_Ventas_Clientes FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- 4. Tabla DetalleVentas
-- De la tabla DetalleVentas necesitamos VentaID, ProductoID, Cantidad y PrecioUnitario
-- En este caso se emplea una Primary Key compuesta por dos columnas (VentaID, ProductoID) para garantizar que un mismo producto no se repita en los detalles de una misma venta, identificando de forma única cada línea del detalle.
-- not null en VentaID, ProductoID, Cantidad y PrecioUnitario para asegurar que ningún registro de detalle carezca de información esencial.
-- se emplea el CHECK (Cantidad > 0) para impedir registrar cantidades de productos en cero o negativas.
-- se emplean dos Foreign Keys (CONSTRAINT FK_Detalle_Ventas y CONSTRAINT FK_Detalle_Productos) para asegurar la integridad referencial, vinculando los registros estrictamente a ventas y productos existentes en sus respectivas tablas.
CREATE TABLE DetalleVentas (
    VentaID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_DetalleVentas PRIMARY KEY (VentaID, ProductoID),
    CONSTRAINT FK_Detalle_Ventas FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    CONSTRAINT FK_Detalle_Productos FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

--Insertar datos en clientes
INSERT INTO Clientes (DNI, NombreCompleto, Telefono) VALUES 
('72839102', 'Carlos Mendoza Silva', '987654321'),
('10482910', 'Ana María Torres Pérez', '912345678'),
('20593821', 'Luis Alberto Gómez Ruiz', '923456789'),
('30604932', 'Carla Pérez Rojas', '934567890'),
('40715043', 'Jorge Ramírez Sotomayor', '945678901'),
('50826154', 'María Elena Castillo', '956789012');
GO

-- Insertar datos en productos

INSERT INTO Productos (NombreProducto, Precio, Stock) VALUES 
('Monitor LED 24"', 180.00, 15),
('Teclado Mecánico RGB', 65.00, 30),
('Mouse Inalámbrico Ergonómico', 25.50, 50),
('Laptop Gamer 15.6"', 1250.00, 8),
('Impresora Multifuncional', 210.00, 12),
('Disco Sólido SSD 1TB', 95.00, 40),
('Memoria RAM 16GB DDR4', 55.00, 25),
('Silla Ergonómica de Oficina', 310.00, 5);
GO

-- Insertar datos en Ventas

INSERT INTO Ventas (ClienteID) VALUES 
(1), -- Venta del Cliente 1 (Carlos)
(2), -- Venta del Cliente 2 (Ana)
(1), -- Segunda venta del Cliente 1 (Carlos)
(3), -- Venta del Cliente 3 (Luis)
(4), -- Venta del Cliente 4 (Carla)
(5); -- Venta del Cliente 5 (Jorge)
GO

-- Insertar datos en DetalleVentas

INSERT INTO DetalleVentas (VentaID, ProductoID, Cantidad, PrecioUnitario) VALUES 
(1, 2, 1, 65.00),   -- Venta 1: 1 Teclado
(1, 3, 2, 25.50),   -- Venta 1: 2 Mousess
(2, 4, 1, 1250.00), -- Venta 2: 1 Laptop Gamer
(3, 5, 1, 210.00),  -- Venta 3: 1 Impresora
(3, 6, 2, 95.00),   -- Venta 3: 2 SSDs
(4, 7, 4, 55.00),   -- Venta 4: 4 Memorias RAM
(5, 8, 1, 310.00),  -- Venta 5: 1 Silla Ergonómica
(5, 3, 1, 25.50),   -- Venta 5: 1 Mouse
(6, 1, 2, 180.00);  -- Venta 6: 2 Monitores
GO

--Para validar que el motor de base de datos aplica correctamente las reglas definidas en el DDL, se diseñaron y ejecutaron las siguientes pruebas de fallo controlado:
-- Prueba A: Intento de registro con Precio no válido (Violación de CHECK)
-- Intento de inserción de producto con stock negativo
INSERT INTO Productos (NombreProducto, Precio, Stock) 
VALUES ('Teclado USB Genérico', 15.00,-10);
go
-- Prueba B: Intento de registro con Precio no válido (Violación de CHECK)
-- Intento de inserción de producto con precio en cero
INSERT INTO Productos (NombreProducto, Precio, Stock) 
VALUES ('Teclado USB Genérico', 0, 10);
go
-- Prueba C: Intento de registro duplicado (Violación de UNIQUE)
-- Intento de insertar dni igual
INSERT INTO Clientes (DNI, NombreCompleto, Telefono) VALUES 
('72839102', 'Juan Perez', '987652221');
go

-- Prueba D: Intento de insertar NombreCompleto NULO (Violación de NOT NULL)
INSERT INTO Clientes (DNI, NombreCompleto, Telefono) 
VALUES ('72839732', NULL, '987652221');
GO
-- ACTIVIDAD 2: CONSULTAS DE SELECCIÓN, FILTROS Y AGRUPACIÓN
-- CONSULTA 1: Filtros de texto y formato de datos
-- Requerimiento: Filtrar clientes cuyo nombre comience con las letras 'C' o 'M',
-- presentando su nombre en mayúsculas, la cantidad de caracteres de su nombre
-- y una máscara de seguridad para el teléfono dejando visibles solo los últimos 3 dígitos.

SELECT 
    ClienteID,
    DNI,
    UPPER(NombreCompleto) AS NombreMayusculas,
    LEN(NombreCompleto) AS CantidadCaracteres,
    CONCAT('**', RIGHT(Telefono, 3)) AS TelefonoProtegido
FROM Clientes
WHERE NombreCompleto LIKE 'C%' OR NombreCompleto LIKE 'M%'
ORDER BY NombreCompleto ASC;
GO
-- CONSULTA 2: Filtros de rango, listas y cálculo numérico
-- Requerimiento: Consultar productos que tengan un precio entre $50.00 y $300.00,
-- o bien que posean un stock específico de 5, 12 o 25 unidades. 
-- Incluye el cálculo del valor total en inventario (Precio * Stock) redondeado a 2 decimales.
SELECT 
    ProductoID,
    NombreProducto,
    Precio,
    Stock,
    ROUND(Precio * Stock, 2) AS ValorTotalInventario
FROM Productos
WHERE (Precio BETWEEN 50.00 AND 300.00)
   OR (Stock IN (5, 12, 25))
ORDER BY ValorTotalInventario DESC;
GO
-- CONSULTA 3: Agrupación, funciones de agregación y filtro HAVING
-- Requerimiento: Agrupar los detalles de cada venta (DetalleVentas) por VentaID,
-- calculando el total de productos vendidos, el importe total de la venta,
-- el precio promedio por ítem, y mostrando únicamente las ventas cuyo total supere los $200.00.
SELECT 
    VentaID,
    SUM(Cantidad) AS TotalUnidadesVendidas,
    SUM(Cantidad * PrecioUnitario) AS ImporteTotalVenta,
    ROUND(AVG(PrecioUnitario), 2) AS PrecioPromedioItem,
    MIN(PrecioUnitario) AS ItemMasBarato,
    MAX(PrecioUnitario) AS ItemMasCaro
FROM DetalleVentas
GROUP BY VentaID
HAVING SUM(Cantidad * PrecioUnitario) > 200.00
ORDER BY ImporteTotalVenta DESC;
GO
-- ACTIVIDAD 3: CONSULTAS MULTITABLA
-- CONSULTA 1: INNER JOIN con CASE para clasificar el nivel de las ventas
-- Se unen 4 tablas para ver qué compró cada cliente y clasificar el gasto.

SELECT Cli.NombreCompleto, Prod.NombreProducto, Det.Cantidad, (Det.Cantidad * Det.PrecioUnitario) as MontoSubtotal,
    CASE 
        WHEN (Det.Cantidad * Det.PrecioUnitario) >= 1000.00 THEN 'Compra Fuerte'
        WHEN (Det.Cantidad * Det.PrecioUnitario) BETWEEN 200.00 AND 999.99 THEN 'Compra Promedio'
        ELSE 'Compra Básica'
    END as NivelDeVenta
FROM Ventas Ven
INNER JOIN Clientes Cli ON Ven.ClienteID = Cli.ClienteID
INNER JOIN DetalleVentas Det ON Ven.VentaID = Det.VentaID
INNER JOIN Productos Prod ON Det.ProductoID = Prod.ProductoID
ORDER BY MontoSubtotal DESC;
GO


-- CONSULTA 2: LEFT JOIN para buscar clientes que aún no compran
-- Utilizamos OUTER JOIN para no perder de la lista a los clientes inactivos.

SELECT Cli.ClienteID, Cli.NombreCompleto, Ven.VentaID,
    CASE 
        WHEN Ven.VentaID IS NULL THEN 'Falta concretar venta'
        ELSE 'Cliente con registro de venta'
    END as CondicionCliente
FROM Clientes Cli
LEFT OUTER JOIN Ventas Ven ON Cli.ClienteID = Ven.ClienteID
ORDER BY Ven.VentaID ASC;
GO


-- CONSULTA 3: SELECT INTO para generar una tabla de mejores clientes
-- Se filtran los que gastaron más de 500 y se guardan en una tabla nueva.

SELECT Cli.DNI, Cli.NombreCompleto, Cli.Telefono, SUM(Det.Cantidad * Det.PrecioUnitario) as GastoAcumulado
INTO ClientesVip
FROM Clientes Cli
INNER JOIN Ventas Ven ON Cli.ClienteID = Ven.ClienteID
INNER JOIN DetalleVentas Det ON Ven.VentaID = Det.VentaID
GROUP BY Cli.DNI, Cli.NombreCompleto, Cli.Telefono
HAVING SUM(Det.Cantidad * Det.PrecioUnitario) > 500.00;
GO

-- Verificamos que la tabla se haya creado correctamente con sus datos
SELECT * FROM ClientesVip;
GO

-- ACTIVIDAD 4: Subconsultas y Contraste de Alternativas
-- Caso de Uso: Clientes con compras de productos en Stock Crítico (< 15)
-- OPCIÓN A: Utilizando Subconsulta con IN
-- Propósito: Obtener el listado de clientes cuyo ClienteID pertenezca al conjunto de IDs obtenido mediante una subconsulta que filtra productos con poco stock.
SELECT 
    c.ClienteID,
    c.DNI,
    c.NombreCompleto,
    c.Telefono
FROM 
    Clientes c
WHERE 
    c.ClienteID IN (
        SELECT v.ClienteID
        FROM Ventas v
        INNER JOIN DetalleVentas dv ON v.VentaID = dv.VentaID
        INNER JOIN Productos p ON dv.ProductoID = p.ProductoID
        WHERE p.Stock < 15
    );
GO
-- OPCIÓN B: Utilizando Subconsulta Correlacionada con EXISTS
-- Propósito: Obtener el mismo listado evaluando la existencia de al menos
-- una venta ligada al cliente que contenga un producto con stock crítico.

SELECT 
    c.ClienteID,
    c.DNI,
    c.NombreCompleto,
    c.Telefono
FROM 
    Clientes c
WHERE 
    EXISTS (
        SELECT 1
        FROM Ventas v
        INNER JOIN DetalleVentas dv ON v.VentaID = dv.VentaID
        INNER JOIN Productos p ON dv.ProductoID = p.ProductoID
        WHERE v.ClienteID = c.ClienteID
          AND p.Stock < 15
    );
GO
