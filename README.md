# EP_01_programacion_base_datos

Repositorio que contiene un script completo en SQL Server. Creación, población, validación y consulta de una base de datos orientada a la administración de un sistema de clientes, productos y ventas basado en nuestro EP01.

## Integrantes del equipo

| N° | Nombre completo                      | Correo institucional  | Aporte |
|----|--------------------------------------|-----------------------|--------|
| 1  | Imanol Ponce de León                 | 76221830@mail.isil.pe |  100%  |
| 2  | Jose Manuel Aponte Tanta             | 75619512@mail.isil.pe |  100%  |
| 3  | Andrés Francisco Pimentel Saldaña    | 73213777@mail.isil.pe |  100%  |
| 4  | Jhonn Paul Ccasani Enciso            | 44061898@mail.isil.pe |  100%  |


## 📹Link youtube :

📋 Estructura del Proyecto
El script se divide en 4 actividades principales:

Actividad 1 (DDL & DML): Creación de la base de datos, definición de restricciones (Constraints, Primary Keys, Foreign Keys, Check, Unique), inserción de datos de prueba y pruebas de fallo controlado.

Actividad 2 (Consultas y Filtros): Consultas de selección con formato de texto, rangos, cálculos numéricos, agregación y filtros avanzados mediante HAVING.

Actividad 3 (Consultas Multitabla): Uso de INNER JOIN, LEFT JOIN con condicionales CASE y creación dinámica de tablas de respaldo (SELECT INTO).

Actividad 4 (Subconsultas): Comparativa de rendimiento y alternativas lógicas utilizando operadores de conjuntos (IN) frente a subconsultas correlacionadas (EXISTS).

🗄️ Modelo de Datos y Restricciones
Actividad 1:  

## 📋 Estructura de Tablas

<img width="593" height="718" alt="image" src="https://github.com/user-attachments/assets/77c26439-e098-42bc-a84d-91abb918fb15" />

### 1. Tabla `CLIENTES` 🟣
* **Propósito:** Almacena la información de los compradores o clientes registrados en el sistema.
* **Campos:**
  * `ClienteID` (`int`, **PK**): Identificador único de cada cliente (Clave Primaria).
  * `DNI` (`varchar`): Documento de identidad del cliente.
  * `NombreCompleto` (`varchar`): Nombre y apellidos del cliente.
  * `Telefono` (`varchar`): Número de contacto del cliente.
* **Relación:** Un cliente puede realizar **muchas** ventas (relación de 1 a muchos: de `CLIENTES` a `VENTAS`).

---

### 2. Tabla `VENTAS` 🟢
* **Propósito:** Registra las cabeceras o transacciones de venta realizadas por los clientes.
* **Campos:**
  * `VentaID` (`int`, **PK**): Identificador único de cada venta.
  * `ClienteID` (`int`, **FK**): Clave foránea que referencia al cliente que realizó la compra.
* **Relación:** 
  * Pertenece a un solo cliente.
  * Contiene **muchos** detalles de venta (relación de 1 a muchos hacia `DETALLE_VENTAS`).

---

### 3. Tabla `PRODUCTOS` 🔵
* **Propósito:** Almacena el catálogo de productos disponibles para la venta.
* **Campos:**
  * `ProductoID` (`int`, **PK**): Identificador único del producto.
  * `NombreProducto` (`varchar`): Nombre o descripción comercial del producto.
  * `Precio` (`decimal`): Precio unitario actual del producto.
  * `Stock` (`int`): Cantidad disponible en inventario.
* **Relación:** Un producto puede incluirse en **muchos** detalles de venta a lo largo del tiempo (relación de 1 a muchos hacia `DETALLE_VENTAS`).

---

### 4. Tabla `DETALLE_VENTAS` 🟠
* **Propósito:** Tabla intermedia o de asociación que resuelve la relación de **Muchos a Muchos** entre `VENTAS` y `PRODUCTOS`. Especifica exactamente qué productos y qué cantidades componen cada venta.
* **Campos:**
  * `VentaID` (`int`, **PK, FK**): Parte de la clave primaria compuesta y referencia a la tabla Ventas.
  * `ProductoID` (`int`, **PK, FK**): Parte de la clave primaria compuesta y referencia a la tabla Productos.
  * `Cantidad` (`int`): Unidades compradas de ese producto específico en esa venta.
  * `PrecioUnitario` (`decimal`): Precio que tenía el producto al momento de la transacción.
* **Relación:** Vincula una venta específica con uno o varios productos mediante una clave primaria compuesta (`VentaID` + `ProductoID`), evitando duplicidades de un mismo producto en una misma venta.


creación de la base de datos.

<img width="1193" height="466" alt="image" src="https://github.com/user-attachments/assets/63fc7a13-e731-4272-8d49-fb5fecb598d8" />


La base de datos AdministracionEP01 consta de 4 tablas relacionadas:

1. Clientes: Almacena la información de los compradores. Contiene restricciones de unicidad (UNIQUE) en DNI y Telefono, además de validación de campos obligatorios (NOT NULL).

2. Productos: Catálogo de artículos disponibles. Cuenta con validaciones estrictas para impedir precios negativos o en cero (CHECK (Precio > 0)) y control de stock mínimo (DEFAULT 0, CHECK (Stock >= 0)).
  
   <img width="1027" height="387" alt="image" src="https://github.com/user-attachments/assets/b8545396-3168-4a96-9b4c-a87892225447" />



3. Ventas: Cabecera de las transacciones comerciales asociadas obligatoriamente a un cliente mediante una llave foránea (FK).

4. DetalleVentas: Detalle línea por línea de cada venta. Utiliza una Primary Key compuesta (VentaID, ProductoID) y validaciones para asegurar que no existan cantidades negativas.
  
   <img width="1253" height="570" alt="image" src="https://github.com/user-attachments/assets/2a4afb7e-d654-4ccf-bbfb-856d73d21f26" />

Esta es la relación de las tablas:

📄Rellenamos las tablas con datos:
Tabla Clientes y Productos:

<img width="745" height="560" alt="image" src="https://github.com/user-attachments/assets/7fbc4700-3046-4d2e-b0dc-9654d9ff6e9a" />

Tabla Ventas y DetalleVentas:

<img width="711" height="540" alt="image" src="https://github.com/user-attachments/assets/99a5c117-6a79-4c9d-81aa-7dc8610591cc" />

❌Validación de datos y que se está aplicando correctamente las reglas definidas:
1. Prueba A: Intento de registro con Precio no válido (Violación de CHECK)
2. Prueba B: Intento de registro con producto no válido (Violación de CHECK)
3. Prueba C: Intento de registro duplicado (Violación de UNIQUE)
4. Prueba D: Intento de insertar NombreCompleto NULO (Violación de NOT NULL)

<img width="1512" height="751" alt="image" src="https://github.com/user-attachments/assets/84d8e268-5b5c-4243-944b-c9b60dcb635b" />


🔎 Resumen de Consultas Incluidas

🔹 Actividad 2: Filtros y Agrupación
-Consulta 1: Filtros de texto y máscara. Selección de clientes que inician con 'C' o 'M', convirtiendo nombres a mayúsculas, calculando la longitud del texto y enmascarando teléfonos (mostrando solo los últimos 3 dígitos).
<img width="1005" height="629" alt="image" src="https://github.com/user-attachments/assets/25066d3f-77af-43f4-8281-62afb36bad44" />

-Consulta 2: Rangos y cálculos. Productos con precios entre $50.00 y $300.00 o stocks específicos (5, 12, 25), calculando el valor total del inventario.
<img width="955" height="621" alt="image" src="https://github.com/user-attachments/assets/78cfb901-1520-4333-a7a0-f2e98e2ffca0" />

-Consulta 3: Agrupación con HAVING. Resumen de ventas por VentaID (unidades vendidas, importe total, precio promedio, mínimos y máximos) filtrando únicamente aquellas que superen los $200.00.
<img width="946" height="602" alt="image" src="https://github.com/user-attachments/assets/50d45010-817a-4359-98d8-d6a3447f9412" />

🔹 Actividad 3: Consultas Multitabla y Reportes
-Consulta 1: Clasificación con INNER JOIN y CASE. Cruce de 4 tablas para etiquetar el nivel de compra de cada cliente (Compra Fuerte, Compra Promedio, Compra Básica).
<img width="1144" height="619" alt="image" src="https://github.com/user-attachments/assets/918c2d6b-a1ac-4575-bb5d-2f5e887caeee" />

-Consulta 2:  Auditoría con LEFT JOIN. Identificación de clientes inactivos que aún no han concretado ninguna compra.
<img width="927" height="587" alt="image" src="https://github.com/user-attachments/assets/3197c01c-623b-4fae-ac32-9ca921bafa09" />

-Consulta 3: Persistencia de datos (SELECT INTO). Generación automática de una tabla analítica permanente llamada ClientesVip que almacena únicamente a los clientes con un gasto acumulado superior a $500.00.
<img width="1159" height="510" alt="image" src="https://github.com/user-attachments/assets/e6852763-a9dd-4fdc-8679-6e8c4255bbb1" />


🔹 Actividad 4: Optimización con Subconsultas
Se implementan dos enfoques lógicos para identificar clientes que han comprado productos con Stock Crítico (< 15 unidades):

Opción A (Operador IN): Filtra los identificadores de clientes pertenecientes al conjunto devuelto por la subconsulta independiente.
<img width="1554" height="707" alt="image" src="https://github.com/user-attachments/assets/a5fe8c3b-e823-4e41-b2ee-e8431c777ba7" />

Opción B (Subconsulta Correlacionada con EXISTS): Evalúa de manera más eficiente la existencia de registros relacionados por cada fila evaluada en la tabla principal.

<img width="1000" height="674" alt="image" src="https://github.com/user-attachments/assets/e881adc0-7316-417f-b963-22a235c7200e" />
