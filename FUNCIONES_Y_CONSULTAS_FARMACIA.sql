--CREAMOS LA BASE DE DATOS:
CREATE DATABASE PET_HOTEL
GO
USE PET_HOTEL
GO

--CREAMOS LAS TABLAS:

CREATE TABLE RAZA(
ID_RAZA CHAR(4) PRIMARY KEY CHECK(ID_RAZA LIKE 'R[0-9][0-9][0-9]'),
TIPO_RAZA VARCHAR(20) NOT NULL UNIQUE,
DESCRIPCIÓN VARCHAR(MAX) NOT NULL
)
GO

CREATE TABLE TARJETA(
ID_TARJETA CHAR(4) PRIMARY KEY CHECK(ID_TARJETA LIKE 'T[0-9][0-9][0-9]'),
ANTIPULGAS BIT NOT NULL CHECK(ANTIPULGAS IN (0, 1)),
DESPARASITACIÓN BIT NOT NULL CHECK(DESPARASITACIÓN IN (0, 1)),
INDICACIÓN VARCHAR(50),
DESCRIPCIÓN VARCHAR(MAX)
)
GO

CREATE TABLE VACUNA(
ID_VACUNA CHAR(4) PRIMARY KEY CHECK(ID_VACUNA LIKE 'V[0-9][0-9][0-9]'),
TIPO_VACUNA VARCHAR(40) NOT NULL UNIQUE,
DESCRIPCIÓN VARCHAR(MAX)
)
GO

CREATE TABLE CANINO(
ID_CANINO CHAR(5) PRIMARY KEY CHECK(ID_CANINO LIKE 'CA[0-9][0-9][0-9]'),
NOMBRE VARCHAR(20) NOT NULL,
PESO INT NOT NULL,
EDAD INT NOT NULL,
TAMAÑO CHAR(10) NOT NULL,
ID_TARJETA CHAR(4) NOT NULL FOREIGN KEY(ID_TARJETA) REFERENCES TARJETA(ID_TARJETA),
ID_RAZA CHAR(4) NOT NULL FOREIGN KEY(ID_RAZA) REFERENCES RAZA(ID_RAZA)
)
GO

CREATE TABLE PERRO_VACUNADO(
ID_PERRO_VAC CHAR(5) PRIMARY KEY CHECK(ID_PERRO_VAC LIKE 'PV[0-9][0-9][0-9]'),
ID_CANINO CHAR(5) NOT NULL FOREIGN KEY(ID_CANINO) REFERENCES CANINO(ID_CANINO),
ID_VACUNA CHAR(4) NOT NULL FOREIGN KEY(ID_VACUNA) REFERENCES VACUNA(ID_VACUNA)
)
GO

CREATE TABLE HABITACION_ESTANDAR(
ID_ESTANDAR CHAR(4) PRIMARY KEY CHECK(ID_ESTANDAR LIKE 'E[0-9][0-9][0-9]'),
DESCRIPCIÓN VARCHAR(MAX) NULL
)
GO

CREATE TABLE HABITACION_PREMIUM(
ID_PREMIUM CHAR(5) PRIMARY KEY CHECK(ID_PREMIUM LIKE 'PR[0-9][0-9][0-9]'),
DESCRIPCIÓN VARCHAR(MAX) NULL
)
GO

CREATE TABLE PET_HOTEL(
ID_PET CHAR(4) PRIMARY KEY CHECK(ID_PET LIKE 'P[0-9][0-9][0-9]'),
DIRECCIÓN VARCHAR(40) NOT NULL,
TELÉFONO CHAR(9) NOT NULL,
NOMBRE VARCHAR(50) NOT NULL UNIQUE
)
GO

CREATE TABLE HABITACION_CANINA(
ID_HABI CHAR(4) PRIMARY KEY CHECK(ID_HABI LIKE 'H[0-9][0-9][0-9]'),
NRO_HABI CHAR(3) NOT NULL UNIQUE,
ID_CANINO CHAR(5) NOT NULL FOREIGN KEY(ID_CANINO) REFERENCES CANINO(ID_CANINO),
ID_PREMIUM CHAR(5) NULL FOREIGN KEY(ID_PREMIUM) REFERENCES HABITACION_PREMIUM(ID_PREMIUM),
ID_ESTANDAR CHAR(4) NULL FOREIGN KEY(ID_ESTANDAR) REFERENCES HABITACION_ESTANDAR(ID_ESTANDAR),
ID_PET CHAR(4) NULL FOREIGN KEY(ID_PET) REFERENCES PET_HOTEL(ID_PET)
)
GO

CREATE TABLE CLIENTE(
ID_CLIENTE CHAR(4) PRIMARY KEY CHECK(ID_CLIENTE LIKE 'C[0-9][0-9][0-9]'),
NOMBRE VARCHAR(20) NOT NULL,
APELLIDO VARCHAR(20) NOT NULL,
DNI CHAR(8) NOT NULL UNIQUE,
TELÉFONO CHAR(9) NOT NULL UNIQUE,
DIRECCIÓN VARCHAR(40) NOT NULL UNIQUE
)
GO

CREATE TABLE FACTURA(
ID_FACTURA CHAR(4) PRIMARY KEY CHECK(ID_FACTURA LIKE 'F[0-9][0-9][0-9]'),
SERVICIOS_AD VARCHAR(100) NOT NULL,
COSTO_TOTAL MONEY NOT NULL,
ID_CLIENTE CHAR(4) NOT NULL FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE)
)
GO

CREATE TABLE RESERVA(
ID_RESERVA CHAR(4) PRIMARY KEY CHECK(ID_RESERVA LIKE 'R[0-9][0-9][0-9]'),
FECHA_INI DATE NOT NULL DEFAULT(GETDATE()),
FECHA_SAL DATE NOT NULL,
PRECIO MONEY NOT NULL,
ID_CLIENTE CHAR(4) NOT NULL FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE),
ID_CANINO CHAR(5) NOT NULL FOREIGN KEY(ID_CANINO) REFERENCES CANINO(ID_CANINO),
ID_PET CHAR(4) NOT NULL FOREIGN KEY(ID_PET) REFERENCES PET_HOTEL(ID_PET)
)
GO

CREATE TABLE HISTORIAL(
ID_HISTORIAL CHAR(5) PRIMARY KEY CHECK(ID_HISTORIAL LIKE 'HI[0-9][0-9][0-9]'),
DESCRIPCIÓN VARCHAR(MAX),
ID_RESERVA CHAR(4) NOT NULL FOREIGN KEY(ID_RESERVA) REFERENCES RESERVA(ID_RESERVA)
)
GO

--INSERTAMOS 5 REGISTROS EN CADA CAMPO DE CADA TABLA:
INSERT INTO RAZA VALUES ('R001', 'Labrador Retriever', 'Amigable y extrovertido'),
						('R002', 'Pastor Alemán', 'Inteligente y versátil'),
						('R003', 'Golden Retriever', 'Amigable y tolerante'),
						('R004', 'Bulldog', 'Dócil y decidido'),
						('R005', 'POODLE', 'Inteligente y activo'),
						('R006', 'Beagle', 'Alegre y amigable'),
						('R007', 'Siberian Husky', 'Energético y sociable'),
						('R008', 'Dachshund', 'Valiente y curioso'),
						('R009', 'Boxer', 'Fuerte y leal'),
						('R010', 'Shih Tzu', 'Afable y juguetón'),
						('R011', 'Chihuahua', 'Pequeño pero valiente'),
						('R012', 'Doberman', 'Alerta y valiente'),
						('R013', 'Cocker Spaniel', 'Afectuoso y juguetón'),
						('R014', 'Great Dane', 'Gentil y amistoso'),
						('R015', 'Pomeranian', 'Vivaz y extrovertido'),
						('R016', 'Shiba Inu', 'Leal y alerta'),
						('R017', 'Bichón Frisé', 'Alegre y juguetón'),
						('R018', 'Pug', 'Encantador y tranquilo'),
						('R019', 'Husky Siberiano', 'Energético y amigable'),
						('R020', 'Maltese', 'Carismático y cariñoso')
GO

INSERT INTO TARJETA VALUES ('T001', 0, 1, 'Tratamiento antipulgas y desparasitación mensual', 'Producto utilizado: XWY'),
						   ('T002', 0, 1, 'Desparasitación mensual', 'Producto utilizado: HCC'),
						   ('T003', 1, 0, 'Tratamiento antipulgas mensual', 'Producto utilizado: DPI'),
						   ('T004', 0, 0, 'Sin tratamiento', 'No se aplicaron tratamientos este mes'),
						   ('T005', 1, 1, 'Tratamiento antipulgas y desparasitación quincenal', 'Producto utilizado: LNA'),
						   ('T006', 1, 0, 'Tratamiento antipulgas mensual', 'Producto utilizado: XWZ'),
						   ('T007', 0, 1, 'Desparasitación mensual', 'Producto utilizado: AAE'),
						   ('T008', 1, 1, 'Tratamiento antipulgas y desparasitación mensual', 'Producto utilizado: DDP'),
						   ('T009', 0, 0, 'Sin tratamiento', 'No se aplicaron tratamientos este mes'),
						   ('T010', 1, 1, 'Tratamiento antipulgas y desparasitación quincenal', 'Producto utilizado: GPT'),
						   ('T011', 0, 1, 'Desparasitación mensual', 'Producto utilizado: JPP'),
						   ('T012', 1, 0, 'Tratamiento antipulgas mensual', 'Producto utilizado: MPO'),
						   ('T013', 0, 0, 'Sin tratamiento', 'No se aplicaron tratamientos este mes'),
						   ('T014', 1, 1, 'Tratamiento antipulgas y desparasitación quincenal', 'Producto utilizado: PQS'),
						   ('T015', 0, 1, 'Desparasitación mensual', 'Producto utilizado: SYU'),
						   ('T016', 0, 1, 'Desparasitación mensual', 'Producto utilizado: UJW'),
						   ('T017', 1, 0, 'Tratamiento antipulgas mensual', 'Producto utilizado: XAZ'),
						   ('T018', 0, 0, 'Sin tratamiento', 'No se aplicaron tratamientos este mes'),
						   ('T019', 1, 1, 'Tratamiento antipulgas y desparasitación mensual', 'Producto utilizado: ACB'),
						   ('T020', 0, 1, 'Desparasitación mensual', 'Producto utilizado: FED')
GO

INSERT INTO CANINO VALUES ('CA001', 'Max', 25, 3, 'Mediano', 'T001', 'R001'),
						  ('CA002', 'Bella', 15, 2, 'Pequeño', 'T002', 'R001'),
						  ('CA003', 'Rocky', 30, 4, 'Grande', 'T003', 'R004'),
						  ('CA004', 'Luna', 18, 1, 'Pequeño', 'T012', 'R003'),
						  ('CA005', 'Coco', 22, 5, 'Mediano', 'T005', 'R004'),
						  ('CA006', 'Lucky', 20, 3, 'Mediano', 'T006', 'R006'),
						  ('CA007', 'Daisy', 12, 2, 'Pequeño', 'T007', 'R008'),
						  ('CA008', 'Charlie', 28, 4, 'Grande', 'T008', 'R006'),
						  ('CA009', 'Milo', 16, 1, 'Pequeño', 'T009', 'R015'),
						  ('CA010', 'Ruby', 24, 5, 'Mediano', 'T010', 'R013'),
						  ('CA011', 'Leo', 18, 3, 'Mediano', 'T011', 'R017'),
						  ('CA012', 'Sophie', 14, 2, 'Pequeño', 'T012', 'R001'),
						  ('CA013', 'Maximus', 32, 4, 'Grande', 'T013', 'R019'),
						  ('CA014', 'Bentley', 19, 1, 'Pequeño', 'T014', 'R014'),
						  ('CA015', 'Chloe', 26, 5, 'Mediano', 'T015', 'R018'),
						  ('CA016', 'Rosie', 17, 2, 'Pequeño', 'T012', 'R018'),
						  ('CA017', 'Zeus', 30, 4, 'Grande', 'T017', 'R014'),
						  ('CA018', 'Mia', 14, 1, 'Pequeño', 'T018', 'R006'),
						  ('CA019', 'Rocky Jr.', 22, 3, 'Mediano', 'T019', 'R008'),
						  ('CA020', 'Lola', 19, 5, 'Mediano', 'T020', 'R002')
GO

INSERT INTO VACUNA VALUES ('V001', 'Ehrlichiosis Canina', 'Vacuna contra la ehrlichiosis en perros'),
						  ('V002', 'Babesiosis Canina', 'Vacuna contra la babesiosis en perros'),
						  ('V003', 'Leishmaniasis Canina', 'Vacuna contra la leishmaniasis en perros'),
						  ('V004', 'Anaplasmosis Canina', 'Vacuna contra la anaplasmosis en perros'),
						  ('V005', 'Borreliosis Canina', 'Vacuna contra la borreliosis en perros'),
						  ('V006', 'Tos de las Perreras', 'Vacuna contra la tos de las perreras en perros'),
						  ('V007', 'Dermatitis Atópica', 'Vacuna contra la dermatitis atópica en perros'),
						  ('V008', 'Tétanos Canino', 'Vacuna contra el tétanos en perros'),
						  ('V009', 'Hepatitis Canina', 'Vacuna contra la hepatitis canina'),
						  ('V010', 'Leptospirosis Canina', 'Vacuna contra la leptospirosis en perros'),
						  ('V011', 'Rabia', 'Vacuna contra la rabia en perros'),
						  ('V012', 'Moquillo Canino', 'Vacuna contra el moquillo en perros'),
						  ('V013', 'Parvovirosis Canina', 'Vacuna contra la parvovirosis en perros'),
						  ('V014', 'Influenza Canina', 'Vacuna contra la influenza canina'),
						  ('V015', 'Coronavirus Entérico', 'Vacuna contra el coronavirus entérico en perros'),
						  ('V016', 'Lyme Canino', 'Vacuna contra la enfermedad de Lyme en perros'),
						  ('V017', 'Giardiasis Canina', 'Vacuna contra la giardiasis en perros'),
						  ('V018', 'Parainfluenza Canina', 'Vacuna contra la parainfluenza canina'),
						  ('V019', 'Toxoplasmosis', 'Vacuna contra la toxoplasmosis en perros'),
						  ('V020', 'Refuerzo Babesiosis Canina', 'Vacuna contra la babesiosis en perros')
GO

INSERT INTO PERRO_VACUNADO VALUES('PV001','CA003','V020'),
								 ('PV002','CA004','V003'),
								 ('PV003','CA002','V001'),
								 ('PV004','CA015','V005'),
								 ('PV005','CA020','V003'),
								 ('PV006','CA001','V013'),
								 ('PV007','CA004','V001'),
								 ('PV008','CA003','V001'),
								 ('PV009','CA005','V003'),
								 ('PV010','CA017','V003'),
								 ('PV011','CA012','V004'),
								 ('PV012','CA011','V010'),
								 ('PV013','CA010','V011'),
								 ('PV014','CA002','V020'),
								 ('PV015','CA002','V016'),
								 ('PV016','CA003','V015'),
								 ('PV017','CA004','V007'),
								 ('PV018','CA006','V003'),
								 ('PV019','CA015','V011'),
								 ('PV020','CA020','V009')
GO

INSERT INTO HABITACION_ESTANDAR VALUES('E001', 'Habitación estándar con cama individual y baño compartido'),
                                      ('E002', 'Habitación estándar con cama doble y baño privado'),
                                      ('E003', 'Habitación estándar con dos camas individuales y vistas al jardín'),
                                      ('E004', 'Habitación estándar con cama queen-size y balcón'),
                                      ('E005', 'Habitación estándar con dos camas dobles y desayuno incluido'),
                                      ('E006', 'Habitación estándar con cama king-size y minibar'),
                                      ('E007', 'Habitación estándar con cama individual y escritorio'),
                                      ('E008', 'Habitación estándar con dos camas individuales y TV de pantalla plana'),
                                      ('E009', 'Habitación estándar con cama doble y sofá-cama'),
                                      ('E010', 'Habitación estándar con cama queen-size y acceso a la piscina'),
                                      ('E011', 'Habitación estándar con dos camas dobles y servicio de habitaciones'),
                                      ('E012', 'Habitación estándar con cama king-size y área de estar'),
                                      ('E013', 'Habitación estándar con cama individual y vistas panorámicas'),
                                      ('E014', 'Habitación estándar con cama doble y jacuzzi'),
                                      ('E015', 'Habitación estándar con dos camas individuales y bañera de hidromasaje'),
                                      ('E016', 'Habitación estándar con cama queen-size y gimnasio privado'),
                                      ('E017', 'Habitación estándar con dos camas dobles y acceso a la terraza'),
                                      ('E018', 'Habitación estándar con cama king-size y desayuno en la cama'),
                                      ('E019', 'Habitación estándar con cama individual y servicio de lavandería'),
                                      ('E020', 'Habitación estándar con dos camas individuales y cocina americana')
GO

INSERT INTO HABITACION_PREMIUM VALUES('PR001', 'Habitación premium con cama ortopédica y área de juegos para perros pequeños'),
									 ('PR002', 'Habitación premium con piscina privada para perros medianos'),
									 ('PR003', 'Habitación premium con jardín exclusivo para perros grandes'),
									 ('PR004', 'Habitación premium con cama de lujo y ventana panorámica para perros pequeños'),
									 ('PR005', 'Habitación premium con sala de estar y acceso directo al parque para perros medianos'),
									 ('PR006', 'Habitación premium con cama ortopédica y área de juegos para perros grandes'),
									 ('PR007', 'Habitación premium con piscina privada para perros pequeños'),
									 ('PR008', 'Habitación premium con jardín exclusivo para perros medianos'),
									 ('PR009', 'Habitación premium con cama de lujo y ventana panorámica para perros grandes'),
 									 ('PR010', 'Habitación premium con sala de estar y acceso directo al parque para perros pequeños'),
									 ('PR011', 'Habitación premium con cama ortopédica y área de juegos para perros medianos'),
									 ('PR012', 'Habitación premium con piscina privada para perros grandes'),
									 ('PR013', 'Habitación premium con jardín exclusivo para perros pequeños'),
									 ('PR014', 'Habitación premium con cama de lujo y ventana panorámica para perros medianos'),
									 ('PR015', 'Habitación premium con sala de estar y acceso directo al parque para perros grandes'),
									 ('PR016', 'Habitación premium con cama ortopédica y área de juegos para perros pequeños'),
									 ('PR017', 'Habitación premium con piscina privada para perros medianos'),
									 ('PR018', 'Habitación premium con jardín exclusivo para perros grandes'),
									 ('PR019', 'Habitación premium con cama de lujo y ventana panorámica para perros pequeños'),
									 ('PR020', 'Habitación premium con sala de estar y acceso directo al parque para perros medianos')
GO

INSERT INTO PET_HOTEL VALUES('P001', 'Calle Paracas #23, Lima', '995241652', 'Hotel Canino Feliz'),
							('P002', 'Avenida Mayo #521, Arequipa', '988231521', 'Pet Paradise'),
							('P003', 'Calle Quilca #629, Trujillo', '998521340', 'Doggy Haven'),
							('P004', 'Calle Cusco #521, Chiclayo', '994251342', 'Paws Palace'),
							('P005', 'Calle Junín #983, Cusco', '904325145', 'Barkington Hotel'),
							('P006', 'Avenida Amazonas #234, Lima', '987654321', 'Happy Tails Retreat'),
							('P007', 'Calle Ucayali #789, Arequipa', '976543210', 'Pampered Paws Resort'),
							('P008', 'Calle Tacna #345, Trujillo', '955432109', 'Tail Wag Inn'),
							('P009', 'Avenida Piura #123, Chiclayo', '966543210', 'Snuggle Pups Lodge'),
							('P010', 'Calle Puno #567, Cusco', '933210987', 'Cozy Canine Cottage'),
							('P011', 'Avenida Huancayo #876, Lima', '922109876', 'Furry Friends Haven'),
							('P012', 'Calle Ica #456, Arequipa', '977654321', 'Woofington Palace'),
							('P013', 'Calle Lambayeque #765, Trujillo', '955678901', 'Purr-fect Paws Hotel'),
							('P014', 'Avenida Cajamarca #543, Chiclayo', '944321098', 'Pawesome Retreat'),
							('P015', 'Calle Huaraz #987, Cusco', '911234567', 'Fluffy Friends Lodge'),
							('P016', 'Avenida Chincha #876, Lima', '922345678', 'Whiskers Wonderland'),
							('P017', 'Calle Moquegua #543, Arequipa', '977890123', 'Tailored Tails Resort'),
							('P018', 'Calle Chimbote #765, Trujillo', '955678901', 'Cuddly Companions Inn'),
							('P019', 'Avenida Tumbes #543, Chiclayo', '944321098', 'Paw-sitively Purrfect Lodge'),
							('P020', 'Calle Iquitos #987, Cusco', '911234567', 'Fuzzy Friends Retreat')
GO

INSERT INTO HABITACION_CANINA VALUES('H001', '101', 'CA001', 'PR001', NULL,'P004'),
									('H002', '102', 'CA002', NULL, 'E002','P001'),
									('H003', '103', 'CA003', 'PR003', NULL, 'P003'),
									('H004', '104', 'CA004', 'PR004', NULL,'P001'),
									('H005', '105', 'CA005', NULL, 'E005','P004'),
									('H006', '106', 'CA006', 'PR006', NULL,'P020'),
									('H007', '107', 'CA007', 'PR007', NULL,'P015'),
									('H008', '108', 'CA008', 'PR008', NULL,'P012'),
									('H009', '109', 'CA009', NULL, 'E009','P018'),
									('H010', '110', 'CA010', NULL, 'E010','P004'),
									('H011', '111', 'CA011', NULL, 'E011','P015'),
									('H012', '112', 'CA012', NULL, 'E012','P013'),
									('H013', '113', 'CA013', NULL, 'E013','P012'),
									('H014', '114', 'CA014', NULL, 'E014','P020'),
									('H015', '115', 'CA015', 'PR015', NULL,'P003'),
									('H016', '116', 'CA016', 'PR016', NULL,'P003'),
									('H017', '117', 'CA017', 'PR017', NULL,'P007'),
									('H018', '118', 'CA018', NULL, 'E018','P008'),
									('H019', '119', 'CA019', 'PR019', NULL,'P019'),
									('H020', '120', 'CA020', NULL, 'E020','P016')
GO

INSERT INTO CLIENTE VALUES('C001', 'Juan', 'Pérez', '12345679', '987654321', 'Calle Ayacucho #324, Lima'),
						  ('C002', 'María', 'Gómez', '87654321', '965786456', 'Avenida Cajamarca #942, Santa Rosa'),
						  ('C003', 'Carlos', 'Rodríguez', '56789112', '943567891', 'Calle San José #524, Callao'),
						  ('C004', 'Laura', 'Hernández', '34569890', '976345243', 'Calle Júpiter #155, Callao'),
						  ('C005', 'Javier', 'López', '90123456', '945809743', 'Avenida Quilca #421, Callao'),
						  ('C006', 'Ana', 'Martínez', '65432109', '964324578', 'Calle Huancavelica #210, Lima'),
						  ('C007', 'Miguel', 'Sánchez', '89012395', '976543211', 'Avenida La Marina #735, San Isidro'),
						  ('C008', 'Elena', 'Ramírez', '43210987', '968245789', 'Calle Tacna #621, Magdalena'),
						  ('C009', 'Pedro', 'Fernández', '09876543', '985125852', 'Avenida El Sol #124, Surco'),
						  ('C010', 'Silvia', 'Díaz', '56789012', '901596357', 'Calle Las Flores #512, San Borja'),
						  ('C011', 'Roberto', 'García', '12345678', '901226848', 'Avenida Los Pinos #789, Miraflores'),
						  ('C012', 'Carolina', 'Moreno', '78901234', '901238526', 'Calle Los Olivos #345, San Miguel'),
						  ('C013', 'Francisco', 'Peralta', '23456789', '901234753', 'Avenida Los Robles #987, La Molina'),
						  ('C014', 'Valeria', 'Cordova', '89012345', '901234548', 'Calle Las Palmeras #654, San Isidro'),
						  ('C015', 'Hugo', 'Navarro', '45678901', '901234567', 'Avenida Los Laureles #231, Surquillo'),
						  ('C016', 'Lorena', 'Vargas', '67890123', '951156357', 'Calle Las Orquídeas #432, Barranco'),
						  ('C017', 'Felipe', 'Guerrero', '34567890', '901753159', 'Avenida Los Alamos #567, La Victoria'),
						  ('C018', 'Daniela', 'Romero', '01234567', '951369741', 'Calle Los Cerezos #876, Chorrillos'),
						  ('C019', 'Ricardo', 'Salazar', '89014345', '925486293', 'Avenida Los Pájaros #543, Jesús María'),
						  ('C020', 'Camila', 'Chávez', '23956789', '986243576', 'Calle Los Flamencos #789, Pueblo Libre')
GO

INSERT INTO FACTURA VALUES('F001', 'Servicio estándar', 80.00, 'C001'),
						  ('F002', 'Servicio premium', 100.00,'C016'),
						  ('F003', 'Servicio premium con tratamientos adicionales', 120.00,'C013'),
						  ('F004', 'Servicio estándar con descuento', 75.00,'C015'),
						  ('F005', 'Servicio premium con descuento', 110.00,'C012'),
						  ('F006', 'Estancia estándar para perro pequeño', 40.00,'C002'),
						  ('F007', 'Estancia estándar para perro mediano', 55.00,'C020'),
						  ('F008', 'Estancia estándar para perro grande', 70.00,'C003'),
						  ('F009', 'Suite premium para perro pequeño', 70.00,'C003'),
						  ('F010', 'Suite premium para perro mediano', 90.00,'C009'),
						  ('F011', 'Suite premium para perro grande', 100.00,'C010'),
						  ('F012', 'Estancia estándar con baño y cepillado', 90.00,'C002'),
						  ('F013', 'Suite premium con paseo adicional', 90.00,'C015'),
						  ('F014', 'Estancia estándar con alimentación especial', 70.00,'C001'),
						  ('F015', 'Suite premium con entrenamiento personalizado', 140.00,'C007'),
						  ('F016', 'Estancia estándar con descuento para estancias largas', 65.00,'C018'),
						  ('F017', 'Suite premium con descuento para clientes habituales', 75.00,'C019'),
						  ('F018', 'Estancia estándar con juguetes adicionales', 85.00,'C004'),
						  ('F019', 'Suite premium con servicio de spa para perros', 140.00,'C005'),
						  ('F020', 'Estancia estándar con servicio de fotografía', 85.00,'C001')
GO

INSERT INTO RESERVA VALUES('R001', GETDATE(), GETDATE() + 7, 60.00, 'C001', 'CA001','P007'),
						  ('R002', GETDATE(), GETDATE() + 10, 80.00, 'C002', 'CA002','P012'),
						  ('R003', GETDATE(), GETDATE() + 5, 100.00, 'C003', 'CA003','P020'),
						  ('R004', GETDATE(), GETDATE() + 14, 50.00, 'C004', 'CA004','P016'),
						  ('R005', GETDATE(), GETDATE() + 8, 75.00, 'C005', 'CA005','P007'),
						  ('R006', GETDATE(), GETDATE() + 12, 90.00, 'C006', 'CA006','P020'),
						  ('R007', GETDATE(), GETDATE() + 6, 110.00, 'C007', 'CA007','P007'),
						  ('R008', GETDATE(), GETDATE() + 9, 120.00, 'C008', 'CA008','P012'),
						  ('R009', GETDATE(), GETDATE() + 15, 70.00, 'C009', 'CA009','P018'),
						  ('R010', GETDATE(), GETDATE() + 11, 85.00, 'C010', 'CA010','P016'),
						  ('R011', GETDATE(), GETDATE() + 7, 95.00, 'C011', 'CA011','P006'),
                          ('R012', GETDATE(), GETDATE() + 14, 110.00, 'C012', 'CA012','P003'),
						  ('R013', GETDATE(), GETDATE() + 8, 75.00, 'C013', 'CA013','P007'),
						  ('R014', GETDATE(), GETDATE() + 10, 100.00, 'C014', 'CA014','P001'),
						  ('R015', GETDATE(), GETDATE() + 5, 60.00, 'C015', 'CA015','P003'),
						  ('R016', GETDATE(), GETDATE() + 13, 80.00, 'C016', 'CA016','P020'),
						  ('R017', GETDATE(), GETDATE() + 7, 120.00, 'C017', 'CA017','P004'),
						  ('R018', GETDATE(), GETDATE() + 9, 55.00, 'C018', 'CA018','P014'),
						  ('R019', GETDATE(), GETDATE() + 12, 70.00, 'C019', 'CA019','P017'),
						  ('R020', GETDATE(), GETDATE() + 6, 105.00, 'C020', 'CA020','P007')
GO

INSERT INTO HISTORIAL VALUES('HI001', 'Historial médico del perro durante la estancia en el hotel.','R003'),
							('HI002', 'Observaciones y tratamientos realizados al perro.','R007'),
							('HI003', 'Registro de comportamiento y actividades diarias del perro.','R012'),
							('HI004', 'Notas sobre la alimentación y preferencias del perro.','R020'),
							('HI005', 'Seguimiento de la salud y bienestar del perro en el hotel.','R002'),
							('HI006', 'Informe diario sobre la actividad física del perro.','R007'),
							('HI007', 'Seguimiento de la medicación y cuidados especiales.','R003'),
							('HI008', 'Registro de juegos y socialización con otros perros.','R012'),
							('HI009', 'Observaciones sobre el sueño y descanso del perro.','R007'),
							('HI010', 'Notas sobre posibles alergias o sensibilidades.','R012'),
							('HI011', 'Registro de paseos y tiempo de juego al aire libre.','R002'),
							('HI012', 'Seguimiento de la temperatura corporal y signos vitales.','R003'),
							('HI013', 'Observaciones sobre la interacción con el personal del hotel.','R005'),
							('HI014', 'Registro de eventos especiales o cambios en el entorno.','R018'),
							('HI015', 'Notas sobre la respuesta a comandos y entrenamiento.','R019'),
							('HI016', 'Informe detallado sobre la dieta y consumo de agua.','R020'),
							('HI017', 'Seguimiento de la higiene y cuidado personal del perro.','R003'),
							('HI018', 'Registro de posibles comportamientos inusuales o preocupantes.','R005'),
							('HI019', 'Observaciones sobre la adaptación del perro al entorno.','R006'),
							('HI020', 'Seguimiento de eventos médicos y consultas veterinarias.','R010')
GO

--EJECUTAMOS LAS TABLAS:

SELECT * FROM PET_HOTEL

SELECT * FROM RESERVA

SELECT * FROM HISTORIAL

SELECT * FROM CLIENTE

SELECT * FROM FACTURA

SELECT * FROM CANINO

SELECT * FROM HABITACION_CANINA

SELECT * FROM HABITACION_ESTANDAR

SELECT * FROM HABITACION_PREMIUM

SELECT * FROM TARJETA

SELECT * FROM VACUNA

SELECT * FROM RAZA


--CONSULTAS BÁSICAS:
----CANINO
---QUE MUESTRE LA EDAD DE LOS PERROS QUE TIENEN 3 DE EDAD
SELECT EDAD FROM CANINO
WHERE EDAD LIKE(3)

---QUE MUESTRE DEL PERRO LOS DE PESO MAS DE 15
SELECT PESO FROM CANINO
WHERE PESO < 15

---QUE MUESTRE QUE PERROS ESTÁN ENTRE LOS TAMAÑOS PEQUEÑO Y MEDIANO
SELECT ID_CANINO AS 'NÚMERO PERRO',
	   NOMBRE AS 'NOMBRE PERRO',
	   TAMAÑO AS 'TAMAÑO PERRO'
FROM CANINO
WHERE TAMAÑO IN ('Pequeño', 'Mediano')


-----------------------------------------------------------
----CLIENTE
--MUESTRA LOS APELLIDOS QUE TIENEN LA Z DE ULTIMO
SELECT * FROM CLIENTE
WHERE APELLIDO LIKE('%Z')

--MUESTRA LA DIRRECION QUE SEAN AVENIDA
SELECT * FROM CLIENTE
WHERE DIRECCIÓN LIKE ('A%')

--MUESTRA LA DIRRECION QUE SEAN CALLE
SELECT * FROM CLIENTE
WHERE DIRECCIÓN LIKE ('C%')

--MUESTRA LOS NOMBRES QUE TENGAN LA C DE INICIAL
SELECT * FROM CLIENTE
WHERE NOMBRE LIKE('C%')


-------------------------------------------------------
---PET_HOTEL
--MUESTRA LOS NOMBRES QUE TENGAN DE INICIAL LA P
SELECT NOMBRE FROM PET_HOTEL
WHERE NOMBRE LIKE('P%')

--MUESTRA LOS NÚMEROS TELÉFONICOS QUE COMIENCEN POR 982
SELECT TELÉFONO FROM PET_HOTEL
WHERE TELÉFONO LIKE('982')

---MUESTRA LA DIRRECION QUE SEAN CALLE
SELECT DIRECCIÓN FROM PET_HOTEL
WHERE DIRECCIÓN LIKE ('C%')

--MUESTRA LA DIRRECION QUE SEAN AVENIDA
SELECT DIRECCIÓN FROM PET_HOTEL
WHERE DIRECCIÓN LIKE ('A%')


--RESERVAS
--MUESTRA EL ID DE LAS RESERVAS CUYO PRECIO ESTÁ ENTRE 30 Y 100
SELECT ID_RESERVA FROM RESERVA
WHERE PRECIO BETWEEN 30 AND 100

--MUESTRA LA DIFERENCIA EN SEMANAS ENTRE LA FECHA DE ENTRADA Y DE SALIDA
SELECT ID_RESERVA AS 'NÚMERO RESERVA',
	   FECHA_INI AS 'FECHA INICIAL',
	   FECHA_SAL AS 'FECHA FINAL',
	   DATEDIFF(WEEK, FECHA_INI, FECHA_SAL) AS 'DIFERENCIA SEMANAS' 
FROM RESERVA

--MUESTRA LA DIFERENCIA EN DÍAS ENTRE LA FECHA DE ENTRADA Y DE SALIDA
SELECT ID_RESERVA AS 'NÚMERO RESERVA',
	   FECHA_INI AS 'FECHA INICIAL',
	   FECHA_SAL AS 'FECHA FINAL',
	   DATEDIFF(DAY, FECHA_INI, FECHA_SAL) AS 'DIFERENCIA DÍAS' 
FROM RESERVA

--MUESTRA LA DIFERENCIA EN HORAS ENTRE LA FECHA DE ENTRADA Y DE SALIDA
SELECT ID_RESERVA AS 'NÚMERO RESERVA',
	   FECHA_INI AS 'FECHA INICIAL',
	   FECHA_SAL AS 'FECHA FINAL',
	   DATEDIFF(HOUR, FECHA_INI, FECHA_SAL) AS 'DIFERENCIA HORAS' 
FROM RESERVA



--CONSULTAS CON OPERACIONES DE UNIÓN:
--INNER JOIN:
/*
1. QUIERO VER QUE PERROS TIENEN HABITACIÓN ESTÁNDAR 
Y SUS RESPECTIVOS DATOS DE SUS TARJETAS
*/
SELECT C.NOMBRE,
	   C.EDAD,
	   HC.NRO_HABI AS 'NÚMERO HABITACIÓN ESTÁNDAR',
	   T.ANTIPULGAS,
	   T.DESPARASITACIÓN,
	   T.INDICACIÓN
FROM CANINO C
INNER JOIN HABITACION_CANINA HC ON HC.ID_CANINO=C.ID_CANINO
INNER JOIN HABITACION_ESTANDAR HE ON HC.ID_ESTANDAR=HE.ID_ESTANDAR
INNER JOIN TARJETA T ON C.ID_TARJETA=T.ID_TARJETA
WHERE HC.ID_ESTANDAR IS NOT NULL
AND HC.ID_PREMIUM IS NULL

--2. LO MISMO QUE EN EL CASO ANTERIOR, PERO CON LA HABITACIÓN PREMIUM
SELECT C.NOMBRE,
	   C.EDAD,
	   HC.NRO_HABI AS 'NÚMERO HABITACIÓN PREMIUM',
	   T.ANTIPULGAS,
	   T.DESPARASITACIÓN,
	   T.INDICACIÓN
FROM CANINO C
INNER JOIN HABITACION_CANINA HC ON HC.ID_CANINO=C.ID_CANINO
INNER JOIN HABITACION_PREMIUM HP ON HC.ID_PREMIUM=HP.ID_PREMIUM
INNER JOIN TARJETA T ON C.ID_TARJETA=T.ID_TARJETA
WHERE HC.ID_ESTANDAR IS NULL
AND HC.ID_PREMIUM IS NOT NULL

/*
3. AHORA REALIZAREMOS UNA CONSULTA QUE BUSQUE MOSTRAR EL NÚMERO DE CLIENTE,
SU NOMBRE, EL DÍA QUE INGRESÓ CON SU MASCOTA(NOMBRE); ADEMÁS DE ESO, 
EL DÍA EN EL QUE SE RETIRARÁ.
*/
SELECT C.ID_CLIENTE AS 'NÚMERO CLIENTE',
	   (C.NOMBRE+SPACE(1)+C.APELLIDO) AS 'NOMBRE Y APELLIDO CLIENTE',
	   CA.NOMBRE AS 'NOMBRE MASCOTA',
	   R.FECHA_INI AS 'FECHA INGRESO',
	   R.FECHA_SAL AS 'FECHA SALIDA'
FROM CLIENTE C
INNER JOIN RESERVA R ON R.ID_CLIENTE=C.ID_CLIENTE
INNER JOIN CANINO CA ON R.ID_CANINO=CA.ID_CANINO

/*
4. REALIZAMOS UNA CONSULTA QUE NOS DIGA EN QUE HOTEL 
DE PERROS ESTÁ EL CLIENTE Y CUANTO ES EL COSTO QUE ESTE PAGARÁ.
*/
SELECT P.NOMBRE AS 'NOMBRE DEL HOTEL DE PERROS',
       P.DIRECCIÓN AS 'DIRECCIÓN DEL HOTEL DE PERROS',
	   (C.NOMBRE+SPACE(1)+C.APELLIDO) AS 'NOMBRE Y APELLIDO CLIENTE',
	   CONCAT('S/. ',R.PRECIO) AS 'PRECIO POR LA RESERVA DE MASCOTA'
FROM PET_HOTEL P
INNER JOIN RESERVA R ON R.ID_PET = P.ID_PET
INNER JOIN CLIENTE C ON R.ID_CLIENTE = C.ID_CLIENTE
ORDER BY R.PRECIO 

/*
5. AHORA HABLAREMOS DE LOS PERROS VACUNADOS... ¿DE QUÉ TIPO DE RAZA ES? 
¿QUÉ TIPOS DE VACUNAS POSEES? Y DEMÁS DATOS DE SU TARJETA.
*/
SELECT C.NOMBRE AS 'NOMBRE DEL PERRO',
	   R.TIPO_RAZA AS 'RAZA DEL PERRO',
	   R.DESCRIPCIÓN AS 'DESCRIPCIÓN DE LA RAZA',
	   V.TIPO_VACUNA AS 'VACUNA QUE POSEE EL PERRO',
	   V.DESCRIPCIÓN AS 'DESCRIPCIÓN DE LA VACUNA',
	   T.ID_TARJETA AS 'NÚMERO DE TARJETA',
	   T.ANTIPULGAS,
	   T.DESPARASITACIÓN,
	   T.INDICACIÓN,
	   T.DESCRIPCIÓN AS 'DESCRIPCIÓN DE LA TARJETA'
FROM CANINO C
INNER JOIN RAZA R ON C.ID_RAZA = R.ID_RAZA
INNER JOIN TARJETA T ON T.ID_TARJETA = C.ID_TARJETA
INNER JOIN PERRO_VACUNADO PV ON C.ID_CANINO = PV.ID_CANINO 
INNER JOIN VACUNA V ON V.ID_VACUNA = PV.ID_VACUNA
ORDER BY T.ID_TARJETA

--LEFT JOIN:


--RIGHT JOIN:
/*
1. MOSTRAREMOS QUE VACUNAS TIENE CADA PERRO, PERO TAMBIÉN 
MOSTRAREMOS LAS DEMÁS VACUNAS QUE HAY, PERO NINGÚN PERRO POSEE.
*/
SELECT C.NOMBRE AS 'NOMBRE PERRO',
	   V.TIPO_VACUNA AS 'VACUNA',
	   V.DESCRIPCIÓN AS 'DESCRIPCIÓN VACUNA' 
FROM CANINO C
INNER JOIN PERRO_VACUNADO VP ON VP.ID_CANINO = C.ID_CANINO
RIGHT JOIN VACUNA V ON V.ID_VACUNA = VP.ID_VACUNA
ORDER BY C.NOMBRE DESC

/*
2. MOSTRAREMOS TODAS LAS RAZAS JUNTO CON LA INFORMACIÓN DE LOS PERROS
QUE LAS TIENEN ASIGNADAS, INCLUSO SI NO HAY PERROS ASIGNADOS A ALGUNAS RAZAS.
*/
SELECT C.NOMBRE AS 'NOMBRE PERRO',
	   R.TIPO_RAZA AS 'RAZA',
	   R.DESCRIPCIÓN AS 'DESCRIPCIÓN RAZA'
FROM CANINO C
RIGHT JOIN RAZA R ON R.ID_RAZA = C.ID_RAZA
ORDER BY C.NOMBRE DESC

/*
3. MOSTRAREMOS CADA FACTURA, SERVICIOS ADICIONALES Y COSTO TOTAL DE CADA 
FACTURA QUE TENGA UN CLIENTE AUNQUE HAYAN CLIENTES SIN FACTURA.
*/
SELECT (C.NOMBRE+SPACE(1)+C.APELLIDO) AS 'NOMBRE Y APELLIDO CLIENTE',
	   F.ID_FACTURA AS 'NÚMERO FACTURA',
	   F.SERVICIOS_AD AS 'SERVICIOS ADICIONALES',
	   CONCAT('S/. ',F.COSTO_TOTAL) AS 'COSTO TOTAL'
FROM CLIENTE C
RIGHT JOIN FACTURA F ON C.ID_CLIENTE = F.ID_CLIENTE
ORDER BY F.ID_FACTURA

/*
4. MOSTRAREMOS CUANTOS HISTORIALES TIENE CADA RESERVA Y COLOCAREMOS LAS RESERVAS
RESTANTES AUNQUE NO TENGAN HISTORIALES.
*/
SELECT H.ID_HISTORIAL AS 'NÚMERO HISTORIAL',
	   H.DESCRIPCIÓN AS 'DESCRIPCIÓN HISTORIAL',
	   R.ID_RESERVA AS 'NÚMERO RESERVA'
FROM HISTORIAL H
RIGHT JOIN RESERVA R ON H.ID_RESERVA = R.ID_RESERVA
ORDER BY H.ID_RESERVA DESC

/*
5. MOSTRAREMOS TODOS LOS HOTELES DE PERROS Y SUS RESERVAS AUNQUE HAYAN HOTEL
DE PERROS SIN RESERVAS.
*/
SELECT P.ID_PET AS 'NÚMERO HOTEL PERROS',
	   P.NOMBRE AS 'NOMBRE HOTEL PERROS',
	   R.ID_RESERVA AS 'NÚMERO RESERVA'
FROM RESERVA R
RIGHT JOIN PET_HOTEL P ON R.ID_PET = P.ID_PET
ORDER BY R.ID_RESERVA DESC

--SUBCONSULTAS
/*
1. SACAREMOS LOS PRECIOS MAYORES A LA MEDIA DE LA TABLA RESERVA 
*/
SELECT ID_RESERVA AS 'NÚMERO RESESRVA',
	   CONCAT('S/.',STR(PRECIO)) AS 'PRECIO'
FROM RESERVA WHERE PRECIO > (SELECT AVG(PRECIO) FROM RESERVA)

/*
2. MOSTRAREMOS TODOS LOS PERROS CUYO PESO ESTÁ ENTRE 15 Y 24 KILOS
*/
SELECT NOMBRE AS 'NOMBRE PERRO', 
	   CONCAT(PESO,' KG') AS 'PESO'
FROM CANINO WHERE PESO IN (SELECT PESO FROM CANINO WHERE PESO BETWEEN 15 AND 24)

--VARIABLES LOCALES CON CONSULTAS
/*
1. 
*/

/*
2. 
*/

/*
3. 
*/

--FUNCIÓN ESCALAR


--FUNCIÓN DE TABLAS


--FUNCIÓN CON VALORES DE LÍNEA

--ACCEDEMOS A LOS DIAGRAMAS DE BASE DE DATOS CON EL SIGUIENTE CÓDIGO:
ALTER AUTHORIZATION ON DATABASE :: [PET_HOTEL] TO SA
