CREATE PROCEDURE [Resumen Diario Info]
(
	@id_cliente int,
	@fecha date
)
AS
BEGIN
	SELECT AlimentoMomentoDia.id id_alimento_momento_dia, ResumenMomentoDia.id id_resumen_momento_dia, ResumenDiario.id id_resumen_diario, id_macro, id_alimento, id_tipo_momento, dia, calorias_max, proteinas_max, carbohidratos_max, grasas_max, MomentoDia.nombre nombre_momento_dia, recomendado, id_alimento
	FROM AlimentoMomentoDia 
	INNER JOIN ResumenMomentoDia 
	ON AlimentoMomentoDia.id_resumen_momento_dia = ResumenMomentoDia.id
	INNER JOIN ResumenDiario
	ON ResumenMomentoDia.id_resumen_diario = ResumenDiario.id
	INNER JOIN MacroObjetivo
	ON ResumenDiario.id_macro = MacroObjetivo.id
	INNER JOIN MomentoDia
	ON ResumenMomentoDia.id_tipo_momento = MomentoDia.id
	WHERE ResumenDiario.id_cliente = @id_cliente AND dia = @fecha
END