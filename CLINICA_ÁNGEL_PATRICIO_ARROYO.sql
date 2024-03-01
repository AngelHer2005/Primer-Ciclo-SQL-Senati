--CREAMOS LA BASE DE DATOS

CREATE DATABASE CLINICA_M
GO
USE CLINICA_M
GO

--CREAMOS LAS TABLAS

CREATE TABLE ESTANCIA(
	[IDINST] [int] NOT NULL PRIMARY KEY,
	[NRODIAS] [int] NOT NULL,
	[FECHAING] [date] NOT NULL,
	[FECHASAL] [date] NOT NULL
)
GO

CREATE TABLE GENERO(
	[IDGENERO] [int] NOT NULL PRIMARY KEY,
	[GENERO] [varchar](30) NOT NULL
)
GO

CREATE TABLE INTERVENCION(
	[IDINT] [int] NOT NULL PRIMARY KEY,
	[HORA_INT] [datetime] NOT NULL,
	[FECHA_INT] [date] NOT NULL,
	[DESCRIPCION] [varchar](100) NULL
)
GO

CREATE TABLE ESPECIALIDAD(
	[CODESP] [int] NOT NULL PRIMARY KEY,
	[NOMBRE] [varchar](30) NOT NULL,
	[DESCRIPCION] [varchar](50) NOT NULL
)
GO

CREATE TABLE DOCTOR(
	[CODDOCTOR] [int] NOT NULL PRIMARY KEY,
	[CODESP] [int] NOT NULL FOREIGN KEY(CODESP) REFERENCES ESPECIALIDAD(CODESP),
	[NOMBRE] [varchar](20) NOT NULL,
	[APELLIDOS] [varchar](30) NOT NULL,
	[EDAD] [int] NOT NULL,
	[NRO_TELEFONO] [char](9) NOT NULL
)
GO

CREATE TABLE TRATAMIENTO(
	[IDTRAT] [int] NOT NULL PRIMARY KEY,
	[CODDOCTOR] INT NOT NULL FOREIGN KEY(CODDOCTOR) REFERENCES DOCTOR(CODDOCTOR),
	[DESCRIPCION] [varchar](100) NOT NULL,
	[NRODIAS] [char](3) NOT NULL,
	[FECHAINI] [date] NOT NULL
)
GO

CREATE TABLE SINTOMA(
	[IDSINTOMA] [int] NOT NULL PRIMARY KEY,
	[IDTRAT] INT NOT NULL FOREIGN KEY(IDTRAT) REFERENCES TRATAMIENTO(IDTRAT),
	[NOMBRE] [varchar](30) NOT NULL,
	[FECHA] [date] NOT NULL,
	[HORA] [datetime] NOT NULL,
	[DIA] [varchar](20) NOT NULL,
	[DESCRIPCION] [varchar](100) NOT NULL
)
GO

CREATE TABLE SEGURO(
	[ID_SEGURO] [int] NOT NULL PRIMARY KEY,
	[TIPO_SEG] [varchar](20) NOT NULL,
	[FECHASEG] [date] NOT NULL,
	[DESCRIPCION] [varchar](max) NOT NULL
)
GO

CREATE TABLE PACIENTE(
	[CODPAC] [int] NOT NULL PRIMARY KEY,
	[IDINST] [int] NOT NULL FOREIGN KEY(IDINST) REFERENCES ESTANCIA(IDINST),
	[IDGENERO] [int] NOT NULL FOREIGN KEY(IDGENERO) REFERENCES GENERO(IDGENERO),
	[IDINT] [int] NOT NULL FOREIGN KEY(IDINT) REFERENCES INTERVENCION(IDINT),
	[ID_SEGURO] [int] NOT NULL FOREIGN KEY(ID_SEGURO) REFERENCES SEGURO(ID_SEGURO),
	[IDSINTOMA] [int] NOT NULL FOREIGN KEY(IDSINTOMA) REFERENCES SINTOMA(IDSINTOMA),
	[DNI_PAC] [char](8) NOT NULL,
	[NOMPAC] [varchar](30) NOT NULL,
	[APEPAC] [varchar](30) NOT NULL,
	[TELPAC] [char](9) NOT NULL,
	[EDAD] [int] NOT NULL,
	[DESCRIPCION] [varchar](100) NOT NULL
)
GO

CREATE TABLE UNIDAD(
	[CODUNIDAD] [int] NOT NULL PRIMARY KEY,
	[CODPAC] [int] NOT NULL FOREIGN KEY(CODPAC) REFERENCES PACIENTE(CODPAC),
	[NOMBRE] [varchar](40) NOT NULL,
	[DESCRIPCION] [varchar](100) NOT NULL
)
GO

CREATE TABLE CLINICA(
	[IDCLINICA] [int] NOT NULL PRIMARY KEY,
	[CODUNIDAD] INT NOT NULL FOREIGN KEY(CODUNIDAD) REFERENCES UNIDAD(CODUNIDAD),
	[NOMBRE] [varchar](30) NOT NULL,
	[DIRECCION] [varchar](50) NOT NULL,
	[TELEFONO] [char](7) NOT NULL
)
GO

CREATE TABLE HISTORIAL(
	[CODHIST] [int] NOT NULL PRIMARY KEY,
	[IDCLINICA] [int] NOT NULL FOREIGN KEY(IDCLINICA) REFERENCES CLINICA(IDCLINICA),
	[FECHA] [date] NOT NULL,
	[HORA] [datetime] NOT NULL,
	[DESCRIPCIÓN] [varchar](30) NOT NULL
)
GO

--Acá va los cambios de tipo de datos que hice en cada tabla:

ALTER TABLE [dbo].[INTERVENCION]
ALTER COLUMN HORA_INT time(7)

ALTER TABLE [dbo].[SEGURO]
ALTER COLUMN TIPO_SEG varchar(30)

ALTER TABLE [dbo].[SINTOMA]
ALTER COLUMN HORA time(7)

ALTER TABLE [dbo].[SINTOMA]
ALTER COLUMN NOMBRE varchar(40)

ALTER TABLE [dbo].[TRATAMIENTO]
ALTER COLUMN DESCRIPCION varchar(150)

ALTER TABLE [dbo].[ESPECIALIDAD]
ALTER COLUMN DESCRIPCION varchar(100)

ALTER TABLE [dbo].[CLINICA]
ALTER COLUMN TELEFONO char(9)

ALTER TABLE [dbo].[HISTORIAL]
ALTER COLUMN HORA time(7)

ALTER TABLE [dbo].[HISTORIAL]
ALTER COLUMN DESCRIPCIÓN varchar(100)

--ACÁ INSERTAMOS ALGUNOS REGISTROS EN CADA CAMPO DE CADA TABLA:
--GÉNERO
INSERT INTO [dbo].[GENERO] VALUES (1,'Masculino'),
								  (2,'Femenino')
GO

--ESPECIALIDAD
INSERT INTO [dbo].[ESPECIALIDAD] VALUES (100,'Ginecólogo','Médico especializado en la salud y el bienestar del sistema reproductivo femenino'),
										(101,'Obstetra','Médico especializado en el cuidado de la mujer durante el embarazo, el parto y el postparto')
GO

--DOCTOR
INSERT INTO [dbo].[DOCTOR] VALUES (100,101,'Carlos Ramiro','Espinoza Ramos',42,'975334523'),
								  (101,100,'Gustavo Leonardo','Bajonero Cavero',57,'955214524')
GO

--ESTANCIA
INSERT INTO [dbo].[ESTANCIA] VALUES (1,30,'01/01/2024','01/02/2024'),
									(2,10,'01/02/2024','11/02/2024')
GO

--SEGURO
INSERT INTO [dbo].[SEGURO] VALUES (1,'Seguro de Vida','03/02/2027','Otorga indemnización a los beneficiarios'),
								  (2,'Seguro de Vida con Ahorro','05/03/2026','Otorga indemnización a los beneficiarios y permite el ahorro de una suma de dinero')
GO

--INTERVENCIÓN
INSERT INTO [dbo].[INTERVENCION] VALUES (1,'14:00','10/01/2024','Se detectó una disminución de los movimientos fetales y presión arterial alta en el paciente'),
									    (2,'18:00','05/02/2024','Se presentó unas irregularidades menstruales y dolor pélvico en el paciente')
GO

--TRATAMIENTO
INSERT INTO [dbo].[TRATAMIENTO] VALUES (1,100,'Se le indicó usar anticonceptivos hormonales y antibióticos durante una semana y si no mejora, se tendrá que realizar una cirugía','7','06/02/2024'),
								       (2,101,'Se le realizará una monitorización fetal y unas maniobras de estimulación fetal al día siguiente, 11/01/2024','14','11/01/2024')
GO

--SINTOMA
INSERT INTO [dbo].[SINTOMA] VALUES (1,2,'Disminución de los movimientos fetales','10/01/2024','14:00','Miércoles','El paciente mencionó la ausencia de movimientos fetales'),
								   (2,1,'Irregularidades menstruales','05/02/2024','18:00','Lunes','El paciente vino con un intenso dolor abdominal')
GO

--PACIENTE
INSERT INTO [dbo].[PACIENTE] VALUES (100,2,1,1,2,1,'42462142','Lucia','Mendoza Peña','952351232',25,'Una mujer casada y que espera una bella bendición'),
								   (101,1,2,2,2,2,'52351234','Carmen','Cruz Palacios','925162356',38,'Una mujer que siente un intenso dolor abdominal desde hace días')
GO

--UNIDAD
INSERT INTO [dbo].[UNIDAD] VALUES (100,100,'Centro de Obstetricia','Este centro se especializa en la atención de embarazos de alto riesgo y condiciones perinatales'),
								   (101,101,'Centro de Ginecología','Este centro ofrece atención especializada en la salud ginecológica')
GO

--CLINICA
INSERT INTO [dbo].[CLINICA] VALUES (1,101,'Clínica Salud Integral','Av. Oscar R. Benavides 1234 Callao, Perú','994241524'),
								   (2,100,'Centro de Salud Familiar','Calle Los Laureles 567 San Isidro, Lima, Perú','952213590')
GO

--HISTORIAL
INSERT INTO [dbo].[HISTORIAL] VALUES (100,2,'01/01/2024','11:00','Una mujer acompañada de su marido pidió un espacio para la sección de Obstetricia'),
								     (101,1,'01/02/2024','9:00','Una mujer pidió un espacio para la sección de Ginecología')
GO

--Acá va la ejecución de cada tabla:
SELECT * FROM GENERO

SELECT * FROM ESPECIALIDAD

SELECT * FROM ESTANCIA

SELECT * FROM SEGURO

SELECT * FROM INTERVENCION

SELECT * FROM DOCTOR

SELECT * FROM TRATAMIENTO

SELECT * FROM SINTOMA

SELECT * FROM PACIENTE

SELECT * FROM UNIDAD

SELECT * FROM CLINICA

SELECT * FROM HISTORIAL

ALTER AUTHORIZATION ON DATABASE::[CLINICA_M] TO sa
