USE NutriSoft
GO

CREATE PROCEDURE [Aniadir Alimento]
(
	@nombre varchar(25),
	@calorias real,
	@proteinas real,
	@carbohidratos real,
	@grasas real,
	@peso_ref real,
	@id_tipo_alimento int
)
AS 
BEGIN

	INSERT INTO [dbo].[InformacionNutricional](
		   [calorias]
           ,[proteinas]
           ,[carbohidratos]
           ,[grasas]
           ,[peso_ref])
     VALUES
           (
		   @calorias, 
		   @proteinas,
		   @carbohidratos, 
		   @grasas, 
		   @peso_ref)

	INSERT INTO [dbo].[Alimento]
           ([id_tipo_alimento]
           ,[id_informacion_nutricional]
           ,[nombre])
     VALUES
           (@id_tipo_alimento, SCOPE_IDENTITY(), @nombre)

END
GO

CREATE PROCEDURE [Generar Cita]
(
	@id_cliente int,
	@id_nutricionista int,
	@fecha datetime
)
AS
BEGIN
	INSERT INTO Cita
	VALUES
		(@id_cliente, @id_nutricionista, @fecha, 'p', NULL)
END
GO

CREATE PROCEDURE [Aniadir Cliente]
(
	@dni int,
	@edad int,
	@nombre varchar(25),
	@correo varchar(25),
	@telefono varchar(25),
	@fecha_nacimiento date,
	@vegano bit
)
AS
BEGIN 
	
	INSERT INTO [Usuario]
	VALUES (@dni, @edad, @nombre, @correo, @telefono, @fecha_nacimiento, GETDATE())

	INSERT INTO [Cliente]
	VALUES (SCOPE_IDENTITY(), @vegano, 0, 0) 

END
GO

CREATE PROCEDURE [Aniadir Nutricionista]
(
	@dni int,
	@edad int,
	@nombre varchar(25),
	@correo varchar(25),
	@telefono varchar(25),
	@fecha_nacimiento date,
	@cuenta varchar(13),
	@descripcion varchar(500)
)
AS
BEGIN 
	
	INSERT INTO [Usuario]
	VALUES (@dni, @edad, @nombre, @correo, @telefono, @fecha_nacimiento, GETDATE())

	INSERT INTO [Nutricionista]
	VALUES (SCOPE_IDENTITY(), 0, @cuenta, @descripcion, 0) 

END
GO

CREATE PROCEDURE [Suscribirse]
(
	@id_cliente int,
	@id_paquete int
)
AS
BEGIN

	INSERT INTO Boleta
	VALUES
		(@id_cliente, @id_paquete, GETDATE())

	UPDATE Cliente 
	set Cliente.suscrito = 1
	WHERE Cliente.id_usuario = @id_cliente
END
GO

CREATE PROCEDURE [Registrar Datos Cliente]
(
	@id_cliente int,
	@peso real,
	@talla real
)
AS
BEGIN
	INSERT INTO RegistroDatosCliente
	VALUES
		(@id_cliente, @peso, @talla, GETDATE())
END
GO



CREATE PROCEDURE [Reset Database]
AS
BEGIN

	-- orden en el que deben limpiarse
	EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL' 
	EXEC sp_MSForEachTable 'DELETE FROM ?' 
	EXEC sp_MSForEachTable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL' 

	-- resetear seeds
	DBCC CHECKIDENT ('Alimento', RESEED, 0)
	DBCC CHECKIDENT ('AlimentoMomentoDia', RESEED, 0)
	DBCC CHECKIDENT ('Boleta', RESEED, 0)
	DBCC CHECKIDENT ('Certificado', RESEED, 0)
	DBCC CHECKIDENT ('Cita', RESEED, 0)
	DBCC CHECKIDENT ('ComentarioExperiencia', RESEED, 0)
	DBCC CHECKIDENT ('Contactos', RESEED, 0)
	DBCC CHECKIDENT ('Horario', RESEED, 0)
	DBCC CHECKIDENT ('InformacionNutricional', RESEED, 0)
	DBCC CHECKIDENT ('IngredientesBase', RESEED, 0)
	DBCC CHECKIDENT ('IngredientesReceta', RESEED, 0)
	DBCC CHECKIDENT ('MacroObjetivo', RESEED, 0)
	DBCC CHECKIDENT ('MomentoDia', RESEED, 0)
	DBCC CHECKIDENT ('Objetivo', RESEED, 0)
	DBCC CHECKIDENT ('PagoNutricionista', RESEED, 0)
	DBCC CHECKIDENT ('Paquete', RESEED, 0)
	DBCC CHECKIDENT ('Receta', RESEED, 0)
	DBCC CHECKIDENT ('RegistroDatosCliente', RESEED, 0)
	DBCC CHECKIDENT ('ResumenDiario', RESEED, 0)
	DBCC CHECKIDENT ('ResumenMomentoDia', RESEED, 0)
	DBCC CHECKIDENT ('Tarjeta', RESEED, 0)
	DBCC CHECKIDENT ('TipoAlimento', RESEED, 0)
	DBCC CHECKIDENT ('TipoObjetivo', RESEED, 0)
	DBCC CHECKIDENT ('Usuario', RESEED, 0)
END
GO

CREATE PROCEDURE [Generar Resumen Diario Random]
(
	@id_cliente int,
	@fecha_inicial date,
	@fecha_final date
)
AS
BEGIN
	
	DECLARE @fechaIn date = @fecha_inicial
	DECLARE @fechaFin date = @fecha_final
	DECLARE @momDia int = NULL
	DECLARE @alimMomDia int = NULL
	DECLARE @auxIden int = NULL
	DECLARE @auxIden2 int = NULL
	WHILE @fechaIn <= @fechaFin
	BEGIN
		INSERT INTO MacroObjetivo
		VALUES((RAND()*9), (RAND()*9), (RAND()*9), (RAND()*9))

		INSERT INTO ResumenDiario 
		VALUES (SCOPE_IDENTITY(), 1, @fechaIn)

		SET @momDia = 1
		SET @auxIden = SCOPE_IDENTITY()
		WHILE @momDia <= 5
		BEGIN
			INSERT INTO ResumenMomentoDia
			VALUES (@auxIden, FLOOR((RAND()*4)+1))

			SET @alimMomDia = FLOOR((RAND()*5)+1)
			SET @auxIden2 = SCOPE_IDENTITY()
			WHILE @alimMomDia > 0
			BEGIN
				INSERT INTO AlimentoMomentoDia
				VALUES (@auxIden2, FLOOR((RAND()*18)+1), ROUND(RAND(), 0))
				SET @alimMomDia = @alimMomDia - 1
			END

			SET @momDia = @momDia + 1
		END

		SET @fechaIn = DATEADD(DAY, 1, @fechaIn)
	END
END
GO

--EXEC [Reset Database]

-- añadir tipo de alimentos

INSERT INTO [TipoAlimento]
           ([nombre])
     VALUES
           ('Carbohidratos'), 
		   ('Grasas'),
		   ('Lacteos'), 
		   ('Frutas'), 
		   ('Proteinas'),
		   ('Compuestos')

-- añadir alimentos

-- añadir Carbohidratos (id = 1)
EXEC [Aniadir Alimento] 'pan blanco', 266 ,  7.64 , 50.61 , 3.29, 100, 1
EXEC [Aniadir Alimento] 'papa', 77 ,  2.02 , 17.47 , 0.09, 100, 1
EXEC [Aniadir Alimento] 'arroz blanco', 204 ,  4.2 , 44.08 , 0.44, 100, 1

-- añadir Grasas (id = 2)
EXEC [Aniadir Alimento] 'Palta', 198, 8.78, 9.62, 14.55, 100, 2
EXEC [Aniadir Alimento] 'Aceitunas', 145, 1.03, 3.84, 15.32, 100, 2
EXEC [Aniadir Alimento] 'Pecanas', 715, 11.4, 4, 72.2, 100, 2

-- añadir Lacteos (id = 3)
EXEC [Aniadir Alimento] 'leche entera', 60, 3.22, 4.25, 3.25, 100, 3
EXEC [Aniadir Alimento] 'queso', 350 ,  22.21 , 4.71 , 26.91, 100, 3
EXEC [Aniadir Alimento] 'Yogur Natural', 45, 5.40, 5.60, 0.10, 125, 3

-- añadir Frutas (id = 4)
EXEC [Aniadir Alimento] 'Platano',89 ,1.09 ,22.84 ,0.33 ,100 , 4
EXEC [Aniadir Alimento] 'Aceitunas', 0.145, 1.03, 3.84, 15.32, 100 , 4
EXEC [Aniadir Alimento] 'Mani', 0.567, 25.8, 16.13, 49.24, 100 , 4

-- añadir Proteinas (id = 5)
EXEC [Aniadir Alimento] 'Almendras',578 ,21.26 ,19.74 ,50.64 ,100 ,5
EXEC [Aniadir Alimento] 'Pechuga de Pollo',195,29.55,0,7.72,100 ,5
EXEC [Aniadir Alimento] 'Salmón', 146, 21.62, 0, 5.93, 100, 5
EXEC [Aniadir Alimento] 'Carne', 282, 24.5, 0, 19.65, 100, 5

-- añadir Compuestos (id = 6)
EXEC [Aniadir Alimento] 'Hamburguesas', 278, 29.67, 6.37, 14.11, 125, 6
EXEC [Aniadir Alimento] 'Estofado de Pollo', 306, 16.88,32.65,12.2,252, 6
EXEC [Aniadir Alimento] 'Ceviche', 125, 20.91, 6.7, 1.44, 186, 6

-- añadir Recetas

INSERT INTO Receta 
VALUES 
(120, 'poner un pan luego una carne y luego otro pan', 'https://www.youtube.com/watch?v=mCdA4bJAGGk'),
(2700, 'pon pollo zanahoria y papa en agua herbida y espera', 'https://www.youtube.com/watch?v=mCdA4bJAGGk'),
(1800, 'lucha con el pez quemalo con limon y ponle las ensaladas que quieras', 'https://www.youtube.com/watch?v=mCdA4bJAGGk')

-- emparejar ingredientes

INSERT INTO IngredientesReceta
VALUES
	
	( 17,  1, 0 ), -- #Hamburguesas#
	( 1,  1, 30 ), -- pan blanco
	( 19, 1, 95 ), -- carne

	( 18, 2, 0 ),   -- #Estofado de Pollo#
	( 14, 2, 100 ), -- Pechuga de Pollo
	( 2, 2, 80),    -- papa
	( 3, 2, 90 ),   -- arroz blanco

	( 19, 3, 0),   -- #ceviche#
	( 15, 3, 100 ) -- Salmón

-- añadir clientes 
EXEC [Aniadir Cliente] 73895522, 22, 'renzo', 'mario@gmail.com', '926120193', '1999-03-15', 0
EXEC [Aniadir Cliente] 73899385, 21, 'will', 'will@gmail.com', '936458696', '2000-03-15', 0
EXEC [Aniadir Cliente] 73891935, 20, 'bruno', 'bruno@gmail.com', '996857351', '2000-01-30', 0

-- añadir nutricionistas
EXEC [Aniadir Nutricionista] 76983166, 22, 'anderson', 'anderson@gmail.com', '918365478', '1998-04-03', '1983675294861', 'soy muy estudioso'
EXEC [Aniadir Nutricionista] 71693286, 20, 'mario', 'mario@gmail.com', '999136587', '1997-12-19', '3896245252788', 'tengo muchos conocimientos'

-- añadir horarios nutricionistas # horarios creados para un mejor filtrado mas no de uso del nutricionista
--								  # se añaden cada vez que un usuario empieza y acaba una jornada del dia
--								  # se usan para darle una informacion estimada al cliente suscrito para que vea la frecuencia de disponibilidad de los nutricionistas
INSERT INTO Horario
VALUES
	(4, 1, TIMEFROMPARTS(15, 15, 00, 0, 0), TIMEFROMPARTS(18, 15, 00, 0, 0)), -- anderson / lunes
	(4, 2, TIMEFROMPARTS(15, 13, 00, 0, 0), TIMEFROMPARTS(18, 16, 00, 0, 0)), -- anderson / martes

	(5, 1, TIMEFROMPARTS(10, 00, 00, 0, 0), TIMEFROMPARTS(17, 30, 00, 0, 0)),  -- mario / lunes
	(5, 2, TIMEFROMPARTS(12, 00, 00, 0, 0), TIMEFROMPARTS(18, 00, 00, 0, 0))   -- mario / martes

-- certificado nutricionistas

INSERT INTO Certificado 
VALUES
	(4, '0x00000', DATETIMEFROMPARTS(2022, 05, 29, 15, 16, 22, 0), NULL),
	(5, '0x00000', DATETIMEFROMPARTS(2022, 05, 29, 10, 0, 0, 0), NULL)

-- pago nutricionistas

INSERT INTO	PagoNutricionista
VALUES
	(4, 100, DATEFROMPARTS(2022, 05, 31)), -- anderson
	(4, 115, DATEFROMPARTS(2022, 06, 30)), -- anderson
	(5, 115, DATEFROMPARTS(2022, 05, 31)), -- mario
	(5, 100, DATEFROMPARTS(2022, 06, 30))  -- mario

-- añadir citas # c-cumplido, a-atendiendose, n-nocumplido, e-espera

INSERT INTO Cita
VALUES
	(1, 4, '2020-06-02 18:30:00', 'c', 'esta gordo'),   -- renzo / anderson / cumplido
	(1, 5, '2020-07-01 16:30:00', 'a', 'esta regular'), -- renzo / mario    / atendiendose
	(2, 4, '2020-06-02 15:30:00', 'c', 'esta promedio'),   -- will  / anderson / cumplido
	(3, 5, '2020-08-04 15:00:00', 'c', 'esta promedio')    -- bruno / mario    / cumplido

-- añadir comentarios a citas
INSERT INTO ComentarioExperiencia
VALUES
	(1, 'necesito segunda opinion no me gusto su veredicto', 3),
	(2, 'me ayudo mucho y fue muy empatico con como me trato', 4.5),
	(3, 'fue de ayuda', 3.5),
	(4, 'exelente asesor', 5)

-- añadir tarjeta
INSERT INTO Tarjeta
VALUES
	(1, '1938276093851', 'renzo', 29, 04, 161), -- renzo
	(2, '2368579684537', 'will', 27, 05, 193),  -- will
	(3, '5396847531269', 'bruno', 21, 05, 285)  -- bruno

-- añadir paquetes

INSERT INTO Paquete
VALUES 
	('Estandar', 1, 3.99),
	('Platino', 3, 3),
	('Golden', 12, 2.59)

-- suscribir personas

EXEC [Suscribirse] 1, 2 -- renzo / Platino
EXEC [Suscribirse] 2, 3 -- will  / Golden
EXEC [Suscribirse] 3, 3 -- bruno / Golden

-- añadir contactos

INSERT INTO Contactos
VALUES 
	( 1, 2 ), -- renzo / will
	( 2, 3 )  -- will / bruno

-- registros del cliente

INSERT INTO RegistroDatosCliente
VALUES
	(1, 100, 1.75, DATETIMEFROMPARTS(2022, 05, 25, 16, 50, 0, 0)), -- renzo 
	(2, 65, 1.70,  DATETIMEFROMPARTS(2022, 05, 26, 15, 30, 0, 0)), -- will
	(3, 60, 1.70,  DATETIMEFROMPARTS(2022, 05, 26, 18, 00, 0, 0)) -- bruno

-- añadir ingredientes base

INSERT INTO IngredientesBase
VALUES 

	-- Carbohidratos
	(1, 1), -- pan blanco / renzo 
	(2, 1), -- papa / renzo

	(1, 2), -- pan blanco / will 
	(3, 2), -- arroz blanco / will 

	(2, 3), -- papa / bruno 
	(3, 3), -- arroz blanco / bruno 

	-- Grasas
	(4, 1), -- Palta / renzo 
	(5, 1), -- Aceitunas / renzo
	
	(4, 2), -- Palta / will 
	(6, 2),	-- Pecanas / will

	(5, 3), -- Aceitunas / bruno 
	(6, 3), -- Pecanas / bruno

	-- Lacteos
	(7, 1), -- leche entera / renzo 
	(8, 1), -- queso / renzo

	(7, 2), -- leche entera / will 
	(9, 2), -- Yogur Natural / will 

	(8, 3), -- queso / bruno 
	(9, 3), -- Yogur Natural / bruno 

	-- Frutas
	(10, 1), -- Platano / renzo 
	(11, 1), -- Aceitunas / renzo

	(10, 2), -- Platano / will 
	(12, 2), -- Mani / will 

	(11, 3), -- Aceitunas / bruno 
	(12, 3),  -- Mani / bruno 

	-- Proteinas
	(13, 1), -- Almendras / renzo 
	(14, 1), -- Pechuga de Pollo / renzo

	(13, 2), -- Almendras / will 
	(15, 2), -- Salmón / will 

	(14, 3), -- Pechuga de Pollo / bruno 
	(15, 3)  -- Salmón / bruno 

-- añadir tipos de objetivo

INSERT INTO TipoObjetivo
VALUES
	('Bajar Peso'),
	('Mantener Peso'),
	('Subir Peso')

-- añadir momento dias

INSERT INTO MomentoDia
VALUES
	('Desayuno'),
	('Medio Dia'),
	('Almuerzo'),
	('Merienda'),
	('Cena')

-- añadir objetivos
INSERT INTO Objetivo
VALUES
	(1, NULL, 1, 90, 'n', DATEFROMPARTS(2022, 05, 29), NULL, 120), -- renzo / NULL / Bajar Peso / no cumplido
	(2, NULL, 2, 65, 'n', DATEFROMPARTS(2022, 05, 29), NULL, 15), -- will / NULL / Mantener Peso / no cumplido
	(3, NULL, 2, 65, 'n', DATEFROMPARTS(2022, 05, 29), NULL, 10),  --  bruno/ NULL / Mantener Peso / no cumplido

	(1, 5, 1, 90, 'p', DATEFROMPARTS(2022, 07, 01), NULL, 120), -- renzo / mario / Bajar Peso / proceso
	(2, 4, 2, 65, 'p', DATEFROMPARTS(2022, 06, 02), NULL, 12), -- will / anderson / Mantener Peso / proceso
	(3, 5, 2, 65, 'p', DATEFROMPARTS(2022, 08, 04), NULL, 10)  --  bruno/ mario / Mantener Peso / proceso

-- añadir resumen diario

EXEC [Generar Resumen Diario Random] 1, '2022-05-29', '2020-07-01' -- renzo
EXEC [Generar Resumen Diario Random] 2, '2022-05-29', '2020-06-02' -- will
EXEC [Generar Resumen Diario Random] 3, '2022-05-29', '2020-08-04' -- bruno