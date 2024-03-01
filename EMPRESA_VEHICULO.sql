--CREAMOS LA BASE DE DATOS:

CREATE DATABASE [EMPRESA_V]
GO
USE EMPRESA_V
GO
--CREAMOS LAS TABLAS:

CREATE TABLE [dbo].[EMPRESA] (
	[ID_EMPRESA] [int] PRIMARY KEY NOT NULL,
	[DESCRIPCIÓN] [varchar](MAX) NOT NULL, 
	[ID_CODIGO] [int] NULL,
	[COD_CLIENTE] [int] NULL,
	)
GO

CREATE TABLE [dbo].[OFICINA] (
	[ID_CODIGO] [int] PRIMARY KEY NOT NULL,
	[DIRECCIÓN] [varchar](40) NOT NULL,
	[TELÉFONO] [char](9) NOT NULL,
	[ID_AUTOBUS] [int] NULL
	)
GO

CREATE TABLE [dbo].[AUTOBUS] (
	[ID_AUTOBUS] [int] PRIMARY KEY NOT NULL,
	[MATRÍCULA] [varchar](7) NOT NULL,
	[N_PUERTAS] [int] NOT NULL,
	[N_PLAZAS] [int] NOT NULL,
	[CAP_ASIENTOS] [int] NOT NULL,
	[MALETERO] [BIT] CHECK ([MALETERO] IN (0, 1)),
	[EDAD_MINIMA] [int] NOT NULL,
	[ID_GRUPO] [int] NOT NULL,
	[ID_MARCA] [int] NOT NULL,
	[ID_MODELO] [int] NOT NULL
	)
GO

CREATE TABLE [dbo].[CLIENTE] (
	[COD_CLIENTE] [int] PRIMARY KEY NOT NULL,
	[NOMBRE] [varchar](20) NOT NULL,
	[APELLIDO] [varchar](20) NOT NULL,
	[DNI] [char](8) NOT NULL,
	[TELÉFONO] [char](9) NOT NULL,
	[DIRECCIÓN] [varchar](40) NOT NULL,
	[NRO_TARJETA_CREDI] [varchar](20) NOT NULL,
	[ID_AUTOBUS] [int] NOT NULL
	)
GO

CREATE TABLE [dbo].[ALQUILER] (
	[ID_ALQUILER] [int] PRIMARY KEY NOT NULL,
	[PRECIO_TOTAL] [DECIMAL](8,2) NOT NULL,
	[DURACIÓN] [varchar](15) NOT NULL,
	[COD_CLIENTE] [int] NOT NULL,
	[ID_AUTOBUS] [int] NOT NULL,
	[ID_T_SEGURO] [int] NOT NULL
	)
GO

CREATE TABLE [dbo].[GRUPO] (
	[ID_GRUPO] [int] PRIMARY KEY NOT NULL,
	[GRUPO] [char](1) NOT NULL
	)
GO

CREATE TABLE [dbo].[MARCA] (
	[ID_MARCA] [int] PRIMARY KEY NOT NULL,
	[T_MARCA] [varchar](20) NOT NULL
	)
GO

CREATE TABLE [dbo].[MODELO] (
	[ID_MODELO] [int] PRIMARY KEY NOT NULL,
	[T_MODELO] [varchar](20) NOT NULL
	)
GO

CREATE TABLE [dbo].[TIPO_SEGURO] (
	[ID_T_SEGURO] [int] PRIMARY KEY NOT NULL,
	[T_SEGURO] [varchar](35) NOT NULL
	)
GO

--EN ESTA PARTE RELACIONAMOS:

ALTER TABLE [dbo].[EMPRESA] WITH CHECK ADD  CONSTRAINT [FK_EMPRESA_OFICINA] FOREIGN KEY([ID_CODIGO])
REFERENCES [dbo].[OFICINA] ([ID_CODIGO])
GO

ALTER TABLE [dbo].[EMPRESA] WITH CHECK ADD  CONSTRAINT [FK_EMPRESA_CLIENTE] FOREIGN KEY([COD_CLIENTE])
REFERENCES [dbo].[CLIENTE] ([COD_CLIENTE])
GO

ALTER TABLE [dbo].[OFICINA] WITH CHECK ADD  CONSTRAINT [FK_OFICINA_AUTOBUS] FOREIGN KEY([ID_AUTOBUS])
REFERENCES [dbo].[AUTOBUS] ([ID_AUTOBUS])
GO

ALTER TABLE [dbo].[AUTOBUS] WITH CHECK ADD  CONSTRAINT [FK_AUTOBUS_MARCA] FOREIGN KEY([ID_MARCA])
REFERENCES [dbo].[MARCA] ([ID_MARCA])
GO

ALTER TABLE [dbo].[AUTOBUS] WITH CHECK ADD  CONSTRAINT [FK_AUTOBUS_MODELO] FOREIGN KEY([ID_MODELO])
REFERENCES [dbo].[MODELO] ([ID_MODELO])
GO

ALTER TABLE [dbo].[AUTOBUS] WITH CHECK ADD  CONSTRAINT [FK_AUTOBUS_GRUPO] FOREIGN KEY([ID_GRUPO])
REFERENCES [dbo].[GRUPO] ([ID_GRUPO])
GO

ALTER TABLE [dbo].[CLIENTE] WITH CHECK ADD  CONSTRAINT [FK_CLIENTE_AUTOBUS] FOREIGN KEY([ID_AUTOBUS])
REFERENCES [dbo].[AUTOBUS] ([ID_AUTOBUS])
GO

ALTER TABLE [dbo].[ALQUILER] WITH CHECK ADD  CONSTRAINT [FK_ALQUILER_CLIENTE] FOREIGN KEY([COD_CLIENTE])
REFERENCES [dbo].[CLIENTE] ([COD_CLIENTE])
GO

ALTER TABLE [dbo].[ALQUILER] WITH CHECK ADD  CONSTRAINT [FK_ALQUILER_T_SEGURO] FOREIGN KEY([ID_T_SEGURO])
REFERENCES [dbo].[TIPO_SEGURO] ([ID_T_SEGURO])
GO


--ACTIVAMOS EL ACCESO A DIAGRAMAS:
ALTER AUTHORIZATION ON DATABASE::[EMPRESA_V] TO sa

--SECCIÓN DE EJECUCIÓN
SELECT * FROM MARCA

SELECT * FROM MODELO

SELECT * FROM TIPO_SEGURO

SELECT * FROM GRUPO

SELECT * FROM AUTOBUS

SELECT * FROM CLIENTE

SELECT * FROM ALQUILER

SELECT * FROM OFICINA

SELECT * FROM EMPRESA


--COMENZAMOS A RELLENAR LOS DATOS:
INSERT INTO [dbo].[MARCA] VALUES (1,'MERCEDES-BENZ'),
							     (2,'VOLVO'),
								 (3,'Scania')
GO

INSERT INTO [dbo].[MODELO] VALUES (1,'9700'),
								  (2,'K-series'),
								  (3,'Sprinter')
GO

INSERT INTO [dbo].[TIPO_SEGURO] VALUES (1,'Seguro de responsabilidad civil'),
								       (2,'Seguro de robo'),
									   (3,'Seguro de pérdida de uso')
GO

INSERT INTO [dbo].[GRUPO] VALUES (1,'A'),
        						 (2,'B'),
								 (3,'C')
GO

INSERT INTO [dbo].[AUTOBUS] VALUES (1,'AB-1234',2,50,45,1,18,2,1,3),
								   (2,'Y3P-352',2,40,35,1,18,1,2,1),
								   (3,'PS-5321',2,55,50,0,18,3,3,2)
GO

INSERT INTO [dbo].[CLIENTE] VALUES (100,'José Eduardo','Quilca Baras','59623553','945345324','Av. Esteban #152 Santa Anita, Lima','2561 2635 5125 6313',2),
								   (101,'Ezequiel Gonzalo','Rodríguez Sánchez','49521523','990124631','Calle Trujillo #52 Callao, Perú','4000 5214 2615 5126',1),
								   (102,'Federico','Palacios Quispe','64723735','905326453','Calle Los Laureles #632 Miraflores, Lima','7448 0094 4215 9786',3)
GO

INSERT INTO [dbo].[ALQUILER] VALUES (1,200.00,'10 días',102,3,2),
								   (2,500.00,'24 días',100,1,3),
								   (3,350.00,'15 días',101,2,1)
GO

INSERT INTO [dbo].[OFICINA] VALUES (1,'Calle Mercator #456 San Borja, Lima','999531412',2),
								   (2,'Av. Apurímac #126 Callao,Perú','900234153',1),
								   (3,'Av. Arequipa #591 Miraflores, Lima','951260042',3)
GO

INSERT INTO [dbo].[EMPRESA] VALUES (1,'Somos una empresa dedicada a la venta y alquiler de vehículos nuevos y usados. Ofrecemos una amplia gama de opciones, desde automóviles compactos hasta camionetas SUV y camiones comerciales',3,101),
								   (2,'En nuestra empresa, nos dedicamos a la venta y mantenimiento de vehículos de alta calidad. Nos enorgullece ofrecer una amplia selección de automóviles nuevos y usados de las mejores marcas del mercado',1,100),
								   (3,'Somos una empresa dedicada al alquiler de vehículos que busca brindar soluciones de movilidad confiables y convenientes para nuestros clientes',2,102)
GO