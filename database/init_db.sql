-- database/init_db.sql (para PostgreSQL)

-- Eliminar tablas existentes para una ejecución limpia
-- Asegúrate de que las tablas se eliminen en el orden correcto
-- para evitar problemas de clave foránea.
DROP TABLE IF EXISTS verificaciones_cuenta CASCADE;
DROP TABLE IF EXISTS sesiones CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;
DROP TABLE IF EXISTS personal_ups CASCADE;
DROP TABLE IF EXISTS personal CASCADE;
DROP TABLE IF EXISTS medico_especialidad CASCADE;
DROP TABLE IF EXISTS medicos CASCADE;
DROP TABLE IF EXISTS persona_profesion CASCADE;
DROP TABLE IF EXISTS persona_estado_civil CASCADE;
DROP TABLE IF EXISTS persona_especialidad_medica CASCADE;
DROP TABLE IF EXISTS datos_contacto CASCADE;
DROP TABLE IF EXISTS documentos_persona CASCADE;
DROP TABLE IF EXISTS pacientes CASCADE;
DROP TABLE IF EXISTS atenciones_procedimiento CASCADE;
DROP TABLE IF EXISTS facturacion_procedimiento CASCADE;
DROP TABLE IF EXISTS facturacion_servicio CASCADE;
DROP TABLE IF EXISTS cupos_atencion CASCADE;
DROP TABLE IF EXISTS atenciones CASCADE;
DROP TABLE IF EXISTS turnos CASCADE;
DROP TABLE IF EXISTS ambiente_ups CASCADE;
DROP TABLE IF EXISTS ambientes CASCADE;
DROP TABLE IF EXISTS tarifario_procedimiento CASCADE;
DROP TABLE IF EXISTS procedimientos CASCADE;
DROP TABLE IF EXISTS tarifario_servicio CASCADE;
DROP TABLE IF EXISTS servicios CASCADE;
DROP TABLE IF EXISTS unidades_prestacionales_servicio CASCADE;
DROP TABLE IF EXISTS configuracion_general CASCADE;
DROP TABLE IF EXISTS parametros_sistema CASCADE;
DROP TABLE IF EXISTS menu_rol CASCADE;
DROP TABLE IF EXISTS menus CASCADE;
DROP TABLE IF EXISTS roles CASCADE;
DROP TABLE IF EXISTS auditoria_eventos CASCADE;
DROP TABLE IF EXISTS cuentas CASCADE;
DROP TABLE IF EXISTS especialidades_medicas CASCADE;
DROP TABLE IF EXISTS profesiones CASCADE;
DROP TABLE IF EXISTS colegios_profesionales CASCADE;
DROP TABLE IF EXISTS estados_administracion_procedimiento CASCADE;
DROP TABLE IF EXISTS estados_atencion CASCADE;
DROP TABLE IF EXISTS estados_civil CASCADE;
DROP TABLE IF EXISTS estados_cupo CASCADE;
DROP TABLE IF EXISTS estados_facturacion CASCADE;
DROP TABLE IF EXISTS personas CASCADE;
DROP TABLE IF EXISTS sexos CASCADE;
DROP TABLE IF EXISTS tipos_atencion CASCADE;
DROP TABLE IF EXISTS tipos_dato_contacto CASCADE;
DROP TABLE IF EXISTS tipos_documento_identificacion CASCADE;
DROP TABLE IF EXISTS tipos_procedimiento CASCADE;
DROP TABLE IF EXISTS tipos_turno CASCADE;
DROP TABLE IF EXISTS sede CASCADE;

-- Crear tipos ENUM personalizados
CREATE TYPE verificacion_tipo AS ENUM ('email', 'telefono');
CREATE TYPE estado_verificacion AS ENUM ('pendiente', 'verificado', 'expirado', 'fallido');


-- Volcando estructura para tabla clinica_db.configuracion_general
CREATE TABLE configuracion_general (
  "idConfiguracion" SERIAL PRIMARY KEY,
  "nombreClinica" VARCHAR(255) NOT NULL,
  "codigoClinica" VARCHAR(50) UNIQUE,
  direccion VARCHAR(255),
  telefono VARCHAR(50),
  email VARCHAR(100),
  "urlLogo" VARCHAR(255),
  "urlBackground" VARCHAR(255),
  "descripcionCorta" VARCHAR(255),
  mision TEXT,
  vision TEXT,
  valores TEXT,
  "fechaCreacion" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  "fechaModificacion" TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- ON UPDATE se manejará en la app o con un trigger
  estado BOOLEAN DEFAULT TRUE
);

-- Volcando estructura para tabla clinica_db.parametros_sistema
CREATE TABLE parametros_sistema (
  "idParametro" SERIAL PRIMARY KEY,
  clave VARCHAR(100) UNIQUE NOT NULL,
  valor TEXT,
  descripcion VARCHAR(255),
  "tipoDato" VARCHAR(50),
  grupo VARCHAR(100),
  "fechaCreacion" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  "fechaModificacion" TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- ON UPDATE se manejará en la app o con un trigger
  estado BOOLEAN DEFAULT TRUE
);

-- Volcando estructura para tabla clinica_db.roles
CREATE TABLE roles (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) UNIQUE NOT NULL,
  descripcion TEXT,
  estado BOOLEAN DEFAULT TRUE
);

-- Volcando datos para la tabla clinica_db.roles
INSERT INTO roles (nombre, descripcion, estado) VALUES
	('Administrador', 'Acceso completo al sistema', TRUE),
	('Recepcionista', 'Gestiona citas y pacientes', TRUE),
	('Medico', 'Acceso a historial médico y diagnósticos', TRUE);

-- Volcando estructura para tabla clinica_db.menus
CREATE TABLE menus (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  url VARCHAR(255),
  icono VARCHAR(50),
  orden INTEGER,
  "idMenuPadre" INTEGER,
  estado BOOLEAN DEFAULT TRUE,
  CONSTRAINT fk_menus_menu_padre FOREIGN KEY ("idMenuPadre") REFERENCES menus (id) ON DELETE CASCADE
);

-- Volcando datos para la tabla clinica_db.menus
INSERT INTO menus (id, nombre, url, icono, orden, "idMenuPadre", estado) VALUES
	(1, 'Dashboard', '/dashboard', 'fas fa-tachometer-alt', 1, NULL, TRUE),
	(2, 'Gestión', '#', 'fas fa-users-cog', 2, NULL, TRUE),
	(3, 'Pacientes', '/pacientes', 'fas fa-user-injured', 3, 2, TRUE),
	(4, 'Personal', '/personal', 'fas fa-user-nurse', 4, 2, TRUE),
	(5, 'Citas', '/citas', 'fas fa-calendar-alt', 5, NULL, TRUE),
	(6, 'Procedimientos', '/procedimientos', 'fas fa-procedures', 6, NULL, TRUE),
	(7, 'Facturación', '/facturacion', 'fas fa-file-invoice-dollar', 7, NULL, TRUE),
	(8, 'Auditoría', '/auditoria', 'fas fa-clipboard-list', 8, NULL, TRUE),
	(9, 'Configuración', '/configuracion', 'fas fa-cogs', 9, NULL, TRUE),
	(10, 'Roles y Permisos', '/configuracion/roles', 'fas fa-user-tag', 10, 9, TRUE),
	(11, 'Menús', '/configuracion/menus', 'fas fa-bars', 11, 9, TRUE);

-- Ajustar la secuencia de los IDs para `menus` después de las inserciones manuales
SELECT setval('menus_id_seq', (SELECT MAX(id) FROM menus), TRUE);


-- Volcando estructura para tabla clinica_db.menu_rol
CREATE TABLE menu_rol (
  id SERIAL PRIMARY KEY,
  "idMenu" INTEGER NOT NULL,
  "idRol" INTEGER NOT NULL,
  estado BOOLEAN DEFAULT TRUE,
  CONSTRAINT uq_menu_rol_idx UNIQUE ("idMenu","idRol"),
  CONSTRAINT fk_menu_rol_menus FOREIGN KEY ("idMenu") REFERENCES menus (id) ON DELETE CASCADE,
  CONSTRAINT fk_menu_rol_roles FOREIGN KEY ("idRol") REFERENCES roles (id) ON DELETE CASCADE
);

-- Volcando datos para la tabla clinica_db.menu_rol
INSERT INTO menu_rol (id, "idMenu", "idRol", estado) VALUES
	(1, 1, 1, TRUE),
	(2, 2, 1, TRUE),
	(3, 3, 1, TRUE),
	(4, 4, 1, TRUE),
	(5, 5, 1, TRUE),
	(6, 6, 1, TRUE),
	(7, 7, 1, TRUE),
	(8, 8, 1, TRUE),
	(9, 9, 1, TRUE),
	(10, 10, 1, TRUE),
	(11, 11, 1, TRUE),
	(12, 1, 2, TRUE),
	(13, 2, 2, TRUE),
	(14, 3, 2, TRUE),
	(15, 5, 2, TRUE),
	(16, 7, 2, TRUE),
	(17, 1, 3, TRUE),
	(18, 3, 3, TRUE),
	(19, 5, 3, TRUE),
	(20, 6, 3, TRUE);

-- Ajustar la secuencia de los IDs para `menu_rol` después de las inserciones manuales
SELECT setval('menu_rol_id_seq', (SELECT MAX(id) FROM menu_rol), TRUE);


-- Volcando estructura para tabla clinica_db.colegios_profesionales
CREATE TABLE colegios_profesionales (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(125),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.estados_administracion_procedimiento
CREATE TABLE estados_administracion_procedimiento (
  id SERIAL PRIMARY KEY,
  estado_administracion_procedimiento VARCHAR(45),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.estados_atencion
CREATE TABLE estados_atencion (
  id SERIAL PRIMARY KEY,
  estado_atencion VARCHAR(45),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.estados_civil
CREATE TABLE estados_civil (
  id SERIAL PRIMARY KEY,
  descripcion VARCHAR(45),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.estados_cupo
CREATE TABLE estados_cupo (
  id SERIAL PRIMARY KEY,
  descripcion VARCHAR(45),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.estados_facturacion
CREATE TABLE estados_facturacion (
  id SERIAL PRIMARY KEY,
  estado_facturacion VARCHAR(25),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.sexos
CREATE TABLE sexos (
  id SERIAL PRIMARY KEY,
  descripcion VARCHAR(45),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.personas
CREATE TABLE personas (
  id SERIAL PRIMARY KEY,
  apellido_paterno VARCHAR(45),
  apellido_materno VARCHAR(45),
  primer_nombre VARCHAR(45),
  segundo_nombre VARCHAR(45),
  otros_nombres VARCHAR(45),
  fecha_nacimiento DATE,
  sexo_id INTEGER,
  CONSTRAINT fk_personas_sexos FOREIGN KEY (sexo_id) REFERENCES sexos (id)
);

-- Volcando estructura para tabla clinica_db.pacientes
CREATE TABLE pacientes (
  id SERIAL PRIMARY KEY,
  persona_id INTEGER UNIQUE,
  fecha_registro DATE,
  estado BOOLEAN,
  CONSTRAINT fk_pacientes_personas FOREIGN KEY (persona_id) REFERENCES personas (id)
);

-- Volcando estructura para tabla clinica_db.personal
CREATE TABLE personal (
  id SERIAL PRIMARY KEY,
  persona_id INTEGER UNIQUE,
  fecha_inicio_relacion DATE,
  fecha_fin_relacion DATE,
  es_asistencial BOOLEAN,
  estado BOOLEAN,
  CONSTRAINT fk_personal_personas FOREIGN KEY (persona_id) REFERENCES personas (id)
);

-- Volcando estructura para tabla clinica_db.auditoria_eventos
CREATE TABLE auditoria_eventos (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER,
  evento_tipo VARCHAR(50) NOT NULL,
  tabla_afectada VARCHAR(100),
  registro_afectado_id INTEGER,
  valores_antiguos JSON,
  valores_nuevos JSON,
  descripcion TEXT,
  ip_direccion VARCHAR(45),
  fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_auditoria_eventos_usuarios FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE SET NULL
);

-- Volcando estructura para tabla clinica_db.cuentas
CREATE TABLE cuentas (
  id SERIAL PRIMARY KEY,
  fecha_creacion DATE,
  fecha_cierre DATE,
  fecha_anulacion DATE,
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.tipos_dato_contacto
CREATE TABLE tipos_dato_contacto (
  id SERIAL PRIMARY KEY,
  descripcion VARCHAR(45),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.datos_contacto
CREATE TABLE datos_contacto (
  id SERIAL PRIMARY KEY,
  tipo_dato_contacto_id INTEGER,
  dato VARCHAR(125),
  estado BOOLEAN,
  persona_id INTEGER,
  CONSTRAINT fk_datos_contactos_tipos_datos_contacto FOREIGN KEY (tipo_dato_contacto_id) REFERENCES tipos_dato_contacto (id),
  CONSTRAINT fk_datos_contactos_personas FOREIGN KEY (persona_id) REFERENCES personas (id)
);

-- Volcando estructura para tabla clinica_db.tipos_documento_identificacion
CREATE TABLE tipos_documento_identificacion (
  id SERIAL PRIMARY KEY,
  descripcion VARCHAR(45),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.documentos_persona
CREATE TABLE documentos_persona (
  id SERIAL PRIMARY KEY,
  persona_id INTEGER,
  tipo_documento_identificacion_id INTEGER,
  identificador VARCHAR(25),
  fecha_ingreso DATE,
  fecha_inhabilitacion DATE,
  estado BOOLEAN,
  CONSTRAINT uq_documento_persona_idx UNIQUE (persona_id, tipo_documento_identificacion_id, identificador),
  CONSTRAINT fk_documentos_personas_tipos_documento_identificacion FOREIGN KEY (tipo_documento_identificacion_id) REFERENCES tipos_documento_identificacion (id),
  CONSTRAINT fk_documentos_personas_personas FOREIGN KEY (persona_id) REFERENCES personas (id)
);

-- Volcando estructura para tabla clinica_db.profesiones
CREATE TABLE profesiones (
  id SERIAL PRIMARY KEY,
  descripcion VARCHAR(120),
  es_asistencial BOOLEAN,
  estado BOOLEAN,
  colegio_profesional_id INTEGER,
  CONSTRAINT fk_profesiones_colegios_profesionales FOREIGN KEY (colegio_profesional_id) REFERENCES colegios_profesionales (id)
);

-- Volcando estructura para tabla clinica_db.especialidades_medicas
CREATE TABLE especialidades_medicas (
  id SERIAL PRIMARY KEY,
  descripcion VARCHAR(75),
  profesion_id INTEGER,
  estado BOOLEAN,
  CONSTRAINT fk_especialidades_medicos_profesiones FOREIGN KEY (profesion_id) REFERENCES profesiones (id)
);

-- Volcando estructura para tabla clinica_db.medicos
CREATE TABLE medicos (
  id SERIAL PRIMARY KEY,
  personal_id INTEGER UNIQUE NOT NULL,
  nro_colegiatura_medica VARCHAR(15),
  estado BOOLEAN,
  CONSTRAINT fk_medicos_personal FOREIGN KEY (personal_id) REFERENCES personal (id)
);

-- Volcando estructura para tabla clinica_db.medico_especialidad
CREATE TABLE medico_especialidad (
  id SERIAL PRIMARY KEY,
  medico_id INTEGER NOT NULL,
  especialidad_medica_id INTEGER NOT NULL,
  fecha_asignacion DATE,
  estado BOOLEAN,
  CONSTRAINT uq_medico_especialidad_idx UNIQUE (medico_id, especialidad_medica_id),
  CONSTRAINT fk_medico_especialidad_especialidades_medicas FOREIGN KEY (especialidad_medica_id) REFERENCES especialidades_medicas (id),
  CONSTRAINT fk_medico_especialidad_medicos FOREIGN KEY (medico_id) REFERENCES medicos (id)
);

-- Volcando estructura para tabla clinica_db.persona_especialidad_medica
CREATE TABLE persona_especialidad_medica (
  id SERIAL PRIMARY KEY,
  persona_id INTEGER,
  especialidad_medica_id INTEGER,
  fecha_especializacion DATE,
  nro_especialidad VARCHAR(15),
  estado BOOLEAN,
  CONSTRAINT uq_persona_especialidad_medica_idx UNIQUE (persona_id, especialidad_medica_id, nro_especialidad),
  CONSTRAINT fk_persona_especialidad_medica_especialidades_medicos FOREIGN KEY (especialidad_medica_id) REFERENCES especialidades_medicas (id),
  CONSTRAINT fk_persona_especialidad_medica_personas FOREIGN KEY (persona_id) REFERENCES personas (id)
);

-- Volcando estructura para tabla clinica_db.persona_estado_civil
CREATE TABLE persona_estado_civil (
  id SERIAL PRIMARY KEY,
  persona_id INTEGER,
  estado_civil_id INTEGER,
  fecha_inicio DATE,
  fecha_fin DATE,
  vigente BOOLEAN,
  estado BOOLEAN,
  CONSTRAINT fk_persona_estados_civiles_estados_civil FOREIGN KEY (estado_civil_id) REFERENCES estados_civil (id),
  CONSTRAINT fk_persona_estados_civiles_personas FOREIGN KEY (persona_id) REFERENCES personas (id)
);

-- Volcando estructura para tabla clinica_db.persona_profesion
CREATE TABLE persona_profesion (
  id SERIAL PRIMARY KEY,
  persona_id INTEGER,
  profesion_id INTEGER,
  fecha_titulacion DATE,
  nro_colegiatura VARCHAR(15),
  estado BOOLEAN,
  CONSTRAINT uq_persona_profesion_idx UNIQUE (persona_id, profesion_id, nro_colegiatura),
  CONSTRAINT fk_personas_profesiones_personas FOREIGN KEY (persona_id) REFERENCES personas (id),
  CONSTRAINT fk_personas_profesiones_profesiones FOREIGN KEY (profesion_id) REFERENCES profesiones (id)
);

-- Volcando estructura para tabla clinica_db.sede
CREATE TABLE sede (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(120),
  direccion VARCHAR(120),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.unidades_prestacionales_servicio
CREATE TABLE unidades_prestacionales_servicio (
  id SERIAL PRIMARY KEY,
  codigo VARCHAR(45) UNIQUE NOT NULL,
  nombre VARCHAR(45),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.ambientes
CREATE TABLE ambientes (
  id SERIAL PRIMARY KEY,
  sede_id INTEGER,
  numero_piso INTEGER,
  denominacion VARCHAR(45),
  estado BOOLEAN,
  CONSTRAINT fk_ambientes_sede FOREIGN KEY (sede_id) REFERENCES sede (id)
);

-- Volcando estructura para tabla clinica_db.ambiente_ups
CREATE TABLE ambiente_ups (
  id SERIAL PRIMARY KEY,
  ambiente_id INTEGER,
  ups_id INTEGER,
  estado BOOLEAN,
  CONSTRAINT fk_ups_ambiente_ambientes FOREIGN KEY (ambiente_id) REFERENCES ambientes (id),
  CONSTRAINT fk_ups_ambiente_unidades_prestacionales_servicio FOREIGN KEY (ups_id) REFERENCES unidades_prestacionales_servicio (id)
);

-- Volcando estructura para tabla clinica_db.servicios
CREATE TABLE servicios (
  id SERIAL PRIMARY KEY,
  nombre_servicio VARCHAR(45),
  ups_id INTEGER,
  estado BOOLEAN,
  CONSTRAINT fk_servicios_unidades_prestacionales_servicio FOREIGN KEY (ups_id) REFERENCES unidades_prestacionales_servicio (id)
);

-- Volcando estructura para tabla clinica_db.tipos_atencion
CREATE TABLE tipos_atencion (
  id SERIAL PRIMARY KEY,
  tipo_atencion VARCHAR(45),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.tipos_turno
CREATE TABLE tipos_turno (
  id SERIAL PRIMARY KEY,
  denominacion VARCHAR(45),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.turnos
CREATE TABLE turnos (
  id SERIAL PRIMARY KEY,
  tipo_turno_id INTEGER,
  personal_asignado_id INTEGER,
  ups_id INTEGER,
  ambiente_id INTEGER,
  fecha_creacion DATE,
  fecha_prestacion DATE,
  fecha_anulacion DATE,
  estado BOOLEAN,
  tipo_atencion_id INTEGER,
  servicio_id INTEGER,
  CONSTRAINT fk_turnos_ambientes FOREIGN KEY (ambiente_id) REFERENCES ambientes (id),
  CONSTRAINT fk_turnos_personal FOREIGN KEY (personal_asignado_id) REFERENCES personal (id),
  CONSTRAINT fk_turnos_servicios FOREIGN KEY (servicio_id) REFERENCES servicios (id),
  CONSTRAINT fk_turnos_tipos_atencion FOREIGN KEY (tipo_atencion_id) REFERENCES tipos_atencion (id),
  CONSTRAINT fk_turnos_tipos_turno FOREIGN KEY (tipo_turno_id) REFERENCES tipos_turno (id),
  CONSTRAINT fk_turnos_unidades_prestacionales_servicio FOREIGN KEY (ups_id) REFERENCES unidades_prestacionales_servicio (id)
);

-- Volcando estructura para tabla clinica_db.cupos_atencion
CREATE TABLE cupos_atencion (
  id SERIAL PRIMARY KEY,
  turno_id INTEGER,
  hora_inicio TIME,
  hora_fin TIME,
  estado_cupo_id INTEGER,
  estado BOOLEAN,
  CONSTRAINT fk_cupos_atencion_estados_cupo FOREIGN KEY (estado_cupo_id) REFERENCES estados_cupo (id),
  CONSTRAINT fk_cupos_atencion_turnos FOREIGN KEY (turno_id) REFERENCES turnos (id)
);

-- Volcando estructura para tabla clinica_db.atenciones
CREATE TABLE atenciones (
  id SERIAL PRIMARY KEY,
  fecha_programacion DATE,
  paciente_id INTEGER,
  cupo_atencion_id INTEGER,
  estado_atencion_id INTEGER,
  estado BOOLEAN,
  CONSTRAINT fk_atenciones_cupos_atencion FOREIGN KEY (cupo_atencion_id) REFERENCES cupos_atencion (id),
  CONSTRAINT fk_atenciones_estados_atencion FOREIGN KEY (estado_atencion_id) REFERENCES estados_atencion (id),
  CONSTRAINT fk_atenciones_pacientes FOREIGN KEY (paciente_id) REFERENCES pacientes (id)
);

-- Volcando estructura para tabla clinica_db.tipos_procedimiento
CREATE TABLE tipos_procedimiento (
  id SERIAL PRIMARY KEY,
  codigo VARCHAR(45) UNIQUE,
  descripcion VARCHAR(45),
  estado BOOLEAN
);

-- Volcando estructura para tabla clinica_db.procedimientos
CREATE TABLE procedimientos (
  id SERIAL PRIMARY KEY,
  codigo VARCHAR(15),
  descripcion VARCHAR(45),
  tipo_procedimiento_id INTEGER,
  estado BOOLEAN,
  CONSTRAINT fk_procedimientos_tipos_procedimiento FOREIGN KEY (tipo_procedimiento_id) REFERENCES tipos_procedimiento (id)
);

-- Volcando estructura para tabla clinica_db.atenciones_procedimiento
CREATE TABLE atenciones_procedimiento (
  id SERIAL PRIMARY KEY,
  procedimiento_id INTEGER,
  fecha_orden DATE,
  atencion_id INTEGER,
  fecha_atencion DATE,
  estado_administracion_procedimiento_id INTEGER,
  estado BOOLEAN,
  CONSTRAINT fk_atenciones_procedimientos_atenciones FOREIGN KEY (atencion_id) REFERENCES atenciones (id),
  CONSTRAINT fk_atenciones_procedimientos_estados_administracion FOREIGN KEY (estado_administracion_procedimiento_id) REFERENCES estados_administracion_procedimiento (id),
  CONSTRAINT fk_atenciones_procedimientos_procedimientos FOREIGN KEY (procedimiento_id) REFERENCES procedimientos (id)
);

-- Volcando estructura para tabla clinica_db.tarifario_procedimiento
CREATE TABLE tarifario_procedimiento (
  id SERIAL PRIMARY KEY,
  procedimiento_id INTEGER,
  precio DECIMAL(10,2),
  fecha_creacion DATE,
  fecha_inicio_vigencia DATE,
  fecha_fin_vigencia DATE,
  estado BOOLEAN,
  CONSTRAINT fk_tarifario_procedimientos_procedimientos FOREIGN KEY (procedimiento_id) REFERENCES procedimientos (id)
);

-- Volcando estructura para tabla clinica_db.facturacion_procedimiento
CREATE TABLE facturacion_procedimiento (
  id SERIAL PRIMARY KEY,
  atencion_procedimiento_id INTEGER,
  tarifario_procedimiento_id INTEGER,
  fecha_creacion DATE,
  fecha_facturacion DATE,
  fecha_pago DATE,
  fecha_anulacion DATE,
  descuento DECIMAL(10,2),
  precio_final DECIMAL(10,2),
  estado_facturacion_id INTEGER,
  estado BOOLEAN,
  cuenta_id INTEGER,
  CONSTRAINT fk_facturacion_procedimientos_atencion_procedimiento FOREIGN KEY (atencion_procedimiento_id) REFERENCES atenciones_procedimiento (id),
  CONSTRAINT fk_facturacion_procedimientos_cuentas FOREIGN KEY (cuenta_id) REFERENCES cuentas (id),
  CONSTRAINT fk_facturacion_procedimientos_estados_facturacion FOREIGN KEY (estado_facturacion_id) REFERENCES estados_facturacion (id),
  CONSTRAINT fk_facturacion_procedimientos_tarifario_procedimiento FOREIGN KEY (tarifario_procedimiento_id) REFERENCES tarifario_procedimiento (id)
);

-- Volcando estructura para tabla clinica_db.tarifario_servicio
CREATE TABLE tarifario_servicio (
  id SERIAL PRIMARY KEY,
  servicio_id INTEGER,
  precio DECIMAL(10,2),
  fecha_creacion DATE,
  fecha_inicio_vigencia DATE,
  fecha_fin_vigencia DATE,
  estado BOOLEAN,
  CONSTRAINT fk_tarifario_servicios_servicios FOREIGN KEY (servicio_id) REFERENCES servicios (id)
);

-- Volcando estructura para tabla clinica_db.facturacion_servicio
CREATE TABLE facturacion_servicio (
  id SERIAL PRIMARY KEY,
  atencion_id INTEGER,
  cuenta_id INTEGER,
  tarifario_servicio_id INTEGER,
  fecha_creacion DATE,
  fecha_facturacion DATE,
  fecha_pago DATE,
  fecha_anulacion DATE,
  descuento DECIMAL(10,2),
  precio_final DECIMAL(10,2),
  estado_facturacion_id INTEGER,
  estado BOOLEAN,
  CONSTRAINT fk_facturacion_servicios_atenciones FOREIGN KEY (atencion_id) REFERENCES atenciones (id),
  CONSTRAINT fk_facturacion_servicios_cuentas FOREIGN KEY (cuenta_id) REFERENCES cuentas (id),
  CONSTRAINT fk_facturacion_servicios_estados_facturacion FOREIGN KEY (estado_facturacion_id) REFERENCES estados_facturacion (id),
  CONSTRAINT fk_facturacion_servicios_tarifario_servicio FOREIGN KEY (tarifario_servicio_id) REFERENCES tarifario_servicio (id)
);

-- Volcando estructura para tabla clinica_db.personal_ups
CREATE TABLE personal_ups (
  id SERIAL PRIMARY KEY,
  ups_id INTEGER,
  personal_id INTEGER,
  fecha_asignacion DATE,
  fecha_deshabilitacion DATE,
  estado BOOLEAN,
  CONSTRAINT fk_personal_ups_personal FOREIGN KEY (personal_id) REFERENCES personal (id),
  CONSTRAINT fk_personal_ups_unidades_prestacionales_servicio FOREIGN KEY (ups_id) REFERENCES unidades_prestacionales_servicio (id)
);

-- Volcando estructura para tabla clinica_db.usuarios
CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  username VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  email VARCHAR(100) UNIQUE,
  rol_id INTEGER NOT NULL,
  personal_id INTEGER UNIQUE,
  ultimo_login_at TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- ON UPDATE se manejará en la app o con un trigger
  CONSTRAINT fk_usuarios_personal FOREIGN KEY (personal_id) REFERENCES personal (id),
  CONSTRAINT fk_usuarios_roles FOREIGN KEY (rol_id) REFERENCES roles (id)
);

-- Volcando datos para la tabla clinica_db.usuarios
INSERT INTO usuarios (id, username, password_hash, email, rol_id, personal_id, ultimo_login_at, is_active, created_at, updated_at) VALUES
	(1, 'admin', '$2y$10$wN0.wH.t7.H.J.f.p.i.x.y.z.k.l.m.n.o.p.q.r.s.t.u.v.w.x.y.z', 'admin@example.com', 1, NULL, NULL, TRUE, '2025-07-05 22:03:54', '2025-07-05 22:03:54');

-- Ajustar la secuencia de los IDs para `usuarios` después de las inserciones manuales
SELECT setval('usuarios_id_seq', (SELECT MAX(id) FROM usuarios), TRUE);


-- Volcando estructura para tabla clinica_db.sesiones
CREATE TABLE sesiones (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER NOT NULL,
  token VARCHAR(255) UNIQUE NOT NULL,
  ip_direccion VARCHAR(45),
  dispositivo_info VARCHAR(255),
  login_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  logout_at TIMESTAMP,
  expires_at TIMESTAMP,
  estado BOOLEAN DEFAULT TRUE,
  CONSTRAINT fk_sesiones_usuarios FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE
);

-- Volcando estructura para tabla clinica_db.verificaciones_cuenta
CREATE TABLE verificaciones_cuenta (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER NOT NULL,
  tipo_verificacion verificacion_tipo NOT NULL, -- Usando el tipo ENUM personalizado
  codigo_verificacion VARCHAR(100) NOT NULL,
  fecha_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fecha_expiracion TIMESTAMP NOT NULL,
  verificado_at TIMESTAMP,
  estado estado_verificacion DEFAULT 'pendiente', -- Usando el tipo ENUM personalizado
  CONSTRAINT fk_verificaciones_cuenta_usuarios FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE
);