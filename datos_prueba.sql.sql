INSERT INTO especialidades (nombre, descripcion) VALUES
('Medicina General', 'Atención primaria'),
('Pediatría', 'Atención infantil'),
('Cardiología', 'Sistema cardiovascular');

INSERT INTO doctores (nombre, apellidos, nro_colegiatura, id_especialidad) VALUES
('Ana', 'Rojas', 'COL-1001', 1),
('Luis', 'Pérez', 'COL-1002', 2),
('María', 'Gómez', 'COL-1003', 3);

INSERT INTO pacientes (nombres, apellidos, fecha_nac, sexo, contacto, antecedentes) VALUES
('Carlos', 'Soto', '1985-06-10', 'M', '0414-0000000', 'Hipertensión'),
('Elena', 'Marín', '1992-11-22', 'F', '0412-1111111', 'Migraña'),
('José', 'Arias', '2005-03-05', 'M', '0416-2222222', 'Asma');

INSERT INTO habitaciones (numero, tipo, piso) VALUES
(101, 'individual', 1),
(102, 'doble', 1),
(201, 'suite', 2);

INSERT INTO medicamentos (nombre, forma, dosis_std, stock, stock_min, caducidad) VALUES
('Paracetamol', 'tableta', '500mg', 200, 50, CURRENT_DATE + INTERVAL '365 days'),
('Amoxicilina', 'capsula', '500mg', 40, 60, CURRENT_DATE + INTERVAL '120 days'),
('Ibuprofeno', 'tableta', '400mg', 20, 30, CURRENT_DATE + INTERVAL '180 days');

INSERT INTO citas (id_paciente, id_doctor, fecha_hora, estado, motivo) VALUES
(1, 1, CURRENT_DATE - INTERVAL '20 days' + TIME '10:00', 'atendida', 'Control'),
(1, 1, CURRENT_DATE - INTERVAL '10 days' + TIME '09:00', 'atendida', 'Dolor de cabeza'),
(1, 3, CURRENT_DATE - INTERVAL '5 days' + TIME '14:00', 'cancelada', 'Chequeo cardiaco'),
(2, 2, CURRENT_DATE + INTERVAL '2 days' + TIME '08:30', 'programada', 'Revisión pediátrica'), 
(3, 1, CURRENT_DATE - INTERVAL '25 days' + TIME '11:15', 'atendida', 'Consulta general');

INSERT INTO diagnosticos (id_cita, codigo_cie, descripcion, severidad) VALUES
(1, 'G44.1', 'Cefalea tensional', 'leve'),
(2, 'J45', 'Asma', 'moderada'),
(5, 'I10', 'Hipertensión esencial', 'moderada');

INSERT INTO tratamientos (id_diagnostico, tipo, indicaciones, duracion_dias) VALUES
(1, 'farmacologico', 'Paracetamol según dolor', 7),
(2, 'farmacologico', 'Broncodilatadores', 14),
(3, 'rehabilitacion', 'Ejercicio aeróbico', 30);

INSERT INTO asignacion_habitacion (id_paciente, id_habitacion, fecha_ingreso, fecha_salida) VALUES
(1, 1, CURRENT_DATE - interval '3 days', NULL), 
(2, 3, CURRENT_DATE - interval '1 day', NULL),
(3, 2, '2025-11-01', '2025-11-05');


INSERT INTO tratamiento_medicamento (id_tratamiento, id_medicamento, cantidad, dosis) VALUES
(1, 3, 30, 'Una tableta diaria por 30 días');