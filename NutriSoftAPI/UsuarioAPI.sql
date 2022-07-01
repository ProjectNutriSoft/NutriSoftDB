use NutriSoft
-- ## User API

CREATE VIEW [ClientLoginInfo]
AS
	SELECT c.id_usuario id, u.nombre, u.contrasenia
	FROM Usuario u
	Inner Join Cliente c
	ON c.id_usuario = u.id
	
CREATE VIEW [NutriLoginInfo]
AS
	SELECT n.id_usuario id, u.nombre, u.contrasenia
	FROM Usuario u
	Inner Join Nutricionista n
	ON n.id_usuario = u.id

CREATE VIEW [ClientInfo]
AS
	SELECT dni as DNI, edad, nombre, correo, telefono, fecha_nacimiento, fecha_registro, id, vegano, abusivo, suscrito
	FROM Usuario u
	Inner Join Cliente c
	ON c.id_usuario = u.id

CREATE VIEW [NutriInfo]
AS
	SELECT dni, edad,nombre, correo, telefono, fecha_nacimiento, fecha_registro, id, puntuacion, cuenta, descripcion, activo
	FROM Usuario u
	INNER JOIN Nutricionista n
	ON n.id_usuario = u.id