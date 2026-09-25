CREATE DATABASE AdministracionEP01;
GO

USE AdministracionEP01;
GO

-- Se procede a crear cada tabla a partir de los datos brindados en el caso:
--1. Tabla Clientes
-- De los clientes tenemos el ClienteId, el número de DNI, Nombre, Telefono
--not null para dni porque necesitamos que siempre esté completo
CREATE TABLE Clientes (
    ClienteID int identity primary key,
    DNI varchar(8) NOT NULL unique,
    NombreCompleto VARCHAR(100) NOT NULL,
    Telefono varchar(9) NOT NULL unique,
);
go
-- 2. Tabla Productos
-- De la tabla productos necesitamos producto
CREATE TABLE Productos (
    ProductoID int identity primary key,
    NombreProducto varchar(50) NOT NULL,
    Precio decimal(10,2) NOT NULL CHECK (Precio > 0),
    Stock int NOT NULL DEFAULT 0 CHECK (Stock >= 0)
);

-- 3. Tabla Ventas 
-- Cantidad de datos 

CREATE TABLE Ventas (
    VentaID int identity primary key,
    ClienteID int NOT NULL,
    CONSTRAINT FK_Ventas_Clientes FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- 4. Tabla DetalleVentas
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
