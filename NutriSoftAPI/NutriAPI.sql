
-- # nutri API

CREATE PROCEDURE [Crear Nutricionista]
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

CREATE PROCEDURE [Aniadir Nutri Horario]
(
	@id_nutricionista int,
	@dia smallint,
	@hora_apertura time(1),
	@hora_cierre time(1)
)
AS
BEGIN
	INSERT INTO Horario
	VALUES
		(@id_nutricionista, @dia, @hora_apertura, @hora_cierre)
END

CREATE PROCEDURE [Aniadir Nutri Certificado]
(
	@id_nutricionista int,
	@prueba image,
	@fecha_expiracion datetime null
)
AS
BEGIN
	INSERT INTO Certificado
	VALUES
		(@id_nutricionista, @prueba, GETDATE(), @fecha_expiracion)
END