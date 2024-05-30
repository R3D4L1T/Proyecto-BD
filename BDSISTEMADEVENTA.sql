CREATE DATABASE BDSISTEMADEVENTA
GO
USE BDSISTEMADEVENTA
GO

CREATE TABLE Usuarios (
    IDUsuario INT PRIMARY KEY IDENTITY(1,1),
    NombreUsuario VARCHAR(255) NOT NULL,
    HashContraseña VARCHAR(255) NOT NULL,
    CorreoElectronico VARCHAR(255) NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE()
)
GO

<<<<<<< HEAD
CREATE TABLE Roles (
    IDRol INT PRIMARY KEY IDENTITY(1,1),
    NombreRol VARCHAR(255) NOT NULL
)
GO

CREATE TABLE RolesUsuarios (
    IDRolUsuario INT PRIMARY KEY IDENTITY(1,1),
    IDUsuario INT,
    IDRol INT,
    FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario),
    FOREIGN KEY (IDRol) REFERENCES Roles(IDRol)
)
GO

CREATE TABLE Productos (
    IDProducto INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    Precio DECIMAL(10, 2) NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE Categorias (
    IDCategoria INT PRIMARY KEY IDENTITY(1,1),
    NombreCategoria VARCHAR(255) NOT NULL
)
GO

CREATE TABLE CategoriasProductos (
    IDCategoriaProducto INT PRIMARY KEY IDENTITY(1,1),
    IDProducto INT,
    IDCategoria INT,
    FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto),
    FOREIGN KEY (IDCategoria) REFERENCES Categorias(IDCategoria)
)
GO

CREATE TABLE ImagenesProducto (
    IDImagen INT PRIMARY KEY IDENTITY(1,1),
    IDProducto INT,
    URLImagen VARCHAR(255),
    FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto)
)
GO

CREATE TABLE Inventario (
    IDInventario INT PRIMARY KEY IDENTITY(1,1),
    IDProducto INT,
    Cantidad INT NOT NULL,
    FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto)
)
GO

CREATE TABLE Proveedores (
    IDProveedor INT PRIMARY KEY IDENTITY(1,1),
    NombreProveedor VARCHAR(255) NOT NULL,
    CorreoContacto VARCHAR(255)
)
GO


CREATE TABLE ArticulosPedido (
    IDArticuloPedido INT PRIMARY KEY IDENTITY(1,1),
    IDPedido INT,
    IDProducto INT,
    Cantidad INT,
    Precio DECIMAL(10, 2),
    FOREIGN KEY (IDPedido) REFERENCES Pedidos(IDPedido),
    FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto)
)
GO

CREATE TABLE Clientes (
    IDCliente INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    CorreoElectronico VARCHAR(255) NOT NULL,
    Telefono VARCHAR(20)
)
GO

CREATE TABLE Pedidos (
    IDPedido INT PRIMARY KEY IDENTITY(1,1),
    IDCliente INT,
    FechaPedido DATETIME DEFAULT GETDATE(),
    MontoTotal DECIMAL(10, 2),
    Estado VARCHAR(50),
    FOREIGN KEY (IDCliente) REFERENCES Clientes(IDCliente)
)
GO

CREATE TABLE Direcciones (
    IDDireccion INT PRIMARY KEY IDENTITY(1,1),
    IDCliente INT,
    LineaDireccion1 VARCHAR(255),
    LineaDireccion2 VARCHAR(255),
    Ciudad VARCHAR(100),
    Estado VARCHAR(100),
    CodigoPostal VARCHAR(20),
    Pais VARCHAR(100),
    FOREIGN KEY (IDCliente) REFERENCES Clientes(IDCliente)
)
GO

CREATE TABLE Pagos (
    IDPago INT PRIMARY KEY IDENTITY(1,1),
    IDPedido INT,
    IDMetodoPago INT,
    Monto DECIMAL(10, 2),
    FechaPago DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IDPedido) REFERENCES Pedidos(IDPedido),
    FOREIGN KEY (IDMetodoPago) REFERENCES MetodosPago(IDMetodoPago)
)
GO

CREATE TABLE MetodosPago (
    IDMetodoPago INT PRIMARY KEY IDENTITY(1,1),
    NombreMetodo VARCHAR(50) NOT NULL
)
GO

CREATE TABLE Envios (
    IDEnvio INT PRIMARY KEY IDENTITY(1,1),
    IDPedido INT,
    FechaEnvio DATETIME DEFAULT GETDATE(),
    MetodoEnvio VARCHAR(100),
    NumeroSeguimiento VARCHAR(100),
    FOREIGN KEY (IDPedido) REFERENCES Pedidos(IDPedido)
)
GO

CREATE TABLE ArticulosEnvio (
    IDArticuloEnvio INT PRIMARY KEY IDENTITY(1,1),
    IDEnvio INT,
    IDArticuloPedido INT,
    FOREIGN KEY (IDEnvio) REFERENCES Envios(IDEnvio),
    FOREIGN KEY (IDArticuloPedido) REFERENCES ArticulosPedido(IDArticuloPedido)
)
GO

CREATE TABLE Reseñas (
    IDReseña INT PRIMARY KEY IDENTITY(1,1),
    IDProducto INT,
    IDCliente INT,
    TextoReseña TEXT,
    FechaReseña DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto),
    FOREIGN KEY (IDCliente) REFERENCES Clientes(IDCliente)
)
GO

CREATE TABLE Calificaciones (
    IDCalificacion INT PRIMARY KEY IDENTITY(1,1),
    IDProducto INT,
    IDCliente INT,
    Calificacion INT,
    FechaCalificacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto),
    FOREIGN KEY (IDCliente) REFERENCES Clientes(IDCliente)
)
GO

CREATE TABLE ListasDeseos (
    IDListaDeseos INT PRIMARY KEY IDENTITY(1,1),
    IDCliente INT,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IDCliente) REFERENCES Clientes(IDCliente)
)
GO

CREATE TABLE ArticulosListaDeseos (
    IDArticuloListaDeseos INT PRIMARY KEY IDENTITY(1,1),
    IDListaDeseos INT,
    IDProducto INT,
    FOREIGN KEY (IDListaDeseos) REFERENCES ListasDeseos(IDListaDeseos),
    FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto)
)
GO

CREATE TABLE Cupones (
    IDCupon INT PRIMARY KEY IDENTITY(1,1),
    CodigoCupon VARCHAR(50) NOT NULL,
    MontoDescuento DECIMAL(10, 2),
    FechaExpiracion DATE
)
GO

CREATE TABLE RedencionesCupon (
    IDRedencionCupon INT PRIMARY KEY IDENTITY(1,1),
    IDCupon INT,
    IDPedido INT,
    FechaRedencion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IDCupon) REFERENCES Cupones(IDCupon),
    FOREIGN KEY (IDPedido) REFERENCES Pedidos(IDPedido)
)
GO

CREATE TABLE Devoluciones (
    IDDevolucion INT PRIMARY KEY IDENTITY(1,1),
    IDPedido INT,
    FechaDevolucion DATETIME DEFAULT GETDATE(),
    Estado VARCHAR(50),
    FOREIGN KEY (IDPedido) REFERENCES Pedidos(IDPedido)
)
GO


CREATE TABLE ArticulosDevolucion (
    IDArticuloDevolucion INT PRIMARY KEY IDENTITY(1,1),
    IDDevolucion INT,
    IDArticuloPedido INT,
    Cantidad INT,
    FOREIGN KEY (IDDevolucion) REFERENCES Devoluciones(IDDevolucion),
    FOREIGN KEY (IDArticuloPedido) REFERENCES ArticulosPedido(IDArticuloPedido)
)
GO

CREATE TABLE Carrito (
    IDCarrito INT PRIMARY KEY IDENTITY(1,1),
    IDUsuario INT,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario)
)
GO

CREATE TABLE ArticulosCarrito (
    IDArticuloCarrito INT PRIMARY KEY IDENTITY(1,1),
    IDCarrito INT,
    IDProducto INT,
    Cantidad INT,
    FOREIGN KEY (IDCarrito) REFERENCES Carrito(IDCarrito),
    FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto)
)
GO

CREATE TABLE EtiquetasProducto (
    IDEtiqueta INT PRIMARY KEY IDENTITY(1,1),
    NombreEtiqueta VARCHAR(50) NOT NULL
)
GO

CREATE TABLE MapeoEtiquetasProducto (
    IDMapeoEtiqueta INT PRIMARY KEY IDENTITY(1,1),
    IDProducto INT,
    IDEtiqueta INT,
    FOREIGN KEY (IDProducto) REFERENCES Productos(IDProducto),
    FOREIGN KEY (IDEtiqueta) REFERENCES EtiquetasProducto(IDEtiqueta)
)
GO

CREATE TABLE Logs (
    IDLog INT PRIMARY KEY IDENTITY(1,1),
    IDUsuario INT,
    Accion VARCHAR(255),
    FechaHora DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario)
)
GO

--ALTERAMOS LA TABLA PROVEEDOR YA QUE FALTÓ RELACIONAR CON PRODUCTO
ALTER TABLE Productos
ADD  ProveedorID INT

ALTER TABLE Productos
ADD CONSTRAINT FK_ProveedorID
FOREIGN KEY (ProveedorID) REFERENCES Proveedores(IDProveedor)
GO


--ALTERAMOS LA TABLA PROVEEDOR YA QUE FALTÓ RELACIONAR CON INVENTARIO
-- Agregar la columna ProveedorID a la tabla Inventario
ALTER TABLE Inventario
ADD ProveedorID INT

-- Establecer la clave externa en la columna ProveedorID
ALTER TABLE Inventario
ADD CONSTRAINT FK_ProveedorID
FOREIGN KEY (ProveedorID) REFERENCES Proveedores(IDProveedor)
GO

--
-- Crear la tabla PedidosProveedores
CREATE TABLE PedidosProveedores (
    PedidoProveedorID INT PRIMARY KEY IDENTITY(1,1),
    ProveedorID INT,
    FechaPedido DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProveedorID) REFERENCES Proveedores(IDPROVEEDOR)
)
GO

-- Crear la tabla ItemsPedidosProveedores
CREATE TABLE ItemsPedidosProveedores (
    ItemPedidoProveedorID INT PRIMARY KEY IDENTITY(1,1),
    PedidoProveedorID INT,
    ProductoID INT,
    Cantidad INT,
    Precio DECIMAL(10, 2),
    FOREIGN KEY (PedidoProveedorID) REFERENCES PedidosProveedores(PedidoProveedorID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(IDProducto)
)
GO



