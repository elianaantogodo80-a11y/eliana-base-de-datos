SELECT
 p.nombres,
p.apellidos,
COUNT(c.id) AS total_citas_ultimo_mes
FROM pacientes p
JOIN citas c ON p.id = c.id_paciente
WHERE c.fecha_hora >= CURRENT_DATE - INTERVAL '1 month'
GROUP BY p.id, p.nombres, p.apellidos
HAVING COUNT(c.id) >= 3;


SELECT
e.nombre AS especialidad,
d.nombre || ' ' || d.apellidos AS doctor,
COUNT(c.id) AS total_citas
FROM doctores d
JOIN especialidades e ON d.id_especialidad = e.id
LEFT JOIN citas c ON d.id = c.id_doctor
GROUP BY e.nombre, d.nombre, d.apellidos
ORDER BY especialidad, total_citas DESC;

SELECT
nombre,
stock,
stock_min,
(stock_min - stock) AS cantidad_a_pedir
FROM medicamentos
WHERE stock < stock_min AND activo = TRUE
ORDER BY cantidad_a_pedir DESC;

SELECT
h.tipo,
COUNT(h.id) AS total_disponible
FROM habitaciones h
LEFT JOIN asignacion_habitacion ah ON h.id = ah.id_habitacion
AND ah.fecha_salida IS NULL
WHERE h.activa = TRUE
AND ah.id IS NULL 
GROUP BY h.tipo
ORDER BY h.tipo;

SELECT
    p.nombres || ' ' || p.apellidos AS paciente,
    c.fecha_hora AS fecha_cita,
    dtr.nombre || ' ' || dtr.apellidos AS doctor_tratante,
    dg.descripcion AS diagnostico,
    t.tipo AS tipo_tratamiento,
    t.indicaciones,
    STRING_AGG(m.nombre || ' (' || tm.dosis || ')', ' | ') AS medicamentos_prescritos
FROM pacientes p
JOIN citas c ON p.id = c.id_paciente
JOIN doctores dtr ON c.id_doctor = dtr.id
LEFT JOIN diagnosticos dg ON c.id = dg.id_cita
LEFT JOIN tratamientos t ON dg.id = t.id_diagnostico
LEFT JOIN tratamiento_medicamento tm ON t.id = tm.id_tratamiento
LEFT JOIN medicamentos m ON tm.id_medicamento = m.id
WHERE p.id = 1
GROUP BY 1, 2, 3, 4, 5, 6
ORDER BY c.fecha_hora DESC;
