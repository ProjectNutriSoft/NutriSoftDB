USE NutriSoft
GO

-- BRUNO
-- [Ver Alimentos Base] 1 -- renzo
CREATE PROCEDURE [Ver Alimentos Base]
(
	@id_cliente int
)
AS
BEGIN
	with NCliente(cli_id, cli_nom) AS
	(
		SELECT Usuario.id, Usuario.nombre FROM Usuario
		INNER JOIN Cliente
		ON Cliente.id_usuario = Usuario.id
	)
	SELECT NCliente.cli_nom, Alimento.nombre FROM IngredientesBase
	INNER JOIN Alimento
	ON IngredientesBase.id_alimento = Alimento.id
	INNER JOIN NCliente
	ON IngredientesBase.id_cliente = NCliente.cli_id
END
GO

-- ANDERSON
-- EXEC [Ver Informacion Nutricional De] 3 -- arroz blanco
CREATE PROCEDURE [Ver Informacion Nutricional De]
(
	@id_alimento int
)
AS
BEGIN
	SELECT Alimento.id id_alimento, Alimento.nombre, InformacionNutricional.* FROM Alimento
	INNER JOIN InformacionNutricional
	ON Alimento.id_informacion_nutricional = InformacionNutricional.id
END
GO

-- MARIO
-- EXEC [Ver Alimentos Tipo] 2 -- papa
CREATE PROCEDURE [Ver Alimentos Tipo]
(
	@id_tipo_aliemento int 
)
AS
BEGIN
	SELECT Alimento.nombre alimento, TipoAlimento.nombre tipo FROM Alimento
	INNER JOIN TipoAlimento
	ON Alimento.id_tipo_alimento = TipoAlimento.id
	WHERE Alimento.id_tipo_alimento = @id_tipo_aliemento
END
GO 

-- WILL 

-- SELECT * FROM [Clientes Que midan mas 1.60 y menos 20 años]
CREATE VIEW [Clientes Que midan mas 1.60 y menos 20 años] AS
with NCliente(cli_id, cli_nom, edad) AS
	(
		SELECT Usuario.id, Usuario.nombre, Usuario.edad FROM Usuario
		INNER JOIN Cliente
		ON Cliente.id_usuario = Usuario.id
	), DatosCliente(cli_nom, talla, edad) AS
	(
		SELECT NCliente.cli_nom, RegistroDatosCliente.talla, NCliente.edad FROM RegistroDatosCliente
		INNER JOIN NCliente
		ON NCliente.cli_id = RegistroDatosCliente.id_cliente
	),
	Condition(cliente_nombre, cliente_talla, cliente_edad) AS
	(
		SELECT DatosCliente.cli_nom, max(DatosCliente.talla), DatosCliente.edad From DatosCliente
		WHERE DatosCliente.edad >= 20
		GROUP BY DatosCliente.talla, DatosCliente.cli_nom, DatosCliente.edad
		HAVING max(DatosCliente.talla) >= 1.60 )
	SELECT * FROM Condition;
	GO

-- RENZO
-- (aqui)        # SELECT * FROM [Ver Detalle Cita] 
-- (parte_2.sql) # [Generar Resumen Diario Random] (script para añadir datos de comidas diarias que usamos)

CREATE VIEW [Ver Detalle Cita] AS
with 
NCliente(idcliente, nomCliente) AS
(
	select Cliente.id_usuario, Usuario.nombre from Cliente
	INNER JOIN Usuario 
	ON Cliente.id_usuario = Usuario.id
),
NNutricionista(idnutri, nomNutricionista) AS
(
	select Nutricionista.id_usuario, Usuario.nombre from Nutricionista
	INNER JOIN Usuario 
	ON Nutricionista.id_usuario = Usuario.id
)
SELECT Cita.id, Cita.fecha, Cita.estado, Cita.comentario_nutricionista, NCliente.*, NNutricionista.* FROM Cita
INNER JOIN NCliente
ON Cita.id_cliente = NCliente.idcliente
INNER JOIN NNutricionista
ON Cita.id_nutricionista = NNutricionista.idnutri
GO