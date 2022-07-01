use NutriSoft

--1. muestre los usarios que pagaron mas a un nutricionista // q; (wilfredo)
CREATE VIEW mejor_pagado
as
	with temp1
	as
	(
	 select top 1 with ties
		A.dni,
		C.id,
		C.monto
	 from usuario A
	 inner join Nutricionista B
	 on A.id=B.id_usuario
	 inner join PagoNutricionista C
	 on B.id_usuario=C.id_nutricionista
	 order by C.monto desc
	)
	select * from temp1



--2. listar los alimentos que tengan como minimo 500 calorias y ordenalas de forma ascendente (Anderson)

create view minimo_500
as
	select 
		A.id,
		A.nombre,
		B.calorias
	from Alimento A
	inner join InformacionNutricional B
	on A.id=B.id
	where B.calorias>=500

--3.Ingresa el mes y el año Listar los clientes que tengan menos de 3 citas (Bruno).
create proc menos_3_citas
@mes int,
@anio int
as
begin 
with temp2
as
(
 select 
    A.id_usuario,
    MONTH(B.fecha) Mes,
    YEAR(B.fecha) Año,
    count(*) N_citas
 from Cliente A
 inner join Cita B
 on A.id_usuario=B.id_cliente
 group by A.id_usuario, MONTH(B.fecha), YEAR(B.fecha)
 having MONTH(B.fecha)=@mes and YEAR(B.fecha)=@anio and count(A.id_usuario)<=3
)
select * from temp2
end

--4. mostrar todas las consultas realizadas en el ultimo trimestre(tabla cita) del 2020 donde la puntuacion(tabla comentarioExperiencia) haya sido mayor a 3 estrellas (Mario)
create procedure puntuacion_bimestre
@mes int
as
select 
    MONTH(A.fecha) Mes,
    A.fecha,
    B.puntuacion puntuacion

from Cita A
inner join ComentarioExperiencia B
on A.id=B.id_cita
where (MONTH(A.fecha)=@mes or MONTH(DATEADD(month, A.fecha, 1))=@mes + 1 and B.puntuacion>3

-- 5..Se mostrara la cantidad de todas las consultas realizadas en el 
-- ultimo trimestre donde la puntuacion haya sido mayor a 4. Esto
-- para demostrar que nuestra ventaja competitiva y que la aplicacion 
-- es optima con nuestra propuesta. (mario)

CREATE VIEW [Consultas Puntuacion minimo 4]
AS
	select COUNT(*) puntos_mayor_4
	from Cita
	INNER JOIN ComentarioExperiencia
	ON Cita.id = ComentarioExperiencia.id_cita
	WHERE puntuacion >= 4

-- 6.Mostrar la cantidad de veganos que esten entre los 14 y 50 años de
-- edad para saber si hemos cumplido con nuestro segmento objetivo y
-- poder comprobar si nuestra cumplio su objetivo o no.

CREATE VIEW [Veganos Entre 14 y 50 anios]
AS
	SELECT COUNT(*) cantidad
	FROM ClientInfo
	WHERE vegano = 1 AND edad between 14 and 50

-- 7. Informacion completa de los alimentos

CREATE VIEW InfoAlimentos
AS
	SELECT al.id, al_tipo.id id_tipo_alimento, al_inf.id id_informacion_nutricional, al_tipo.nombre tipo, al.nombre, al_inf.proteinas, al_inf.calorias, al_inf.carbohidratos, al_inf.grasas, al_inf.peso_ref
	FROM Alimento al
	INNER JOIN InformacionNutricional al_inf
	ON al.id_informacion_nutricional = al_inf.id
	INNER JOIN TipoAlimento al_tipo
	ON al.id_tipo_alimento = al_tipo.id

-- 8. Informacion completa de los alimentos con receta

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

-- 9. Informacion de UN alimento

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

-- 10. Informacion de UN alimento con receta

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

-- 11. Informacion Alimento por Tipo

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

-- 12. Informacion completa de las cita

CREATE VIEW [Citas Info]
AS
	Select  c.id id_cita, ce.id id_exp, id_nutricionista, id_cliente, fecha, estado, comentario_nutricionista, ce.comentario comentario_cliente, ce.puntuacion
	FROM Cita c
	INNER JOIN ComentarioExperiencia ce
	ON ce.id_cita = c.id

-- 13. Informacion completa de las citas por cliente

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

-- 14. Informacion completa de las citas por nutricionista

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

-- 15. Informacion de las boletas de suscripccion

CREATE VIEW [Boletas Cliente]
AS
	SELECT bol.id, bol.id_cliente, bol.fecha_suscrita, paq.id id_paquete, paq.tipo, paq.meses, paq.pago_mensual
	FROM Boleta bol
	INNER JOIN Cliente cli
	ON bol.id_cliente = cli.id_usuario
	INNER JOIN Paquete paq
	ON bol.id_paquete = paq.id

-- 16. Ultima Suscripcion 

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

-- 17. Informacion de procedimiento alimenticio por cliente y fecha

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

-- 18. Informacon Completa del Cliente

CREATE VIEW [ClientInfo]
AS
	SELECT dni as DNI, edad, nombre, correo, telefono, fecha_nacimiento, fecha_registro, id, vegano, abusivo, suscrito
	FROM Usuario u
	Inner Join Cliente c
	ON c.id_usuario = u.id

-- 19. Informacion Completa del Nutricionista

CREATE VIEW [NutriInfo]
AS
	SELECT dni, edad,nombre, correo, telefono, fecha_nacimiento, fecha_registro, id, puntuacion, cuenta, descripcion, activo
	FROM Usuario u
	INNER JOIN Nutricionista n
	ON n.id_usuario = u.id

-- 20 Datos del cliente segun mes y año

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