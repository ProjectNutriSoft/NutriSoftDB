-- # Client API

CREATE VIEW [Boletas Cliente]
AS
	SELECT bol.id, bol.id_cliente, bol.fecha_suscrita, paq.id id_paquete, paq.tipo, paq.meses, paq.pago_mensual
	FROM Boleta bol
	INNER JOIN Cliente cli
	ON bol.id_cliente = cli.id_usuario
	INNER JOIN Paquete paq
	ON bol.id_paquete = paq.id

CREATE PROCEDURE [Boleta Actual]
(
	@id int
)
AS
BEGIN
	WITH CliBoletas AS (
		SELECT *
		FROM [Boletas Cliente] bc
		WHERE bc.id_cliente = @id 
	)
	SELECT * 
	FROM CliBoletas cb
	WHERE fecha_suscrita = GETDATE()

END

CREATE PROCEDURE [Crear Cliente]
(
	@dni int,
	@edad int,
	@nombre varchar(25),
	@correo varchar(25),
	@telefono nvarchar(25),
	@fecha_nacimiento date,
	@vegano bit
)
AS
BEGIN
	INSERT INTO Usuario
		(dni, edad, nombre, correo, telefono, fecha_nacimiento, fecha_registro)
	VALUES
		(@dni, @edad, @nombre, @correo, @telefono, @fecha_nacimiento, GETDATE())

	INSERT INTO Cliente
		(id_usuario, vegano, abusivo, suscrito)
	VALUES
		(SCOPE_IDENTITY(), @vegano, 0, 0)
END

CREATE PROCEDURE [Aniadir Tarjeta]
(
	@id_usuario int,
	@numero varchar(13),
	@titular varchar(15),
	@anio_expiracion int,
	@mes_expiracion int,
	@cvc int
)
AS
BEGIN
	IF(EXISTS(SELECT * FROM Tarjeta WHERE id_usuario = @id_usuario))
	BEGIN
		DELETE FROM Tarjeta WHERE id_usuario = @id_usuario
	END

	INSERT INTO Tarjeta
	VALUES
		(@id_usuario, @numero, @titular, @anio_expiracion, @mes_expiracion, @cvc)
	
END

CREATE VIEW [Ultima Suscripcion]
AS
	SELECT id_cliente, fecha_suscrita, DATEADD(DAY, meses, fecha_suscrita) fecha_final 
	FROM Boleta
	INNER JOIN Paquete
	ON Boleta.id_paquete = Paquete.id
	INNER JOIN (
		SELECT id_cliente client_id, MAX(fecha_suscrita) _mx
		FROM Boleta
		GROUP BY id_cliente
	) mx
	ON mx._mx = Boleta.fecha_suscrita AND mx.client_id = Boleta.id_cliente


CREATE PROCEDURE [Suscribirse]
(
	@id_paquete int,
	@id_cliente int
)
AS
BEGIN

	IF((SELECT suscrito FROM Cliente WHERE id_usuario = @id_cliente) = 1)
	BEGIN
		SELECT 'suscrito'
		RETURN
	END

	if ( EXISTS(SELECT * FROM Tarjeta WHERE id_usuario = @id_cliente) )
	BEGIN
		
		DECLARE @meses int = (
			SELECT meses FROM Paquete
			WHERE Paquete.id = @id_paquete
		)

		INSERT INTO Boleta
				(id_cliente, id_paquete, fecha_suscrita)
			VALUES
				(@id_cliente, @id_paquete, GETDATE())


		UPDATE Cliente
		SET suscrito = 1
		WHERE id_usuario = @id_cliente

	END

END

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


CREATE PROCEDURE [Obtener Datos Cliente mes anio]
(
	@id_cliente int,
	@mes int,
	@anio int
)
AS
BEGIN
	SELECT *
	FROM RegistroDatosCliente
	WHERE id_cliente = @id_cliente AND MONTH(fecha) = @mes AND YEAR(fecha) = @anio
END