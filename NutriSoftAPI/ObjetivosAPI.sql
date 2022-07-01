select * from Objetivo

CREATE VIEW [Info Objetivo]
AS
	SELECT obj.id id_objetivo, obj_t.id id_tipo_objetivo, obj.id_cliente, obj.id_nutricionista, obj.estado, obj.fecha_final, obj.fecha_inicio, obj.peso_objetivo, obj.tiempo_estimado, obj_t.tipo
	FROM Objetivo obj
	INNER JOIN TipoObjetivo obj_t
	ON obj.id_tipo_objetivo = obj_t.id
	
CREATE VIEW [Ultimo Objetivo]
AS
	SELECT id_cliente, MAX(fecha_inicio) maximo_inicio
	FROM [Info Objetivo] obj
	GROUP BY id_cliente

CREATE PROCEDURE [Aniadir Objetivo]
(
	@id_cliente int,
	@id_tipo_objetivo int,
	@peso_objetivo real,
	@estado char(1),
	@fecha_inicio date
)
AS
BEGIN
	DECLARE @last_date date
	DECLARE @state char(1)

	SELECT @last_date = maximo_inicio
	FROM [Ultimo Objetivo] 
	WHERE id_cliente = @id_cliente

	SELECT @estado = estado
	FROM Objetivo 
	WHERE id_cliente = @id_cliente AND fecha_inicio = @last_date

	if (@last_date IS NOT NULL AND @state NOT IN ('c', 'f'))
	BEGIN
		UPDATE Objetivo
		SET estado = 'n'
		WHERE id_cliente = @id_cliente AND fecha_inicio = @last_date
	END

	INSERT INTO Objetivo
	VALUES
		(@id_cliente, NULL, @id_tipo_objetivo, @peso_objetivo, @estado, @fecha_inicio, NULL, NULL)
END