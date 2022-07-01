use NutriSoft

-- citas API

CREATE VIEW [Citas Info]
AS
	Select  c.id id_cita, ce.id id_exp, id_nutricionista, id_cliente, fecha, estado, comentario_nutricionista, ce.comentario comentario_cliente, ce.puntuacion
	FROM Cita c
	INNER JOIN ComentarioExperiencia ce
	ON ce.id_cita = c.id

CREATE PROCEDURE [Citas Cliente Info]
(
	@id_cliente int
)
AS
BEGIN
	Select  id_cita, id_exp, id_nutricionista, fecha, estado, comentario_nutricionista, comentario_cliente, puntuacion
	FROM ClientInfo ci
	INNER JOIN [Citas Info] info
	ON info.id_cliente = ci.id
	WHERE ci.id =  @id_cliente
END

CREATE PROCEDURE [Citas Nutri Info]
(
	@id_nutri int
)
AS
BEGIN
	Select  id_cita, id_exp, id_cliente, fecha, estado, comentario_nutricionista, comentario_cliente, info.puntuacion
	FROM NutriInfo ni
	INNER JOIN [Citas Info] info
	ON info.id_nutricionista = ni.id
	WHERE info.id_nutricionista = @id_nutri
END