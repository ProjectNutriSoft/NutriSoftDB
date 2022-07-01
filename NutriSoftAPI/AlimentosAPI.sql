-- ## Alimento API
use NutriSoft

CREATE VIEW InfoAlimentos
AS
	SELECT al.id, al_tipo.id id_tipo_alimento, al_inf.id id_informacion_nutricional, al_tipo.nombre tipo, al.nombre, al_inf.proteinas, al_inf.calorias, al_inf.carbohidratos, al_inf.grasas, al_inf.peso_ref
	FROM Alimento al
	INNER JOIN InformacionNutricional al_inf
	ON al.id_informacion_nutricional = al_inf.id
	INNER JOIN TipoAlimento al_tipo
	ON al.id_tipo_alimento = al_tipo.id

CREATE VIEW AlimentosConReceta
AS
	SELECT al.id id, r.id id_receta, al.nombre, r.duracion, r.pasos, r.url_video
	FROM IngredientesReceta ir
	INNER JOIN Alimento al
	ON al.id = ir.id_alimento
	INNER JOIN Receta r
	ON ir.id_receta = r.id
	INNER JOIN TipoAlimento al_tipo
	ON al.id_tipo_alimento = al_tipo.id
	WHERE al_tipo.nombre = 'Compuestos'

CREATE PROCEDURE [Info Alimento]
(
	@id int
)
AS
BEGIN
	SELECT al.id id, al_tipo.id id_informacion_nutricional, al_tipo.nombre tipo, al.nombre, al_inf.proteinas, al_inf.calorias, al_inf.carbohidratos, al_inf.grasas, al_inf.peso_ref
	FROM Alimento al
	INNER JOIN InformacionNutricional al_inf
	ON al.id_informacion_nutricional = al_inf.id
	INNER JOIN TipoAlimento al_tipo
	ON al.id_tipo_alimento = al_tipo.id
	WHERE al.id = @id
END


CREATE PROCEDURE [Info Alimento con Receta]
(
	@id int
)
AS
BEGIN
	SELECT ar.*, al.tipo, al.id_informacion_nutricional, al.calorias, al.carbohidratos, al.grasas, al.proteinas, al.peso_ref
	FROM AlimentosConReceta ar
	INNER JOIN InfoAlimentos al
	ON al.id = ar.id
	WHERE al.id = @id
END

CREATE PROCEDURE [Lista de Ingredientes]
(
	@id_receta int
)
AS
BEGIN
	SELECT al.id, al.id_informacion_nutricional, al.nombre, ir.cantidad
	FROM IngredientesReceta ir
	INNER JOIN Alimento al
	ON ir.id_alimento = al.id
	INNER JOIN TipoAlimento al_tipo
	ON al.id_tipo_alimento = al_tipo.id
	WHERE al_tipo.nombre != 'Compuestos' AND ir.id_receta = @id_receta
END

CREATE PROCEDURE [Filtrar Alimento por Tipo]
(
	@id_tipo int
)
AS
BEGIN
	
	SELECT al.* 
	FROM Alimento al
	INNER JOIN TipoAlimento ta
	ON al.id_tipo_alimento = ta.id
	WHERE al.id_tipo_alimento = @id_tipo

END

SELECT *
FROM Usuario

UPDATE Usuario
SET contrasenia 
WHERE id = 1

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

CREATE PROCEDURE [Aniadir Cliente Ingrediente Base]
(
	@id_cliente int,
	@id_alimento int
)
AS
BEGIN
	IF(NOT EXISTS(SELECT * FROM IngredientesBase WHERE id_cliente = @id_cliente AND id_alimento = @id_alimento))
	BEGIN
		INSERT INTO IngredientesBase
		VALUES 
			(@id_alimento, @id_cliente)
	END
END