Para hacer esta base de datos se utilizaron cosas vistas en las pocas clases que dio :) 
el crear tablas y el insertar lo del check y las consultas se investigo previamente y 
se realizo humildemente, recuerde que me debe 1 pto del cafe, y si tiene buen corazon me pone otros para
ayudarme, recuerde que el que ayuda a otros le llueve plata despues, la decision esta en sus manos


El sistema está diseñado con un total de 10 tablas que modelan de forma granular
las entidades del hospital. Esta modularidad garantiza la flexibilidad y escalabilidad del sistema,
ya que cada concepto (paciente, doctor, cita, medicamento) se gestiona de forma independiente.

El esquema se adhiere estrictamente a la Tercera Forma Normal (3FN),
cuyo objetivo principal es eliminar la redundancia y evitar anomalías de actualización.

Ejemplo de eliminación de Redundancia: El nombre de la especialidad solo existe en especialidades.
En doctores, solo se utiliza id_especialidad (FK). 
Esto previene que se repita la descripción de la especialidad para cada doctor.

Resolución de M:N: Las relaciones complejas se manejan con tablas puente:
Un paciente puede ocupar varias habitaciones,
y una habitación tendrá varios pacientes a lo largo del tiempo: 
Resuelto por asignacion_habitacion.

Un tratamiento puede incluir varios medicamentos,
y un medicamento se usa en varios tratamientos: Resuelto por tratamiento_medicamento.

Claves Foráneas se implementario porque logicamene es necesario aparte para garantizar
que cada registro transaccional esté anclado a un dato maestro válido

Se utilizó la restricción CHECK para imponer la lógica del negocio:

Se garantiza que stock y stock_min no sean negativos y que la caducidad sea posterior
o igual a la fecha actual en medicamentos.

Para ya finalizar mando hacer unas consultas especificamente 5, vaya y vealas alli esta la informacion