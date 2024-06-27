CREATE DATABASE BDSISTEMADEVENTA
GO
USE BDSISTEMADEVENTA
GO

-- Creacion de tabla tipocliente
CREATE TABLE tipocliente (
    tcliente INT PRIMARY KEY,
    tipo VARCHAR(50)
);

go

-- Creación de la tabla
CREATE TABLE producto (
    productoid INT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    fechaExpiracion DATE,
    precio DECIMAL(10, 2)
);
go

-- Creación de la tabla
CREATE TABLE direccion (
    direccionid INT PRIMARY KEY,
    pais VARCHAR(50),
    codigopostal VARCHAR(10),
    ciudad VARCHAR(50),
    estado VARCHAR(50)
);
go

-- Creación de la tabla cliente
CREATE TABLE cliente (
    clienteid INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellidoP VARCHAR(100),
    apellidoM VARCHAR(100),
    telefono VARCHAR(15),
    tcliente INT,
    direccionid INT,
    FOREIGN KEY (tcliente) REFERENCES tipocliente(tcliente),
    FOREIGN KEY (direccionid) REFERENCES direccion(direccionid)
);
go

-- Creación de la tabla pedido
CREATE TABLE pedido (
    pedidoid INT PRIMARY KEY,
    estado VARCHAR(50),
    montototal DECIMAL(10, 2),
    fechapedido DATE,
    clienteid INT,
    FOREIGN KEY (clienteid) REFERENCES cliente(clienteid)
);

-- Creación de la tabla calificaciones
CREATE TABLE calificaciones (
    calificacionesid INT PRIMARY KEY,
    fechacalificacion DATE,
    puntaje INT,
    clienteid INT,
    FOREIGN KEY (clienteid) REFERENCES cliente(clienteid)
);
go

-- Creación de la tabla reseña
CREATE TABLE reseña (
    reseñaid INT PRIMARY KEY,
    textoreseña TEXT,
    fechareseña DATE,
    clienteid INT,
    FOREIGN KEY (clienteid) REFERENCES cliente(clienteid)
);
go

-- Creación de la tabla cupones
CREATE TABLE cupones (
    cuponid INT PRIMARY KEY,
    codigocupon VARCHAR(50),
    montodescuento DECIMAL(10, 2),
    fechaexpiracion DATE
);
go

-- Creación de la tabla canjecupon
CREATE TABLE canjecupon (
    canjecuponid INT PRIMARY KEY,
    fechacupon DATE,
    cuponid INT,
    pedidoid INT,
    FOREIGN KEY (cuponid) REFERENCES cupones(cuponid),
    FOREIGN KEY (pedidoid) REFERENCES pedido(pedidoid)
);
go

-- Creación de la tabla tipoPago
CREATE TABLE tipoPago (
    tpago INT PRIMARY KEY,
    tipo VARCHAR(50)
);
go

-- Creación de la tabla metodoPago
CREATE TABLE metodoPago (
    metodopagoID INT PRIMARY KEY,
    nombreMetodo VARCHAR(50)
);
go

-- Creación de la tabla pago
CREATE TABLE pago (
    pagoid INT PRIMARY KEY,
    monto DECIMAL(10, 2),
    fechapago DATE,
    tpagoid INT,
    metodopagoid INT,
    pedidoid INT,
    FOREIGN KEY (tpagoid) REFERENCES tipoPago(tpago),
    FOREIGN KEY (metodopagoid) REFERENCES metodoPago(metodopagoID),
    FOREIGN KEY (pedidoid) REFERENCES pedido(pedidoid)
);
go

-- Creación de la tabla observacionescomprobante
CREATE TABLE observacionescomprobante (
    observacionesid INT PRIMARY KEY,
    observaciones TEXT
);
go

-- Creación de la tabla tipocomprobante
CREATE TABLE tipocomprobante (
    tcomprobanteid INT PRIMARY KEY,
    tipo VARCHAR(50)
);
go

-- Creación de la tabla comprobantepago
CREATE TABLE comprobantepago (
    comprobanteid INT PRIMARY KEY,
    total DECIMAL(10, 2),
    productoid INT,
    tcomprobanteid INT,
    observacionesid INT,
    clienteiD INT,
    FOREIGN KEY (productoid) REFERENCES producto(productoid),
    FOREIGN KEY (tcomprobanteid) REFERENCES tipocomprobante(tcomprobanteid),
    FOREIGN KEY (observacionesid) REFERENCES observacionescomprobante(observacionesid),
    FOREIGN KEY (clienteid) REFERENCES cliente(clienteid)
);
go

-- Creación de la tabla devolucion
CREATE TABLE devolucion (
    devolucionid INT PRIMARY KEY,
    estado VARCHAR(50),
    fechadevolucion DATE,
    pedidoid INT,
    FOREIGN KEY (pedidoid) REFERENCES pedido(pedidoid)
);
go

-- Creación de la tabla envio
CREATE TABLE envio (
    envioid INT PRIMARY KEY,
    fechaenvio DATE,
    metodoenvio VARCHAR(50),
    numeroseguimiento VARCHAR(100),
    pedidoid INT,
    FOREIGN KEY (pedidoid) REFERENCES pedido(pedidoid)
);
go

-- Creación de la tabla productopedido
CREATE TABLE productopedido (
    productopedidoid INT PRIMARY KEY,
    productoid INT,
    cantidad INT,
    precio DECIMAL(10, 2),
    pedidoid INT,
    FOREIGN KEY (productoid) REFERENCES producto(productoid),
    FOREIGN KEY (pedidoid) REFERENCES pedido(pedidoid)
);
go

-- Creación de la tabla productoenvio
CREATE TABLE productoenvio (
    productoenvioid INT PRIMARY KEY,
    detalle TEXT,
    productopedidoid INT,
    envioid INT,
    FOREIGN KEY (productopedidoid) REFERENCES productopedido(productopedidoid),
    FOREIGN KEY (envioid) REFERENCES envio(envioid)
);
go

-- Creación de la tabla proveedor
CREATE TABLE proveedor (
    proveedorid INT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(15),
    correo VARCHAR(100)
);
go

-- Creación de la tabla inventario
CREATE TABLE inventario (
    inventarioid INT PRIMARY KEY,
    cantidad INT,
    productoid INT,
    proveedorid INT,
    FOREIGN KEY (productoid) REFERENCES producto(productoid),
    FOREIGN KEY (proveedorid) REFERENCES proveedor(proveedorid)
);
go



-- Creación de la tabla pedidoproveedor
CREATE TABLE pedidoproveedor (
    pedidoproveedorid INT PRIMARY KEY,
    fechapedido DATE,
    proveedorid INT,
    FOREIGN KEY (proveedorid) REFERENCES proveedor(proveedorid)
);
go

-- Creación de la tabla tipocategoria
CREATE TABLE tipocategoria (
    tipocategoriaid INT PRIMARY KEY,
    tipocategoria VARCHAR(50)
);
go

-- Creación de la tabla categoriaproducto
CREATE TABLE categoriaproducto (
    categoriaproductoid INT PRIMARY KEY,
    categoria VARCHAR(50),
    productoid INT,
    tipocategoriaid INT,
    FOREIGN KEY (productoid) REFERENCES producto(productoid),
    FOREIGN KEY (tipocategoriaid) REFERENCES tipocategoria(tipocategoriaid)
);
go

-- Creación de la tabla etiquetaproducto
CREATE TABLE etiquetaproducto (
    etiquetaproductoid INT PRIMARY KEY,
    nombreetiqueta VARCHAR(50)
);
go


-- Creación de la tabla mapeoEtiquetasproducto
CREATE TABLE mapeoEtiquetasproducto (
    mapeoetiquetasid INT PRIMARY KEY,
    detalle TEXT,
    productoid INT,
    etiquetaproductoid INT,
    FOREIGN KEY (productoid) REFERENCES producto(productoid),
    FOREIGN KEY (etiquetaproductoid) REFERENCES etiquetaproducto(etiquetaproductoid)
);
go

-- Creación de la tabla imagenproducto
CREATE TABLE imagenproducto (
    imagenid INT PRIMARY KEY,
    urlimagen VARCHAR(255),
    productoid INT,
    FOREIGN KEY (productoid) REFERENCES producto(productoid)
);
go

-- Creación de la tabla listapedidoproveedor
CREATE TABLE listapedidoproveedor (
    listapedidoproveedorid INT PRIMARY KEY,
    cantidad INT,
    precio DECIMAL(10, 2),
    pedidoproveedorid INT,
    FOREIGN KEY (pedidoproveedorid) REFERENCES pedidoproveedor(pedidoproveedorid)
);
go

-- Inserción de datos de ejemplo
INSERT INTO productopedido (productopedidoid, productoid, cantidad, precio, pedidoid) VALUES 
(1, 1, 2, 3.00, 1),
(2, 2, 1, 4.00, 2),
(3, 3, 5, 2.50, 3),
(4, 4, 3, 1.75, 4),
(5, 5, 4, 0.80, 5);

-- Inserción de datos de ejemplo
INSERT INTO inventario (inventarioid, cantidad, productoid, proveedorid) VALUES 
(1, 100, 1, 1),
(2, 150, 2, 2),
(3, 200, 3, 3),
(4, 250, 4, 4),
(5, 300, 5, 5);

-- Inserción de datos de ejemplo
INSERT INTO listapedidoproveedor (listapedidoproveedorid, cantidad, precio, pedidoproveedorid) VALUES 
(1, 10, 150.00, 1),
(2, 20, 300.00, 2),
(3, 15, 225.00, 3),
(4, 5, 75.00, 4),
(5, 25, 375.00, 5);

-- Inserción de datos de ejemplo
INSERT INTO imagenproducto (imagenid, urlimagen, productoid) VALUES 
(1, 'https://example.com/images/producto1.jpg', 1),
(2, 'https://example.com/images/producto2.jpg', 2),
(3, 'https://example.com/images/producto3.jpg', 3),
(4, 'https://example.com/images/producto4.jpg', 4),
(5, 'https://example.com/images/producto5.jpg', 5);


-- Inserción de datos de ejemplo en etiquetaproducto
INSERT INTO etiquetaproducto (etiquetaproductoid, nombreetiqueta) VALUES 
(1, 'Nuevo'),
(2, 'Oferta'),
(3, 'Popular'),
(4, 'Recomendado'),
(5, 'Descuento');

-- Inserción de datos de ejemplo en mapeoEtiquetasproducto
INSERT INTO mapeoEtiquetasproducto (mapeoetiquetasid, detalle, productoid, etiquetaproductoid) VALUES 
(1, 'Producto nuevo en el mercado', 1, 1),
(2, 'Producto en oferta especial', 2, 2),
(3, 'Producto muy popular entre los clientes', 3, 3),
(4, 'Producto altamente recomendado', 4, 4),
(5, 'Producto con descuento significativo', 5, 5);


-- Inserción de datos de ejemplo
INSERT INTO categoriaproducto (categoriaproductoid, categoria, productoid, tipocategoriaid) VALUES 
(1, 'Electrónica', 1, 1),
(2, 'Ropa', 2, 2),
(3, 'Hogar', 3, 3),
(4, 'Libros', 4, 4),
(5, 'Juguetes', 5, 5);


-- Inserción de datos de ejemplo
INSERT INTO tipocategoria (tipocategoriaid, tipocategoria) VALUES 
(1, 'Electrónica'),
(2, 'Ropa'),
(3, 'Hogar'),
(4, 'Libros'),
(5, 'Juguetes');


-- Inserción de datos de ejemplo
INSERT INTO pedidoproveedor (pedidoproveedorid, fechapedido, proveedorid) VALUES 
(1, '2024-07-01', 1),
(2, '2024-07-02', 2),
(3, '2024-07-03', 3),
(4, '2024-07-04', 4),
(5, '2024-07-05', 5);



-- Inserción de datos de ejemplo
INSERT INTO proveedor (proveedorid, nombre, telefono, correo) VALUES 
(1, 'Proveedor A', '5551234567', 'contactoA@proveedor.com'),
(2, 'Proveedor B', '5552345678', 'contactoB@proveedor.com'),
(3, 'Proveedor C', '5553456789', 'contactoC@proveedor.com'),
(4, 'Proveedor D', '5554567890', 'contactoD@proveedor.com'),
(5, 'Proveedor E', '5555678901', 'contactoE@proveedor.com');



-- Inserción de datos de ejemplo
INSERT INTO productoenvio (productoenvioid, detalle, productopedidoid, envioid) VALUES 
(1, 'Entrega en domicilio', 1, 1),
(2, 'Entrega en oficina', 2, 2),
(3, 'Entrega urgente', 3, 3),
(4, 'Entrega en punto de recogida', 4, 4),
(5, 'Entrega en tienda', 5, 5);



-- Inserción de datos de envio
INSERT INTO envio (envioid, fechaenvio, metodoenvio, numeroseguimiento, pedidoid) VALUES 
(1, '2024-07-01', 'Correo', 'TRACK123456', 1),
(2, '2024-07-02', 'Mensajería', 'TRACK234567', 2),
(3, '2024-07-03', 'Correo', 'TRACK345678', 3),
(4, '2024-07-04', 'Courier', 'TRACK456789', 4),
(5, '2024-07-05', 'Mensajería', 'TRACK567890', 5);


-- Inserción de datos de devolucion
INSERT INTO devolucion (devolucionid, estado, fechadevolucion, pedidoid) VALUES 
(1, 'Procesando', '2024-07-01', 1),
(2, 'Completado', '2024-07-02', 2),
(3, 'Pendiente', '2024-07-03', 3),
(4, 'Rechazado', '2024-07-04', 4),
(5, 'Aceptado', '2024-07-05', 5);



-- Inserción de datos de comprobante
INSERT INTO comprobantepago (comprobanteid, total, productoid, tcomprobanteid, observacionesid, clienteiD) VALUES 
(1, 150.50, 1, 1, 1, 1),
(2, 220.75, 2, 2, 2, 2),
(3, 320.20, 3, 3, 3, 3),
(4, 50.00, 4, 4, 4, 4),
(5, 180.00, 5, 5, 5, 5);


-- Inserción de datos de ejemplo
INSERT INTO tipocomprobante (tcomprobanteid, tipo) VALUES 
(1, 'Factura'),
(2, 'Recibo'),
(3, 'Nota de Crédito'),
(4, 'Nota de Débito'),
(5, 'Boleta de Venta');


-- Inserción de datos de ejemplo
INSERT INTO observacionescomprobante (observacionesid, observaciones) VALUES 
(1, 'Observación sobre el comprobante número 1.'),
(2, 'Este comprobante tiene una observación adicional.'),
(3, 'Revisión necesaria para el comprobante número 3.'),
(4, 'Notas sobre el comprobante 4, revisar detalles.'),
(5, 'Observación final sobre el comprobante número 5.');


-- Inserción de datos de pago
INSERT INTO pago (pagoid, monto, fechapago, tpagoid, metodopagoid, pedidoid) VALUES 
(1, 150.50, '2024-06-20', 1, 1, 1),
(2, 220.75, '2024-06-21', 2, 2, 2),
(3, 320.20, '2024-06-22', 3, 3, 3),
(4, 50.00, '2024-06-23', 2, 4, 4),
(5, 180.00, '2024-06-24', 2, 5, 5);


-- Inserción de datos de ejemplo en tipoPago
INSERT INTO tipoPago (tpago, tipo) VALUES 
(1, 'Tarjeta de Crédito'),
(2, 'Tarjeta de Débito'),
(3, 'Transferencia Bancaria');



-- Inserción de datos en metodoPago
INSERT INTO metodoPago (metodopagoID, nombreMetodo) VALUES 
(1, 'Visa'),
(2, 'MasterCard'),
(3, 'American Express'),
(4, 'PayPal'),
(5, 'Bank Transfer'),
(6, 'Efectivo');

-- Inserción de datos 
INSERT INTO canjecupon (canjecuponid, fechacupon, cuponid, pedidoid) VALUES 
(1, '2024-06-20', 1, 1),
(2, '2024-06-21', 2, 2),
(3, '2024-06-22', 3, 3),
(4, '2024-06-23', 4, 4),
(5, '2024-06-24', 5, 5);

-- Inserción de datos de cupones
INSERT INTO cupones (cuponid, codigocupon, montodescuento, fechaexpiracion) VALUES 
(1, 'DESC10', 10.00, '2024-12-31'),
(2, 'AHORRA20', 20.00, '2024-11-30'),
(3, 'BIENVENIDO15', 15.00, '2024-10-31'),
(4, 'VERANO25', 25.00, '2024-09-30'),
(5, 'PRIMAVERA5', 5.00, '2024-08-31');


-- Inserción de datos en resena
INSERT INTO reseña (reseñaid, textoreseña, fechareseña, clienteid) VALUES 
(1, 'Excelente servicio y calidad del producto.', '2024-06-01', 1),
(2, 'Buena atención al cliente, pero el envío fue lento.', '2024-06-05', 2),
(3, 'Producto defectuoso, no satisfecho con la compra.', '2024-06-10', 3),
(4, 'La calidad del producto es excepcional, lo recomiendo.', '2024-06-12', 4),
(5, 'Satisfecho con la compra, aunque el precio es un poco alto.', '2024-06-15', 5);


-- Inserción de datos de calificaciones
INSERT INTO calificaciones (calificacionesid, fechacalificacion, puntaje, clienteid) VALUES 
(1, '2024-06-01', 5, 1),
(2, '2024-06-05', 4, 2),
(3, '2024-06-10', 3, 3),
(4, '2024-06-12', 2, 4),
(5, '2024-06-15', 5, 5);


-- Inserción de datos de pedido
INSERT INTO pedido (pedidoid, estado, montototal, fechapedido, clienteid) VALUES 
(1, 'Pendiente', 150.50, '2024-06-01', 1),
(2, 'Completado', 220.75, '2024-06-05', 2),
(3, 'Enviado', 320.20, '2024-06-10', 3),
(4, 'Cancelado', 50.00, '2024-06-12', 4),
(5, 'Procesando', 180.00, '2024-06-15', 5);


-- Inserción de datos de clientes
INSERT INTO cliente (clienteid, nombre, apellidoP, apellidoM, telefono, tcliente, direccionid) VALUES 
(1, 'Juan', 'Pérez', 'García', '5551234567', 1, 1),
(2, 'Ana', 'López', 'Martínez', '5552345678', 2, 2),
(3, 'Carlos', 'Sánchez', 'Hernández', '5553456789', 3, 3),
(4, 'María', 'Gómez', 'Ramírez', '5554567890', 4, 4),
(5, 'Luis', 'Rodríguez', 'Torres', '5555678901', 5, 5);


-- Inserción de datos en direccion
INSERT INTO direccion (direccionid, pais, codigopostal, ciudad, estado) VALUES 
(1, 'México', '01000', 'Ciudad de México', 'CDMX'),
(2, 'España', '28001', 'Madrid', 'Madrid'),
(3, 'Argentina', 'C1001', 'Buenos Aires', 'Buenos Aires'),
(4, 'Estados Unidos', '10001', 'Nueva York', 'Nueva York'),
(5, 'Colombia', '110111', 'Bogotá', 'Bogotá D.C.');

-- Inserción de datos en productos
INSERT INTO producto (productoid, nombre, descripcion, fechaExpiracion, precio) VALUES 
(1, 'Leche', 'Leche entera pasteurizada', '2024-12-31', 1.20),
(2, 'Pan', 'Pan integral de trigo', '2024-07-15', 0.80),
(3, 'Queso', 'Queso cheddar maduro', '2024-10-01', 3.50),
(4, 'Yogur', 'Yogur natural sin azúcar', '2024-08-20', 1.00),
(5, 'Manzana', 'Manzana roja fresca', '2024-09-10', 0.50);

-- Insertamos datos en tipo cliente
INSERT INTO tipocliente (tcliente, tipo) VALUES (1, 'Regular');
INSERT INTO tipocliente (tcliente, tipo) VALUES (2, 'VIP');
INSERT INTO tipocliente (tcliente, tipo) VALUES (3, 'Corporate');
INSERT INTO tipocliente (tcliente, tipo) VALUES (4, 'Non-profit');
INSERT INTO tipocliente (tcliente, tipo) VALUES (5, 'Government');

