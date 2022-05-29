-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-05-29 14:20:26.674

CREATE DATABASE NutriSoft
GO

USE NutriSoft
GO

-- tables
-- Table: Alimento
CREATE TABLE Alimento (
    id int  NOT NULL IDENTITY,
    id_tipo_alimento int  NOT NULL,
    id_informacion_nutricional int  NOT NULL,
    nombre varchar(25)  NOT NULL,
    CONSTRAINT Alimento_pk PRIMARY KEY  (id)
);

-- Table: AlimentoMomentoDia
CREATE TABLE AlimentoMomentoDia (
    id int  NOT NULL IDENTITY,
    id_resumen_momento_dia int  NOT NULL,
    id_alimento int  NOT NULL,
    recomendado bit  NOT NULL,
    CONSTRAINT AlimentoMomentoDia_pk PRIMARY KEY  (id)
);

-- Table: Boleta
CREATE TABLE Boleta (
    id int  NOT NULL IDENTITY,
    id_cliente int  NOT NULL,
    id_paquete int  NOT NULL,
    fecha_suscrita datetime  NOT NULL,
    CONSTRAINT Boleta_pk PRIMARY KEY  (id)
);

-- Table: Certificado
CREATE TABLE Certificado (
    id int  NOT NULL IDENTITY,
    id_nutricionista int  NOT NULL,
    prueba image  NOT NULL,
    fecha_enviada datetime  NOT NULL,
    fecha_expiracion datetime  NULL,
    CONSTRAINT Certificado_pk PRIMARY KEY  (id)
);

-- Table: Cita
CREATE TABLE Cita (
    id int  NOT NULL IDENTITY,
    id_cliente int  NOT NULL,
    id_nutricionista int  NOT NULL,
    fecha datetime  NOT NULL,
    estado char(1)  NOT NULL,
    comentario_nutricionista varchar(500)  NULL,
    CONSTRAINT Cita_pk PRIMARY KEY  (id)
);

-- Table: Cliente
CREATE TABLE Cliente (
    id_usuario int  NOT NULL,
    vegano bit  NOT NULL,
    abusivo bit  NOT NULL,
    suscrito bit  NOT NULL,
    CONSTRAINT Cliente_pk PRIMARY KEY  (id_usuario)
);

-- Table: ComentarioExperiencia
CREATE TABLE ComentarioExperiencia (
    id int  NOT NULL IDENTITY,
    id_cita int  NOT NULL,
    comentario varchar(500)  NOT NULL,
    puntuacion int  NOT NULL,
    CONSTRAINT ComentarioExperiencia_pk PRIMARY KEY  (id)
);

-- Table: Contactos
CREATE TABLE Contactos (
    id int  NOT NULL IDENTITY,
    id_usuario int  NOT NULL,
    id_contacto int  NOT NULL,
    CONSTRAINT Contactos_pk PRIMARY KEY  (id)
);

-- Table: Horario
CREATE TABLE Horario (
    id int  NOT NULL IDENTITY,
    id_nutricionista int  NOT NULL,
    dia smallint  NOT NULL,
    hora_apertura time(1)  NOT NULL,
    hora_cierre time(1)  NOT NULL,
    CONSTRAINT Horario_pk PRIMARY KEY  (id)
);

-- Table: InformacionNutricional
CREATE TABLE InformacionNutricional (
    id int  NOT NULL IDENTITY,
    calorias real  NOT NULL,
    proteinas real  NOT NULL,
    carbohidratos real  NOT NULL,
    grasas real  NOT NULL,
    peso_ref real  NOT NULL,
    CONSTRAINT InformacionNutricional_pk PRIMARY KEY  (id)
);

-- Table: IngredientesBase
CREATE TABLE IngredientesBase (
    id int  NOT NULL IDENTITY,
    id_alimento int  NOT NULL,
    id_cliente int  NOT NULL,
    CONSTRAINT IngredientesBase_pk PRIMARY KEY  (id)
);

-- Table: IngredientesReceta
CREATE TABLE IngredientesReceta (
    id int  NOT NULL IDENTITY,
    id_alimento int  NOT NULL,
    id_receta int  NOT NULL,
    cantidad real  NOT NULL,
    CONSTRAINT IngredientesReceta_pk PRIMARY KEY  (id)
);

-- Table: MacroObjetivo
CREATE TABLE MacroObjetivo (
    id int  NOT NULL IDENTITY,
    calorias_max real  NOT NULL,
    proteinas_max real  NOT NULL,
    carbohidratos_max real  NOT NULL,
    grasas_max real  NOT NULL,
    CONSTRAINT MacroObjetivo_pk PRIMARY KEY  (id)
);

-- Table: MomentoDia
CREATE TABLE MomentoDia (
    id int  NOT NULL IDENTITY,
    nombre varchar(25)  NOT NULL,
    CONSTRAINT MomentoDia_pk PRIMARY KEY  (id)
);

-- Table: Nutricionista
CREATE TABLE Nutricionista (
    id_usuario int  NOT NULL,
    puntuacion real  NOT NULL,
    cuenta varchar(13)  NOT NULL,
    descripcion varchar(500)  NOT NULL,
    activo bit  NOT NULL,
    CONSTRAINT Nutricionista_pk PRIMARY KEY  (id_usuario)
);

-- Table: Objetivo
CREATE TABLE Objetivo (
    id int  NOT NULL IDENTITY,
    id_cliente int  NOT NULL,
    id_nutricionista int  NULL,
    id_tipo_objetivo int  NOT NULL,
    peso_objetivo real  NOT NULL,
    estado char(1)  NOT NULL,
    fecha_inicio date  NOT NULL,
    fecha_final int  NULL,
    tiempo_estimado int  NULL,
    CONSTRAINT Objetivo_pk PRIMARY KEY  (id)
);

-- Table: PagoNutricionista
CREATE TABLE PagoNutricionista (
    id int  NOT NULL IDENTITY,
    id_nutricionista int  NOT NULL,
    monto money  NOT NULL,
    fecha date  NOT NULL,
    CONSTRAINT PagoNutricionista_pk PRIMARY KEY  (id)
);

-- Table: Paquete
CREATE TABLE Paquete (
    id int  NOT NULL IDENTITY,
    tipo varchar(10)  NOT NULL,
    meses int  NOT NULL,
    pago_mensual real  NOT NULL,
    CONSTRAINT Paquete_pk PRIMARY KEY  (id)
);

-- Table: Receta
CREATE TABLE Receta (
    id int  NOT NULL IDENTITY,
    duracion int  NOT NULL,
    pasos varchar(500)  NOT NULL,
    url_video varchar(50)  NOT NULL,
    CONSTRAINT Receta_pk PRIMARY KEY  (id)
);

-- Table: RegistroDatosCliente
CREATE TABLE RegistroDatosCliente (
    id int  NOT NULL IDENTITY,
    id_cliente int  NOT NULL,
    peso real  NOT NULL,
    talla real  NOT NULL,
    fecha datetime  NOT NULL,
    CONSTRAINT RegistroDatosCliente_pk PRIMARY KEY  (id)
);

-- Table: ResumenDiario
CREATE TABLE ResumenDiario (
    id int  NOT NULL IDENTITY,
    id_macro int  NOT NULL,
    id_cliente int  NOT NULL,
    dia date  NOT NULL,
    CONSTRAINT ResumenDiario_pk PRIMARY KEY  (id)
);

-- Table: ResumenMomentoDia
CREATE TABLE ResumenMomentoDia (
    id int  NOT NULL IDENTITY,
    id_resumen_diario int  NOT NULL,
    id_tipo_momento int  NOT NULL,
    CONSTRAINT ResumenMomentoDia_pk PRIMARY KEY  (id)
);

-- Table: Tarjeta
CREATE TABLE Tarjeta (
    id int  NOT NULL IDENTITY,
    id_usuario int  NOT NULL,
    numero varchar(13)  NOT NULL,
    titular varchar(25)  NOT NULL,
    anio_expiracion int  NOT NULL,
    mes_expiracion int  NOT NULL,
    cvc int  NOT NULL,
    CONSTRAINT Tarjeta_pk PRIMARY KEY  (id)
);

-- Table: TipoAlimento
CREATE TABLE TipoAlimento (
    id int  NOT NULL IDENTITY,
    nombre varchar(50)  NOT NULL,
    CONSTRAINT TipoAlimento_pk PRIMARY KEY  (id)
);

-- Table: TipoObjetivo
CREATE TABLE TipoObjetivo (
    id int  NOT NULL IDENTITY,
    tipo varchar(25)  NOT NULL,
    CONSTRAINT TipoObjetivo_pk PRIMARY KEY  (id)
);

-- Table: Usuario
CREATE TABLE Usuario (
    id int  NOT NULL IDENTITY,
    dni int  NOT NULL,
    edad int  NOT NULL,
    nombre varchar(25)  NOT NULL,
    correo varchar(25)  NOT NULL,
    telefono varchar(25)  NOT NULL,
    fecha_nacimiento date  NOT NULL,
    fecha_registro datetime  NOT NULL,
    CONSTRAINT Usuario_pk PRIMARY KEY  (id)
);

-- foreign keys
-- Reference: AlimentoMomentoDia_Alimento (table: AlimentoMomentoDia)
ALTER TABLE AlimentoMomentoDia ADD CONSTRAINT AlimentoMomentoDia_Alimento
    FOREIGN KEY (id_alimento)
    REFERENCES Alimento (id);

-- Reference: AlimentoMomentoDia_ResumenMomentoDia (table: AlimentoMomentoDia)
ALTER TABLE AlimentoMomentoDia ADD CONSTRAINT AlimentoMomentoDia_ResumenMomentoDia
    FOREIGN KEY (id_resumen_momento_dia)
    REFERENCES ResumenMomentoDia (id);

-- Reference: Alimento_Clasificacion (table: Alimento)
ALTER TABLE Alimento ADD CONSTRAINT Alimento_Clasificacion
    FOREIGN KEY (id_tipo_alimento)
    REFERENCES TipoAlimento (id);

-- Reference: Alimento_InformacionNutricional (table: Alimento)
ALTER TABLE Alimento ADD CONSTRAINT Alimento_InformacionNutricional
    FOREIGN KEY (id_informacion_nutricional)
    REFERENCES InformacionNutricional (id);

-- Reference: Certificado_Nutricionista (table: Certificado)
ALTER TABLE Certificado ADD CONSTRAINT Certificado_Nutricionista
    FOREIGN KEY (id_nutricionista)
    REFERENCES Nutricionista (id_usuario);

-- Reference: Cita_Cliente (table: Cita)
ALTER TABLE Cita ADD CONSTRAINT Cita_Cliente
    FOREIGN KEY (id_cliente)
    REFERENCES Cliente (id_usuario);

-- Reference: Cita_Nutricionista (table: Cita)
ALTER TABLE Cita ADD CONSTRAINT Cita_Nutricionista
    FOREIGN KEY (id_nutricionista)
    REFERENCES Nutricionista (id_usuario);

-- Reference: Cliente_Usuario (table: Cliente)
ALTER TABLE Cliente ADD CONSTRAINT Cliente_Usuario
    FOREIGN KEY (id_usuario)
    REFERENCES Usuario (id);

-- Reference: ComentarioExperiencia_Cita (table: ComentarioExperiencia)
ALTER TABLE ComentarioExperiencia ADD CONSTRAINT ComentarioExperiencia_Cita
    FOREIGN KEY (id_cita)
    REFERENCES Cita (id);

-- Reference: Contactos_Cliente (table: Contactos)
ALTER TABLE Contactos ADD CONSTRAINT Contactos_Cliente
    FOREIGN KEY (id_usuario)
    REFERENCES Cliente (id_usuario);

-- Reference: DetallesObjetivo_MacroObjetivo (table: ResumenDiario)
ALTER TABLE ResumenDiario ADD CONSTRAINT DetallesObjetivo_MacroObjetivo
    FOREIGN KEY (id_macro)
    REFERENCES MacroObjetivo (id);

-- Reference: Horario_Nutricionista (table: Horario)
ALTER TABLE Horario ADD CONSTRAINT Horario_Nutricionista
    FOREIGN KEY (id_nutricionista)
    REFERENCES Nutricionista (id_usuario);

-- Reference: IngredientesBase_Alimento (table: IngredientesBase)
ALTER TABLE IngredientesBase ADD CONSTRAINT IngredientesBase_Alimento
    FOREIGN KEY (id_alimento)
    REFERENCES Alimento (id);

-- Reference: IngredientesBase_Cliente (table: IngredientesBase)
ALTER TABLE IngredientesBase ADD CONSTRAINT IngredientesBase_Cliente
    FOREIGN KEY (id_cliente)
    REFERENCES Cliente (id_usuario);

-- Reference: IngredientesReceta_Alimento (table: IngredientesReceta)
ALTER TABLE IngredientesReceta ADD CONSTRAINT IngredientesReceta_Alimento
    FOREIGN KEY (id_alimento)
    REFERENCES Alimento (id);

-- Reference: IngredientesReceta_Receta (table: IngredientesReceta)
ALTER TABLE IngredientesReceta ADD CONSTRAINT IngredientesReceta_Receta
    FOREIGN KEY (id_receta)
    REFERENCES Receta (id);

-- Reference: Nutricionista_Usuario (table: Nutricionista)
ALTER TABLE Nutricionista ADD CONSTRAINT Nutricionista_Usuario
    FOREIGN KEY (id_usuario)
    REFERENCES Usuario (id);

-- Reference: Objetivo_Cliente (table: Objetivo)
ALTER TABLE Objetivo ADD CONSTRAINT Objetivo_Cliente
    FOREIGN KEY (id_cliente)
    REFERENCES Cliente (id_usuario);

-- Reference: Objetivo_Nutricionista (table: Objetivo)
ALTER TABLE Objetivo ADD CONSTRAINT Objetivo_Nutricionista
    FOREIGN KEY (id_nutricionista)
    REFERENCES Nutricionista (id_usuario);

-- Reference: Objetivo_TipoObjetivo (table: Objetivo)
ALTER TABLE Objetivo ADD CONSTRAINT Objetivo_TipoObjetivo
    FOREIGN KEY (id_tipo_objetivo)
    REFERENCES TipoObjetivo (id);

-- Reference: PagoNutricionista_Nutricionista (table: PagoNutricionista)
ALTER TABLE PagoNutricionista ADD CONSTRAINT PagoNutricionista_Nutricionista
    FOREIGN KEY (id_nutricionista)
    REFERENCES Nutricionista (id_usuario);

-- Reference: RegistroDatosCliente_Cliente (table: RegistroDatosCliente)
ALTER TABLE RegistroDatosCliente ADD CONSTRAINT RegistroDatosCliente_Cliente
    FOREIGN KEY (id_cliente)
    REFERENCES Cliente (id_usuario);

-- Reference: ResumenDiario_Cliente (table: ResumenDiario)
ALTER TABLE ResumenDiario ADD CONSTRAINT ResumenDiario_Cliente
    FOREIGN KEY (id_cliente)
    REFERENCES Cliente (id_usuario);

-- Reference: ResumenMomentoDia_MomentoDia (table: ResumenMomentoDia)
ALTER TABLE ResumenMomentoDia ADD CONSTRAINT ResumenMomentoDia_MomentoDia
    FOREIGN KEY (id_tipo_momento)
    REFERENCES MomentoDia (id);

-- Reference: ResumenMomentoDia_ResumenDiario (table: ResumenMomentoDia)
ALTER TABLE ResumenMomentoDia ADD CONSTRAINT ResumenMomentoDia_ResumenDiario
    FOREIGN KEY (id_resumen_diario)
    REFERENCES ResumenDiario (id);

-- Reference: Suscripcion_Cliente (table: Boleta)
ALTER TABLE Boleta ADD CONSTRAINT Suscripcion_Cliente
    FOREIGN KEY (id_cliente)
    REFERENCES Cliente (id_usuario);

-- Reference: Suscripcion_Paquete (table: Boleta)
ALTER TABLE Boleta ADD CONSTRAINT Suscripcion_Paquete
    FOREIGN KEY (id_paquete)
    REFERENCES Paquete (id);

-- Reference: Tarjeta_Cliente (table: Tarjeta)
ALTER TABLE Tarjeta ADD CONSTRAINT Tarjeta_Cliente
    FOREIGN KEY (id_usuario)
    REFERENCES Cliente (id_usuario);

-- End of file.

