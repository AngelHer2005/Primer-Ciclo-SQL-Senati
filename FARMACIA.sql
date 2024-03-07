
------------------------------
------------------------------
-- CREANDO LA BASE DE DATOS --
------------------------------
------------------------------

	CREATE DATABASE FARMACIA
	GO

-----------------------------
-----------------------------
-- USANDO LA BASE DE DATOS --
-----------------------------
-----------------------------

	USE FARMACIA
	GO

---------------------------
---------------------------
-- CREANDO DE LAS TABLAS --
---------------------------
---------------------------

CREATE TABLE Cliente(
IdCliente Varchar(8)  NOT NULL,
Nombre_cli Varchar(40) NOT NULL,
Apellido_cli Varchar(30) NOT NULL,
Direccion Varchar(40) NOT NULL,
Sexo Varchar(1) NOT NULL,
DNI INT NOT NULL,
Celular INT NOT NULL,
IdDistrito Varchar(3) NOT NULL
)
GO


CREATE TABLE Pedido (
IdPedido int NOT NULL Identity(1,1),
Fecha Date NOT NULL,
Total Decimal(10,2) NOT NULL,
IdCliente Varchar (8) NOT NULL,
Subtotal Decimal(10,2) NOT Null,
IGV  Decimal(10,2) NOT NULL
) 
GO


CREATE TABLE DetallePedido ( 
IdPedido int NOT NULL, 
IdProducto Varchar(8) NOT NULL,  
Cantidad INT NOT NULL, 
Precio Money NOT NULL
) 
GO 



CREATE TABLE Distrito (
IdDistrito Varchar(3) NOT NULL, 
Nombre_Dis Varchar(30) NOT NULL 
) 
GO

select * from distrito 

go
ALTER  AUTHORIZATION ON DATABASE:: [FARMACIA] TO SA


CREATE TABLE Categoria (
IdCategoria Varchar(8) NOT NULL ,
Nombre_Cat Varchar(40) NOT NULL 
) 
GO



CREATE TABLE Producto (
IdProducto Varchar(8) NOT NULL, 
Nombre_Pro Varchar(40) NOT NULL, 
Pre_venta Money NOT NULL, 
Pre_compra Money NOT NULL, 
Fecha_venc Date NOT NULL, 
Stock INT NOT NULL, 
IdCategoria Varchar(8) NOT NULL, 
IdProveedor Varchar(8) NULL
) 
GO


CREATE TABLE Cargo (
IdCargo INT NOT NULL IDENTIty(1,1),
Nombre Varchar(20) NOT NULL,
Descripcion Varchar(40) NOT NULL
)
GO


CREATE TABLE Empleado ( 
IdEmpleado Varchar(8)  NOT NULL, 
Nombre_Emp Varchar(40) NOT NULL, 
Apellido_Emp Varchar(40) NOT NULL,
Direccion_Emp Varchar(40) NOT NULL, 
IdDistrito Varchar(3) NOT NULL,  
Edad INT NOT NULL, 
Email Varchar(35) NULL, 
Celular INT NOT NULL,
F_Ingreso Date NOT NULL,  
Cargo INT NOT NULL,
Usuario Varchar(8) NOT NULL,
Clave Varchar(20) NOT NULL
) 
GO


CREATE TABLE Proveedor ( 
IdProveedor Varchar(8) NOT NULL,
Nombre_Prove Varchar(40) NOT NULL,
Direccion_Prove Varchar(50) NULL,
Telefono Char(7) NOT NULL,
IdDistrito Varchar(3) NOT NULL,
Razon_social Varchar (50) NOT NULL
) 
GO

----------------------------------
----------------------------------
-- CREANDO LAS TABLAS PRIMARIAS --
----------------------------------
----------------------------------

ALTER TABLE Cliente
ADD CONSTRAINT PK_Cliente_IdCliente
PRIMARY KEY (IdCliente)
GO



ALTER TABLE Pedido
ADD CONSTRAINT PK_Pedido_IdPedido
PRIMARY KEY (IdPedido)
GO


ALTER TABLE Distrito
ADD CONSTRAINT PK_Distrito_IdDistrito
PRIMARY KEY (IdDistrito)
GO


ALTER TABLE Categoria
ADD CONSTRAINT PK_Categoria_IdCategoria
PRIMARY KEY (IdCategoria)
GO



ALTER TABLE Producto
ADD CONSTRAINT PK_Producto_IdProducto
PRIMARY KEY (IdProducto)
GO


ALTER TABLE Empleado
ADD CONSTRAINT PK_Empleado_IdEmpleado
PRIMARY KEY (IdEmpleado)
GO


ALTER TABLE DetallePedido
ADD CONSTRAINT PK_DetallePedido_IdPedido_IdProducto
PRIMARY KEY (IdPedido,IdProducto)
GO


ALTER TABLE Proveedor
ADD CONSTRAINT PK_Proveedor_IdProveedor
PRIMARY KEY (IdProveedor)
GO


ALTER TABLE Cargo
ADD CONSTRAINT PK_Cargo_IdCargo
PRIMARY KEY (IdCargo)
GO

-------------------------------------
-------------------------------------
-- Creacion de las Claves Foraneas --
-------------------------------------
-------------------------------------

ALTER TABLE Cliente
ADD CONSTRAINT FK_Cliente_IdDistrito
FOREIGN KEY (IdDistrito)
REFERENCES Distrito (IdDistrito)
GO

 
ALTER TABLE Producto
ADD CONSTRAINT FK_Producto_IdCategoria
FOREIGN KEY (IdCategoria)
REFERENCES Categoria (IdCategoria)
GO


ALTER TABLE Empleado
ADD CONSTRAINT FK_Empleado_IdDistrito
FOREIGN KEY (IdDistrito)
REFERENCES Distrito (IdDistrito)
GO


ALTER TABLE Pedido
ADD CONSTRAINT FK_Pedido_IdCliente
FOREIGN KEY (IdCliente)
REFERENCES Cliente (IdCliente)
GO

ALTER TABLE DetallePedido
ADD CONSTRAINT FK_DetallePedido_IdProducto
FOREIGN KEY (IdProducto)
REFERENCES Producto (IdProducto)
GO


ALTER TABLE Producto
ADD CONSTRAINT FK_Producto_IdProveedor
FOREIGN KEY (IdProveedor)
REFERENCES Proveedor (IdProveedor)
GO


ALTER TABLE Empleado
ADD CONSTRAINT FK_Empleado_Cargo
FOREIGN KEY (Cargo)
REFERENCES Cargo(IdCargo)
GO


ALTER TABLE Proveedor
ADD CONSTRAINT FK_Proveedor_IdDistrito
FOREIGN KEY (IdDistrito)
REFERENCES Distrito (IdDistrito)
GO


ALTER TABLE DetallePedido
ADD CONSTRAINT FK_DetallePedido_IdPedido
FOREIGN KEY(IdPedido)
REFERENCES Pedido(IdPedido)
ON DELETE CASCADE
GO

-----------------------------------
-----------------------------------
-- CREACION DE CONSTRAINT UNIQUE --
-----------------------------------
-----------------------------------


ALTER TABLE Distrito
ADD CONSTRAINT UN_Distrito_IdDistrito
UNIQUE (IdDistrito)
GO


ALTER TABLE Distrito
ADD CONSTRAINT UN_Distrito_Nombre_Dis
UNIQUE (Nombre_Dis)
GO


ALTER TABLE Empleado
ADD CONSTRAINT UN_Empleado_IdEmpleado
UNIQUE (IdEmpleado)
GO


ALTER TABLE Cliente
ADD CONSTRAINT UN_Cliente_IdCliente
UNIQUE (IdCliente)
GO


ALTER TABLE Cliente
ADD CONSTRAINT UN_Cliente_DNI
UNIQUE (DNI)
GO


ALTER TABLE Proveedor
ADD CONSTRAINT UN_Proveedor_IdProveedor
UNIQUE (IdProveedor)
GO

----------------------------------
----------------------------------
-- CREACION DE CONSTRAINT CHECK --
----------------------------------
----------------------------------

ALTER TABLE Cliente
ADD CONSTRAINT CK_Cliente_IdCliente
CHECK(IdCliente LIKE 'C[0-9][0-9][0-9]' AND IdCliente<>'C000')
GO


ALTER TABLE Cliente
ADD CONSTRAINT CK_Cliente_DNI
CHECK(DNI LIKE '[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' AND DNI<>'00000000')
GO


ALTER TABLE Cliente
ADD CONSTRAINT CK_Cliente_Celular
CHECK(Celular LIKE '9[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' )
GO


ALTER TABLE Empleado
ADD CONSTRAINT CK_Empleado_IdEmpleado
CHECK(IdEmpleado LIKE 'E[0-9][0-9][0-9]' AND IdEmpleado<>'E000')
GO


ALTER TABLE Empleado
ADD CONSTRAINT CK_Empleado_Edad
CHECK(Edad LIKE '[0-9][0-9]' AND Edad>=18)
GO


ALTER TABLE Empleado
ADD CONSTRAINT CK_Empleado_Celular
CHECK(Celular LIKE '9[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' )
GO


ALTER TABLE Producto
ADD CONSTRAINT CK_Producto_Pre_Venta
CHECK (Pre_venta>0)
GO


ALTER TABLE Producto
ADD CONSTRAINT CK_Producto_Pre_Compra
CHECK (Pre_Compra>0)
GO


ALTER TABLE Producto
ADD CONSTRAINT CK_Producto_IdProducto
CHECK(IdProducto LIKE 'PRO[0-9][0-9]' AND IdProducto<> 'PRO00')
GO


ALTER TABLE Distrito
ADD CONSTRAINT CK_Distrito_IdDistrito
CHECK(IdDistrito LIKE 'D[0-2][0-9]' AND IdDistrito<>'D00')
GO


ALTER TABLE Proveedor
ADD CONSTRAINT CK_Proveedor_IdProveedor
CHECK(IdProveedor LIKE 'LAB[0-9][0-9]' AND IdProveedor<>'LAB00')
GO


ALTER TABLE Categoria
ADD CONSTRAINT CK_Categoria_IdCategoria
CHECK(IdCategoria LIKE 'CAT[0-1][0-9]' AND IdCategoria<>'CAT00')
GO

----------------------------------
----------------------------------
-- CREACION DE CONSTRAINT DEFAULT --
----------------------------------
----------------------------------

ALTER TABLE Pedido
ADD CONSTRAINT DF_Pedido_Fecha
DEFAULT GETDATE() FOR Fecha
GO


INSERT INTO Distrito(IdDistrito, Nombre_Dis)
VALUES 
('D01', 'Independencia'),
('D02', 'Comas'),
('D03', 'Los Olivos'),
('D04', 'Rimac'),
('D05', 'San Martin de Porres'),
('D06', 'Miraflores'),
('D07', 'Carabayllo'),
('D08', 'Lince'),
('D09', 'La Victoria'),
('D10', 'Villa El Salvador'),
('D11', 'San Borja'),
('D12', 'San Isidro'),
('D13', 'Ancon'),
('D14', 'Barranco'),
('D15', 'Chorrillos')
GO


INSERT INTO Cargo(Nombre, Descripcion)
VALUES 
('ADMIN', 'Entra a todo el sistema'),
('VENTAS', 'Hace las ventas de los productos')
GO


INSERT INTO Cliente(IdCliente, Nombre_cli, Apellido_cli, Direccion, Sexo, DNI, Celular, IdDistrito)
VALUES 
('C001', 'GABRIELA', 'MELENDEZ', 'Av. 17 de Noviembre', 'F', 17103567 , 963285875, 'D01' ),
('C002', 'DIANA', 'AQUINO', 'Av. Sinchi Roca', 'F', 75552259, 960942379, 'D02'),
('C003', 'MILAGROS', 'ARANGO', 'Av. Cordialidad', 'F', 17022270, 936648687, 'D03'),
('C004', 'MARIO', 'SANTISTEBAN', 'Av. Francisco Pizarro', 'M', 61696049, 955086918, 'D04'),
('C005', 'ANGIE', 'CANDELA', 'Av. Bocanegra', 'F', 62597895, 967943586, 'D05'),
('C006', 'OMAR', 'CAMARENA', 'Jr. Viru', 'M', 20117086, 925482677, 'D04'),
('C007', 'ALEX', 'DE LA CRUZ', 'Av. de Los Proceres', 'M', 26244173, 997788831, 'D04'),
('C008', 'JUAN', 'CHUMPITAZ', 'Av. Guillermo de la Fuente', 'M', 74172350, 939907471, 'D02'),
('C009', 'JAZMIN', 'CORNEJO', 'Av. Huamachuco', 'F', 75022895, 930073301, 'D01'),
('C010', 'PAMELA', 'CORTEZ', 'Av. Metropolitana', 'F', 66747670, 968004631, 'D02'),
('C011', 'ESTEFANI', 'MOREY', 'Av. 22 de Agosto', 'F', 22175692, 949544138, 'D02'),
('C012', 'ALBERTO', 'MALPARTIDA', 'Av. Huascar', 'M', 46480447, 937951274, 'D01'),
('C013', 'SOFIA', 'MARIN', 'Av. Victor Andres Belaunde', 'F', 31944633, 987085352, 'D02'),
('C014', 'DAVID', 'MATTA', 'Av. Tarapaca', 'M', 16136554, 985801698, 'D04'),
('C015', 'MARITA', 'NEYRA', 'Jr. Alca', 'F', 74870301, 902671131, 'D01'),
('C016', 'JOSE', 'PEDROSO', 'Av. Amancaes', 'M', 70699628, 934963733, 'D04'),
('C017', 'ANTONIO', 'ARTEAGA', 'Av. Samuel Alcazar', 'M', 59568842, 946542259, 'D04'),
('C018', 'CRISTINA', 'JIMENEZ', 'Av. Jose Gabriel Condorcanqui', 'F', 19384630, 923435638, 'D01'),
('C019', 'ANGELO', 'RAMIREZ', 'Av. Chinchaysuyo', 'M', 54910153, 993345964, 'D01'),
('C020', 'RODRIGO', 'FERNANDEZ', 'Av El Sol', 'M', 49284526, 944784927, 'D04'),
('C021', 'KATHERINE', 'PEREZ', 'Av. Angelica Gamarra', 'F', 71382494, 956550870, 'D05'),
('C022', 'DANA', 'ROCA', 'Av. Lima', 'F', 18244933, 953784811, 'D05'),
('C023', 'PILAR', 'RAMOS', 'Av. Santa Rosa', 'F', 71186817, 900365755, 'D04'),
('C024', 'DIEGO', 'TRUJILLO', 'Jr. Marco', 'M', 13391632, 919150303, 'D01'),
('C025', 'KEVIN', 'VALVERDE', 'Av. Pampacancha', 'M', 78993338, 940881851, 'D01'),
('C026', 'JORGE', 'VARGAS', 'Av. Universitaria', 'M', 36251434, 991194420, 'D03')
GO


INSERT INTO Empleado(IdEmpleado, Nombre_Emp, Apellido_Emp, Direccion_Emp, IdDistrito, Edad, Email, Celular, F_Ingreso, Cargo, Usuario, Clave)
VALUES 
('E001', 'DIEGO', 'MILLA', 'Jr. Inca Roca', 'D01', 20, 'diegomilla@gmail.com', 920107452, '2020-12-06' ,2,'DIEMIL', 'DIEMIL') ,
('E002', 'LILIANA', 'AGUILAR', 'Jr. Hurin Cuzco', 'D02', 33, 'liliaguilar1@gmail.com', 950964791, '2020-11-06', 2, 'LILAGU', 'LILAGU'),
('E003', 'MELANIE', 'HUANCA', 'Av. Indoamerica', 'D01', 18, 'mel_huanca@hotmail.com', 961036186, '2020-07-06', 2, 'MELHUA', 'MELHUA') ,
('E004', 'ANA', 'PEREZ', 'Jr. Inca Urco', 'D05', 19, 'perezana@hotmail.com', 951238879, '2020-11-15', 2, 'ANAPER', 'ANAPER'),
('E005', 'FERNANDO', 'VALLE', 'Av. 22 de Agosto', 'D05', 23, 'laextrañomucho@hotmail.com', 993068771, '2020-11-25', 1, 'FERVAL', 'FERVAL'),
('E006', 'ALEXIS', 'ESCOBAR', 'Av. Samuel Alcazar', 'D04', 30, 'alexescobar@gmail.com', 988825983, '2020-11-07', 2, 'ALEESC', 'ALEESC'),
('E007', 'ALESSANDRA', 'VERA', 'Jr. Marco', 'D02', 20, 'alessa20@hotmail.com', 968340444, '2020-11-18', 2, 'ALEVER', 'ALEVER'),
('E008', 'MIGUEL', 'SUAREZ', 'Av. Angelica Gamarra', 'D03', 35, 'miguelito777@hotmail.com', 914840734, '2020-12-25', 2, 'MIGSUA', 'MIGSUA'),
('E009', 'VALERIA', 'FERNANDEZ', 'Av. Santa Rosa', 'D01', 24, 'valef@gmail.com', 980810892, '2020-12-31', 2, 'VALFER','VALFER'),
('E010', 'JAIR', 'SOTO', 'Av. Tarapaca', 'D04', 32, 'jair_soto123@gmail.com', 943157381, '2020-11-06', 2, 'JAISOT', 'JAISOT'),
('E011', 'VICTOR', 'BORJA', 'Av. Cordialidad', 'D02', 21, 'narutosasuke23@hotmail.com', 948416125, '2020-11-06', 2, 'VICBOR', 'VICBOR'),
('E012', 'ANDRES', 'ROJAS', 'Jr. Marco', 'D03', 23, 'rojas_andres_23@hotmail.com', 967501343, '2020-11-06', 2, 'ANDROJ', 'ANDROJ'),
('E013', 'ENRIQUE', 'ALVARADO', 'Jr. Alca', 'D03', 19, 'alvaradoenrique17@gmail.com', 996194597, '2020-11-06', 2, 'ENRALV', 'ENRALV'),
('E014', 'VIVIANA', 'LEON', 'Av. Bocanegra', 'D04', 20, 'vivileon@gmail.com', 989554963, '2020-11-06', 2, 'VIVLEO', 'VIVLEO'),
('E015', 'CIELO', 'CUBAS', 'Av Pampacancha', 'D05', 27, 'cielocubas@hotmail.com', 915259871, '2020-11-06', 2, 'CIECUB', 'CIECUB')
GO


INSERT INTO Categoria(IdCategoria, Nombre_Cat)
VALUES
('CAT01', 'PASTILLAS'),
('CAT02', 'JARABES PARA NIÑOS'),
('CAT03', 'INYECCIONES PARA ADULTOS'),
('CAT04', 'VITAMINAS A'),
('CAT05', 'JARABES PARA ADULTOS'),
('CAT06', 'VITAMINAS B'),
('CAT07', 'VITAMINAS C'),
('CAT08', 'INYECCIONES PARA NIÑOS'),
('CAT09', 'CAPSULAS'),
('CAT10', 'SUERO'),
('CAT11', 'COSMETICOS'),
('CAT12', 'INGIENE PERSONAL'),
('CAT13', 'POMADAS'),
('CAT14', '	PRESERVATIVOS'),
('CAT15', 'ARTICULOS VARIOS')
GO


INSERT INTO Proveedor(IdProveedor, Nombre_Prove, Direccion_Prove, Telefono, IdDistrito, Razon_social)
VALUES
('LAB01', 'DSM NUTRITIONAL PRODUCTS PERU', 'Av. Simon Bolivar 795', 5214937, 'D01', 'DSM NUTRITIONAL PRODUCTS PERU S.A.'),
('LAB02', 'SANOFI-AVENTIS DEL PERU', 'Av. Antunez de Mayolo 1360', 5261478, 'D02', 'SANOFI-AVENTIS DEL PERU S.A.'),
('LAB03', 'PFIZER', 'Av. Alfredo Mendiola', 5289540, 'D04', 'PFIZER S.A.'),
('LAB04', 'BAYER', 'Av. Horacio Urteaga 1581', 5402164, 'D01', 'BAYER S.A.'),
('LAB05', 'BRISAFARMA', 'Av. Tupac Amaru 5361', 5531931, 'D03', 'BRISAFARMA S.A.C.'),
('LAB06', 'GENZYME PERU', 'Av. Peru 3301', 3794441, 'D02', 'GENZYME PERU S.A.C.'),
('LAB07', 'LABORATORIOS DELFARMA', 'Av. La Marina 1023', 4049973, 'D05', 'LABORATORIOS DELFARMA S.A.C.'),
('LAB08', 'LABORATORIOS INDUQUIMICA', 'Av. Alfonso Ugarte 14185', 5706010, 'D01', 'LABORATORIOS INDUQUIMICA S.A.'),
('LAB09', 'Q PHARMA', 'Av. Alfonso Ugarte 1006', 3055823, 'D01', 'Q PHARMA S.A.C.'),
('LAB10', 'TEVA PERU', 'Av. Guardia Civil 711', 6971676, 'D02', 'TEVA PERU S.A.C.'),
('LAB11', 'ABBOTT LABORATORIOS', 'Av. Los Angeles 472', 5297597, 'D02', 'ABBOTT LABORATORIOS S.A.'),
('LAB12', 'LABORATORIOS AC FARMA', 'Av. Canadá 606', 7763117, 'D05', 'LABORATORIOS AC FARMA S.A.'),
('LAB13', 'MEDIFARMA', 'Av. Alfonso Ugarte 641', 4671564, 'D03', 'MEDIFARMA S.A.'),
('LAB14', 'FARMINDUSTRIA', 'Plaza Bélgica 371', 3046870, 'D04', 'FARMINDUSTRIA S.A.'),
('LAB15', 'NOVARTIS BIOCIENCIES', 'Jr. La Reserva 875', 5207682, 'D04', ' NOVARTIS BIOCIENCIES PERU S.A.C'),
('LAB16', 'GLOBAL HEALTH SERVICES', 'Av. San Borja Sur 231', 2650958, 'D05', 'GLOBAL HEALTH SERVICES, S.A.A.'),
('LAB17', 'MAXFARMA', 'Av. Alfredo Mendiola 5648', 3260368, 'D01', 'MAXFARMA CORPORACION 3H S.A.A.'),
('LAB18', 'TECSOLPAR', 'Av. Alfredo Mendiola 15307', 6956723, 'D03', 'TECSOLPAR S.A.'),
('LAB19', 'DERMOGEN FARMA', 'Orquideas 365', 4594218, 'D03', 'DERMOGEN FARMA S.A.'),
('LAB20', 'GEISER PHARMA', 'Calle 53, Manzana 142, Lote17', 6958987, 'D01', 'GEISER PHARMA, S.A.A.')
GO


INSERT INTO Producto(IdProducto, Nombre_Pro, Pre_compra, Pre_venta, Fecha_venc, Stock, IdCategoria, IdProveedor)
VALUES
('PRO01', 'ALPRAZOLAM', 2.50, 4.00, '2021-03-25', 30, 'CAT01', 'LAB01'),
('PRO02', 'AMISULPRIDA', 12.00, 16.00, '2022-09-09', 45, 'CAT03','LAB13'),
('PRO03', 'AMOXICILINA', 10.00, 15.00, '2021-10-27', 35, 'CAT01','LAB10'),
('PRO04', 'HISTIACIL', 9.00, 13.00, '2021-05-18', 48, 'CAT02', 'LAB02'),
('PRO05', 'DONEPEZILO', 8.00, 9.00, '2023-02-13', 55, 'CAT01', 'LAB12'),
('PRO06', 'DOXAZOSINA', 6.00, 8.50, '2021-09-09', 63, 'CAT01','LAB04'),
('PRO07', 'ESCITALOPRAM', 2.00 , 6.00,'2022-10-30', 18,'CAT03' ,'LAB20'),
('PRO08', 'FLUCONAZOL', 3.50, 5.00, '2022-09-26', 28,'CAT01', 'LAB03'),
('PRO09', 'FOSINOPRIL', 20.00, 25.00, '2023-09-18', 24, 'CAT01','LAB06'),
('PRO10', 'MUCOSAN', 10.00 , 13.00, '2021-12-02', 37,'CAT02', 'LAB14'),
('PRO11', 'IRBESARTAN', 7.00, 10.00, '2022-11-19', 56,'CAT03','LAB18'),
('PRO12', 'LAMOTRIGINA', 2.00, 3.50, '2022-08-05', 26, 'CAT01','LAB15'),
('PRO13', 'FLUTOX', 6.00 ,7.50, '2022-06-09', 35, 'CAT02','LAB08'),
('PRO14', 'MOXIFLOXACINO', 7.00, 8.50, '2022-09-22', 34, 'CAT02', 'LAB17') ,
('PRO15', 'NAPROXENO', 11.00, 13.00, '2022-09-22', 20, 'CAT02', 'LAB19'),
('PRO16', 'PARACETAMOL', 3.50, 5.00, '2021-02-28', 100, 'CAT01','LAB04'),
('PRO17', 'PREDNISONA', 2.50, 5.00, '2022-09-10', 80, 'CAT03', 'LAB16'),
('PRO18', 'TUKOL-D', 6.00, 9.00, '2022-03-17', 26,'CAT02', 'LAB02'),
('PRO19', 'QUINAPRIL', 7.00, 9.50, '2022-01-03', 67,'CAT02', 'LAB15'),
('PRO20', 'DOLINTOL', 4.50, 6.50, '2022-07-09', 58, 'CAT03','LAB09'),
('PRO21', 'IBUPROFENO', 2.50, 6.00, '2022-09-11', 39, 'CAT01','LAB17'),
('PRO22', 'TAMSULOSINA',3.00, 6.00, '2022-07-01', 35,'CAT03', 'LAB10'),
('PRO23', 'AZITROMICINA', 6.00, 8.00, '2022-11-09', 44, 'CAT02','LAB08'),
('PRO24', 'ESOMEPRAZOL', 3.00 ,5.50, '2022-08-09', 72, 'CAT01','LAB05'),
('PRO25', 'GLUCOSAMINA', 5.00, 7.50, '2022-12-09', 41, 'CAT03','LAB02'),
('PRO26', 'OMEPRAZOL', 10.00, 13.00, '2021-01-28', 50, 'CAT02', 'LAB09'),
('PRO27', 'RANITIDINA', 7.00, 10.00, '2021-07-15', 49, 'CAT01','LAB01'),
('PRO28', 'MELOXICAM', 12.00, 15.50, '2021-03-21', 28, 'CAT03','LAB07')
GO

INSERT INTO Pedido(Total, Idcliente, Subtotal, IGV)
VALUES
(7.5, 'C001', 7.5, 0.18),
(13.5, 'C003', 13.5, 0.18),
(62, 'C005', 62, 0.18),
(33.5, 'C007', 33.5, 0.18),
(47.5, 'C008', 47.5, 0.18),
(12, 'C006', 12, 0.18),
(8, 'C009', 8, 0.18),
(26, 'C010', 26, 0.18),
(28.5, 'C016', 28.5, 0.18),
(43.5, 'C017', 43.5, 0.18),
(35, 'C019', 35, 0.18),
(26, 'C014', 26, 0.18),
(12, 'C025', 12, 0.18),
(97, 'C024', 97, 0.18),
(6, 'C026', 6, 0.18)
GO

INSERT INTO DetallePedido(IdPedido, IdProducto, Cantidad, Precio)
VALUES
('1', 'PRO13', 1, 7.5),
('2', 'PRO07', 1, 6),
('2', 'PRO13', 1, 7.5),
('3', 'PRO28', 4, 62),
('4', 'PRO15', 2, 26),
('4', 'PRO25', 1, 7.5),
('5', 'PRO25', 1, 7.5),
('5', 'PRO27', 4, 40),
('6', 'PRO22', 2, 12),
('7', 'PRO23', 1, 8),
('8', 'PRO26', 2, 26),
('9', 'PRO19', 3, 28.5),
('10', 'PRO18', 2, 18),
('10', 'PRO14', 3, 25.5),
('11', 'PRO03', 1, 15),
('11', 'PRO02', 1, 16),
('11', 'PRO01', 1, 4),
('12', 'PRO20', 4, 26),
('13', 'PRO22', 2, 12),
('14', 'PRO24', 4, 22),
('14', 'PRO09', 3, 75),
('15', 'PRO07', 1, 6)
GO

--FUNCIONES FECHAS

GO

--DATEPART

SELECT DATEPART(YEAR,'2024-03-05')AS "YEAR"
SELECT DATEPART(MONTH,'2024-03-05')AS [MES]
SELECT DATEPART(DAY,'2024-03-05')AS DIA

--DATENAME

SELECT DATENAME(MONTH,GETDATE())
SELECT DATENAME(DAY,GETDATE())
SELECT DATENAME(WEEK,GETDATE())
SELECT DATENAME(MINUTE,GETDATE())

--FECHA SISTEMA

SELECT GETDATE() AS "HOY ES"

GO
--ESTRUCTURAS CONDICIONALES / TRANSACT(L. PROGRAMACION)
GO

DECLARE @NOMPROD VARCHAR(50),@PRECIO MONEY,@CANT INT,
@TOTAL MONEY,@IGV MONEY,@NETO MONEY

SET @NOMPROD='CAMISETA DE SENATI'
SET @PRECIO=30
SET @CANT=24

SET @TOTAL= @PRECIO * @CANT
SET @IGV=@TOTAL*0.18
SET @NETO=@TOTAL+@IGV
PRINT @TOTAL
PRINT @IGV
PRINT @NETO

--DEVOLVER SEGUN LA EDAD DE UNA PERONA SI MAYOR O MENOR
GO
DECLARE @NOM VARCHAR(40),@MSJ VARCHAR(50),@EDAD INT
SET @NOM='TATIANA INYERLIT'
SET @EDAD=15

	IF @EDAD>=18
		BEGIN
			SET @MSJ='MAYOR DE EDAD'
		END
	ELSE 
		BEGIN
			SET @MSJ='MENOR DE EDAD'
		END
		PRINT @MSJ

/*
CREAR A TRAVES DE UN PROMEDIO DE 4 NOTAS, SU CONDICION SERA_:
MAYOR A 15 EXCELENTE, MAYOR 13 APROBADO,MENOR 13 DESAPROBADO
Y PARA LOS DEMAS PESIMO
*/

--EJERCICIOS

-- DESEO VISUALIZAR EL DIA SI LO ADICIONO 25 DIAS A LA FECHA ACTUAL
GO
SELECT DATENAME(WEEKDAY,DATEADD(DAY,25,GETDATE()))
--COMO SE OBTIENE EL MES DE HOY
SELECT DATENAME(MONTH,GETDATE())
GO
--COMO SE OBTIENE EL DIA DE LA SEMANA DE HOY
SELECT DATENAME(DAY,GETDATE())
GO
--COMO SE ELEVA UN NUMERO A LA POTENCIA
GO
SELECT POWER(2,3)
GO
--COMO SE REPLICA 60 SENATI
 SELECT REPLICATE('SENATI',60)
GO
--COMO SE OBTIENE EL ABSOLUTO DE UN NUMERO
GO
SELECT ABS(-15)
GO
--COMO SE OBTIENE EL DIA EN QUE NACISTE
 SELECT DATENAME(WEEKDAY,'2006-02-15')
GO
--COMO SE CONVIERTE UN TIPO DE NUMERO CON 8 DECIMALES A OTROS 2
GO
SELECT CONVERT(DECIMAL(8,2), 11385.14785956666)
GO
--COMO SE REDONDEA UN NUMERO ENTERO MENOR MAS PROXIMO
GO
SELECT FLOOR(2.03)
GO
--MAYOR MAS PROXIMO
SELECT CEILING(2.03)
GO
SELECT * FROM CLIENTE

--CONVERTIR EL CAMPO NOMBRE CLIENTE A MINUSCULA
GO
SELECT [Nombre_cli],LOWER([Nombre_cli]) FROM Cliente
GO
--COMO IPRIMIR UN MSJE
GO
PRINT 'SU SUELDO ES: S/.'+ CONVERT(CHAR(10),9500)+ ' NUEVOS SOLES'

--MOSTRAR LOS CAMPOS DE LAS TB PRODUCTOS & CATEGORIA
GO
SELECT * FROM Producto INNER JOIN Categoria 
ON Producto.IdCategoria=Categoria.IdCategoria

GO
SELECT P.Nombre_Pro,P.Pre_venta,C.Nombre_Cat  
FROM Producto P INNER JOIN 
Categoria C ON P.IdCategoria=C.IdCategoria
WHERE P.Pre_venta > 14

GO
SELECT E.Nombre_Emp,E.Apellido_Emp, E.edad ,E.Cargo ,D.Nombre_Dis ,PR.Nombre_Prove, PR.Razon_social 
FROM Empleado E INNER JOIN Distrito D
ON E.IdDistrito=D.IdDistrito INNER JOIN Proveedor PR ON
PR.IdDistrito=D.IdDistrito
WHERE E.Edad>30
GO
--COMBINACION EXTERNA
--LEFT JOIN

SELECT P.*,D.Nombre_Dis FROM Distrito D LEFT JOIN Proveedor P ON 
D.IdDistrito=P.IdDistrito
GO
SELECT P.*,D.Nombre_Dis FROM Distrito D RIGHT JOIN Proveedor P ON 
D.IdDistrito=P.IdDistrito

GO

SELECT C.*,PE.IdPedido FROM Pedido PE LEFT JOIN Cliente C ON PE.IdCliente=C.IdCliente
GO
SELECT C.*,PE.IdPedido FROM Pedido PE RIGHT JOIN Cliente C ON PE.IdCliente=C.IdCliente