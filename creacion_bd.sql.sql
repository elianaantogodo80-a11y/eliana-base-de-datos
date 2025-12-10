CREATE TABLE pacientes (
  id SERIAL PRIMARY KEY,
  nombres VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  fecha_nac DATE NOT NULL,
  sexo CHAR(1) NOT NULL,
  contacto VARCHAR(100) NOT NULL,
  alergias TEXT DEFAULT '',
  antecedentes TEXT DEFAULT '',
  activo BOOLEAN NOT NULL DEFAULT true 
  
CONSTRAINT check_pacientes_nombres CHECK (char_length(nombres) > 0),
CONSTRAINT check_pacientes_apellidos CHECK (char_length(apellidos) > 0),
CONSTRAINT check_pacientes_sexo CHECK (sexo IN ('F', 'M', 'O')),
CONSTRAINT check_pacientes_fecha CHECK (fecha_nac <= CURRENT_DATE),
CONSTRAINT check_pacientes_contacto CHECK (char_length(contacto) > 0)
);

CREATE TABLE especialidades (
id SERIAL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL UNIQUE,
descripcion TEXT DEFAULT '',
activa BOOLEAN NOT NULL DEFAULT TRUE

CONSTRAINT check_especialidad_nombre CHECK (char_length(nombre) > 0),
CONSTRAINT check_especialidad_desc_min CHECK (char_length(descripcion) >= 0)
);

CREATE TABLE doctores (
id SERIAL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
apellidos VARCHAR(100) NOT NULL,
nro_colegiatura VARCHAR(30) NOT NULL UNIQUE,
id_especialidad INT NOT NULL,
activo BOOLEAN NOT NULL DEFAULT TRUE,

CONSTRAINT fk_doctor_especialidad
FOREIGN KEY (id_especialidad) 
REFERENCES especialidades(id)
ON DELETE RESTRICT ON UPDATE CASCADE,


CONSTRAINT check_doctor_nombre CHECK (char_length(nombre) > 0), 
CONSTRAINT check_doctor_apellido CHECK (char_length(apellidos) > 0), 
CONSTRAINT check_doctor_colegiatura CHECK (char_length(nro_colegiatura) > 0)
);

CREATE TABLE habitaciones (
    id SERIAL PRIMARY KEY,
    numero INT NOT NULL UNIQUE,
    tipo VARCHAR(20) NOT NULL,
    piso INT NOT NULL,
    activa BOOLEAN NOT NULL DEFAULT TRUE,

 CONSTRAINT check_habitacion_numero CHECK (numero > 0),
    CONSTRAINT check_habitacion_tipo CHECK (tipo IN ('individual', 'doble', 'suite')), -- CORREGIDO: 'suitee' cambiado a 'suite'
    CONSTRAINT check_habitacion_piso CHECK (piso >= 1)
    -- Se eliminó CHECK (activa IN (TRUE, FALSE)) por ser redundante
);
CREATE TABLE citas (
  id SERIAL PRIMARY KEY,
  id_paciente INT NOT NULL,
  id_doctor INT NOT NULL,
  fecha_hora TIMESTAMP NOT NULL,
  estado VARCHAR(15) NOT NULL DEFAULT 'programada',
  motivo VARCHAR(200) NOT NULL,
  
  CONSTRAINT fk_cita_paciente FOREIGN KEY (id_paciente) REFERENCES pacientes(id)
  ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_cita_doctor FOREIGN KEY (id_doctor) REFERENCES doctores(id)
  ON DELETE RESTRICT ON UPDATE CASCADE,
 
  CHECK (estado IN ('programada','atendida','cancelada')),
  CHECK (char_length(motivo) > 0),
  CHECK (fecha_hora >= '2000-01-01'::timestamp)
);
CREATE TABLE diagnosticos (
  id SERIAL PRIMARY KEY,
  id_cita INT NOT NULL,
  codigo_cie VARCHAR(10) NOT NULL,
  descripcion TEXT NOT NULL,
  severidad VARCHAR(10) NOT NULL DEFAULT 'leve',
  
  CONSTRAINT fk_diag_cita FOREIGN KEY (id_cita) REFERENCES citas(id)
  ON DELETE CASCADE ON UPDATE CASCADE,

  CHECK (char_length(codigo_cie) > 0),
  CHECK (char_length(descripcion) > 0),
  CHECK (severidad IN ('leve','moderada','severa'))
);
CREATE TABLE tratamientos (
  id SERIAL PRIMARY KEY,
  id_diagnostico INT NOT NULL,
  tipo VARCHAR(20) NOT NULL,
  indicaciones TEXT NOT NULL,
  duracion_dias INT NOT NULL DEFAULT 7,
  
  CONSTRAINT fk_trat_diag FOREIGN KEY (id_diagnostico) REFERENCES diagnosticos(id)
  ON DELETE CASCADE ON UPDATE CASCADE,

  CHECK (tipo IN ('farmacologico','rehabilitacion','quirurgico')),
  CHECK (char_length(indicaciones) > 0),
  CHECK (duracion_dias >= 0)
);
CREATE TABLE medicamentos (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL UNIQUE,
  forma VARCHAR(40) NOT NULL,
  dosis_std  VARCHAR(40) NOT NULL,
  stock INT NOT NULL DEFAULT 10,
  stock_min  INT NOT NULL DEFAULT 0,
  caducidad  DATE NOT NULL,
  activo BOOLEAN NOT NULL DEFAULT TRUE,

  CHECK (stock >= 0),
  CHECK (stock_min >= 0),
  CHECK (caducidad >= CURRENT_DATE)
);
CREATE TABLE asignacion_habitacion (
id SERIAL PRIMARY KEY,
id_paciente INT NOT NULL,
id_habitacion INT NOT NULL,
fecha_ingreso TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
fecha_salida TIMESTAMP,
    
CONSTRAINT fk_ah_paciente FOREIGN KEY (id_paciente) 
REFERENCES pacientes(id)ON DELETE RESTRICT ON UPDATE CASCADE,
    
CONSTRAINT fk_ah_habitacion FOREIGN KEY (id_habitacion)
REFERENCES habitaciones(id)ON DELETE RESTRICT ON UPDATE CASCADE,

CONSTRAINT check_fechas_coherentes CHECK (fecha_salida IS NULL OR fecha_salida > fecha_ingreso)
);
CREATE TABLE tratamiento_medicamento (
id_tratamiento INT NOT NULL,
id_medicamento INT NOT NULL,
cantidad INT NOT NULL,
dosis VARCHAR(50) NOT NULL,

PRIMARY KEY (id_tratamiento, id_medicamento),

CONSTRAINT fk_tm_tratamiento FOREIGN KEY (id_tratamiento)
REFERENCES tratamientos(id)ON DELETE CASCADE ON UPDATE CASCADE,

CONSTRAINT fk_tm_medicamento FOREIGN KEY (id_medicamento)
REFERENCES medicamentos(id)ON DELETE RESTRICT ON UPDATE CASCADE,

CONSTRAINT check_tm_cantidad CHECK (cantidad > 0)
);
