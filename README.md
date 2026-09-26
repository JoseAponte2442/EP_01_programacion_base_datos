# EP_01_programacion_base_datos
Repositorio que contiene un script completo en SQL Server (T-SQL) para la creación, población, validación y consulta de una base de datos orientada a la administración de un sistema de clientes, productos y ventas.

📋 Estructura del Proyecto
El script se divide en 4 actividades principales:

Actividad 1 (DDL & DML): Creación de la base de datos, definición de restricciones (Constraints, Primary Keys, Foreign Keys, Check, Unique), inserción de datos de prueba y pruebas de fallo controlado.

Actividad 2 (Consultas y Filtros): Consultas de selección con formato de texto, rangos, cálculos numéricos, agregación y filtros avanzados mediante HAVING.

Actividad 3 (Consultas Multitabla): Uso de INNER JOIN, LEFT JOIN con condicionales CASE y creación dinámica de tablas de respaldo (SELECT INTO).

Actividad 4 (Subconsultas): Comparativa de rendimiento y alternativas lógicas utilizando operadores de conjuntos (IN) frente a subconsultas correlacionadas (EXISTS).

🗄️ Modelo de Datos y Restricciones
Actividad 1: 



La base de datos AdministracionEP01 consta de 4 tablas relacionadas:

Clientes: Almacena la información de los compradores. Contiene restricciones de unicidad (UNIQUE) en DNI y Telefono, además de validación de campos obligatorios (NOT NULL).

Productos: Catálogo de artículos disponibles. Cuenta con validaciones estrictas para impedir precios negativos o en cero (CHECK (Precio > 0)) y control de stock mínimo (DEFAULT 0, CHECK (Stock >= 0)).

Ventas: Cabecera de las transacciones comerciales asociadas obligatoriamente a un cliente mediante una llave foránea (FK).

DetalleVentas: Detalle línea por línea de cada venta. Utiliza una Primary Key compuesta (VentaID, ProductoID) y validaciones para asegurar que no existan cantidades negativas.


🔍 Resumen de Consultas Incluidas

🔹 Actividad 2: Filtros y Agrupación
Filtros de texto y máscara: Selección de clientes que inician con 'C' o 'M', convirtiendo nombres a mayúsculas, calculando la longitud del texto y enmascarando teléfonos (mostrando solo los últimos 3 dígitos).

Rangos y cálculos: Productos con precios entre $50.00 y $300.00 o stocks específicos (5, 12, 25), calculando el valor total del inventario.

Agrupación con HAVING: Resumen de ventas por VentaID (unidades vendidas, importe total, precio promedio, mínimos y máximos) filtrando únicamente aquellas que superen los $200.00.


🔹 Actividad 3: Consultas Multitabla y Reportes
Clasificación con INNER JOIN y CASE: Cruce de 4 tablas para etiquetar el nivel de compra de cada cliente (Compra Fuerte, Compra Promedio, Compra Básica).

Auditoría con LEFT JOIN: Identificación de clientes inactivos que aún no han concretado ninguna compra.

Persistencia de datos (SELECT INTO): Generación automática de una tabla analítica permanente llamada ClientesVip que almacena únicamente a los clientes con un gasto acumulado superior a $500.00.


🔹 Actividad 4: Optimización con Subconsultas
Se implementan dos enfoques lógicos para identificar clientes que han comprado productos con Stock Crítico (< 15 unidades):

Opción A (Operador IN): Filtra los identificadores de clientes pertenecientes al conjunto devuelto por la subconsulta independiente.

Opción B (Subconsulta Correlacionada con EXISTS): Evalúa de manera más eficiente la existencia de registros relacionados por cada fila evaluada en la tabla principal.

🛠️ Tecnologías Utilizadas
Microsoft SQL Server (T-SQL)

DDL / DML

Restricciones de Integridad Referencial

Desarrollado como parte de las prácticas y evaluaciones de administración y diseño de bases de datos.
