-- Inventario Aurora — datos de ejemplo de una empresa ficticia (Climatización Aurora)
--
-- Qué hace:
--   1) BORRA todo lo que haya en ítems, historial y reportes.
--   2) Carga ítems, historial y 3 reportes de ejemplo.
--
-- Se puede correr las veces que quieras: cada vez deja la demo como nueva.
-- Cuidado: borra datos. Úsalo solo en una base que sea de demostración.
-- No toca las cuentas de usuario (Authentication → Users).

-- ============ 1) Limpiar ============
truncate table report_items, reports, movements, items restart identity cascade;

-- ============ 2) Ítems ============
insert into items (id, name, category, location, qty, unit, status, created_at) values
  ('HR-001', 'Manifold digital de 4 vías',            'Herramienta', 'Almacén',     3,     'pza', 'disponible', now() - interval '40 days'),
  ('HR-002', 'Bomba de vacío 5 CFM',                  'Herramienta', 'Camioneta',   4,     'pza', 'disponible', now() - interval '40 days'),
  ('HR-003', 'Pinza amperimétrica',                   'Herramienta', 'Camioneta',   3,     'pza', 'disponible', now() - interval '38 days'),
  ('HR-004', 'Cortador de tubo de cobre',             'Herramienta', 'Camioneta',   3,     'pza', 'disponible', now() - interval '38 days'),
  ('HR-005', 'Juego de abocardador y expansor',       'Herramienta', 'Almacén',     4,     'pza', 'disponible', now() - interval '35 days'),
  ('HR-006', 'Detector de fugas electrónico',         'Herramienta', 'Almacén',     3,     'pza', 'dañado',     now() - interval '35 days'),
  ('HR-007', 'Termómetro infrarrojo',                 'Herramienta', 'En servicio', 3,     'pza', 'uso',        now() - interval '30 days'),
  ('EQ-001', 'Báscula para gas refrigerante',         'Equipo',      'Camioneta',   3,     'pza', 'disponible', now() - interval '40 days'),
  ('EQ-002', 'Escalera de tijera 8 pies',             'Equipo',      'Camioneta',   4,     'pza', 'disponible', now() - interval '40 days'),
  ('EQ-003', 'Hidrolavadora para serpentines',        'Equipo',      'Almacén',     3,     'pza', 'disponible', now() - interval '32 days'),
  ('EQ-004', 'Equipo de soldadura oxiacetilénica',    'Equipo',      'En servicio', 3,     'pza', 'uso',        now() - interval '32 days'),
  ('MT-001', 'Tubería de cobre 1/4"',                 'Material',    'Almacén',     38.5,  'm',   'disponible', now() - interval '28 days'),
  ('MT-002', 'Tubería de cobre 3/8"',                 'Material',    'Almacén',     42,    'm',   'disponible', now() - interval '28 days'),
  ('MT-003', 'Cable de uso rudo 4x14',                'Material',    'Almacén',     120,   'm',   'disponible', now() - interval '28 days'),
  ('MT-004', 'Gas refrigerante R410A',                'Material',    'Almacén',     11.3,  'kg',  'disponible', now() - interval '25 days'),
  ('MT-005', 'Gas refrigerante R32',                  'Material',    'Camioneta',   1.8,   'kg',  'disponible', now() - interval '25 days'),
  ('MT-006', 'Aislante térmico para tubería 3/8"',    'Material',    'Almacén',     64,    'm',   'disponible', now() - interval '25 days'),
  ('MT-007', 'Soldadura de plata 15%',                'Material',    'Camioneta',   0.35,  'kg',  'disponible', now() - interval '25 days'),
  ('CS-001', 'Cinta vulcanizante',                    'Consumible',  'Almacén',     14,    'pza', 'disponible', now() - interval '22 days'),
  ('CS-002', 'Capacitor de arranque 35 µF',           'Consumible',  'Almacén',     8,     'pza', 'disponible', now() - interval '22 days'),
  ('CS-003', 'Filtro deshidratador 3/8"',             'Consumible',  'Almacén',     5,     'pza', 'disponible', now() - interval '22 days'),
  ('CS-004', 'Contactor 2P 30A',                      'Consumible',  'Camioneta',   1,     'pza', 'disponible', now() - interval '20 days'),
  ('CS-005', 'Abrazaderas de nylon (bolsa)',          'Consumible',  'Almacén',     12,    'pza', 'disponible', now() - interval '20 days'),
  ('CS-006', 'Termostato programable',                'Consumible',  'Almacén',     0,     'pza', 'disponible', now() - interval '18 days');

-- ============ 3) Reportes ============
insert into reports (client, service_type, labor_cost, labor_hours, created_by, created_at, zone, site_address, service_date, urgent, crew,
                     report_time, departure_time, arrival_time, finish_datetime, fault_reported, diagnosis, equipment_desc, work_done, site_code, ordered_by)
values
  ('Panadería La Espiga', 'Reparación', 850, 3, 'Equipo Aurora', now() - interval '6 days', 'Centro', 'Av. Juárez 120', current_date - 6, 'si', 'Cuadrilla A',
   '08:15', '08:50', '09:20', to_char((current_date - 6) + time '12:10', 'YYYY-MM-DD"T"HH24:MI'),
   'La cámara de refrigeración no enfría',
   'Capacitor de arranque dañado y baja presión por una fuga pequeña en la unión de la línea de succión.',
   'Condensadora de 2 toneladas, 220 V, gas R410A',
   E'Revisión eléctrica y de presiones\nCambio de capacitor de arranque\nSoldado de la unión y recarga de gas\nPrueba de funcionamiento',
   'PE-014', 'Rosa Medina'),
  ('Clínica Dental Sonrisa', 'Mantenimiento', 1200, 4, 'Equipo Aurora', now() - interval '3 days', 'Norte', 'Calle Hidalgo 45, local 2', current_date - 3, 'no', 'Cuadrilla B',
   '09:00', '09:30', '10:00', to_char((current_date - 3) + time '14:00', 'YYYY-MM-DD"T"HH24:MI'),
   'Mantenimiento preventivo de tres minisplit',
   'Filtros saturados de polvo y drenaje parcialmente obstruido en una de las unidades.',
   '3 minisplit inverter de 1 tonelada',
   E'Lavado de evaporadores y filtros\nLimpieza de drenajes\nRevisión de presiones y temperatura de salida',
   'CD-003', 'Dr. Luis Ibarra'),
  ('Restaurante El Fogón', 'Instalación', 2400, 7, 'Equipo Aurora', now() - interval '1 day', 'Sur', 'Blvd. del Valle 800', current_date - 1, '', 'Cuadrilla A',
   '07:30', '08:00', '08:40', to_char((current_date - 1) + time '16:30', 'YYYY-MM-DD"T"HH24:MI'),
   'Instalación de equipo nuevo en cocina',
   'El sitio cuenta con preparación eléctrica; se necesita línea de cobre de 6 m y alimentación nueva.',
   'Minisplit de 2 toneladas, 220 V, gas R32',
   E'Colocación de soporte y unidad condensadora\nTendido de tubería y vacío\nConexión eléctrica y arranque',
   'RF-021', 'Mariana Ochoa');

-- Materiales y servicios de cada reporte (item_id vacío = servicio, no mueve inventario)
insert into report_items (report_id, item_id, item_name, qty_used, unit) values
  (1, 'CS-002', 'Capacitor de arranque 35 µF',      1,    'pza'),
  (1, 'MT-004', 'Gas refrigerante R410A',           0.65, 'kg'),
  (1, 'MT-007', 'Soldadura de plata 15%',           0.05, 'kg'),
  (1, null,     'Traslado a sitio',                 1,    'servicio'),
  (2, 'CS-001', 'Cinta vulcanizante',               1,    'pza'),
  (2, 'MT-006', 'Aislante térmico para tubería 3/8"', 2.5, 'm'),
  (2, null,     'Mantenimiento preventivo de minisplit', 3, 'servicios'),
  (3, 'MT-001', 'Tubería de cobre 1/4"',            6,    'm'),
  (3, 'MT-002', 'Tubería de cobre 3/8"',            6,    'm'),
  (3, 'MT-003', 'Cable de uso rudo 4x14',           8,    'm'),
  (3, 'MT-005', 'Gas refrigerante R32',             0.4,  'kg'),
  (3, 'MT-006', 'Aislante térmico para tubería 3/8"', 6,  'm'),
  (3, null,     'Traslado a sitio',                 1,    'servicio');

-- ============ 4) Historial ============
insert into movements (item_id, action, by_user, created_at)
select id, 'Ítem agregado al inventario', 'Equipo Aurora', created_at from items;

insert into movements (item_id, action, by_user, created_at) values
  ('CS-002', 'Usado 1 pza(s) en reporte REP-0001 · Panadería La Espiga',       'Equipo Aurora', now() - interval '6 days'),
  ('MT-004', 'Usado 0.65 kg en reporte REP-0001 · Panadería La Espiga',        'Equipo Aurora', now() - interval '6 days'),
  ('MT-007', 'Usado 0.05 kg en reporte REP-0001 · Panadería La Espiga',        'Equipo Aurora', now() - interval '6 days'),
  ('CS-001', 'Usado 1 pza(s) en reporte REP-0002 · Clínica Dental Sonrisa',    'Equipo Aurora', now() - interval '3 days'),
  ('MT-006', 'Usado 2.5 m en reporte REP-0002 · Clínica Dental Sonrisa',       'Equipo Aurora', now() - interval '3 days'),
  ('MT-001', 'Usado 6 m en reporte REP-0003 · Restaurante El Fogón',           'Equipo Aurora', now() - interval '1 day'),
  ('MT-002', 'Usado 6 m en reporte REP-0003 · Restaurante El Fogón',           'Equipo Aurora', now() - interval '1 day'),
  ('MT-003', 'Usado 8 m en reporte REP-0003 · Restaurante El Fogón',           'Equipo Aurora', now() - interval '1 day'),
  ('MT-005', 'Usado 0.4 kg en reporte REP-0003 · Restaurante El Fogón',        'Equipo Aurora', now() - interval '1 day'),
  ('MT-006', 'Usado 6 m en reporte REP-0003 · Restaurante El Fogón',           'Equipo Aurora', now() - interval '1 day'),
  ('MT-004', 'Se agregaron 5 kg al stock (compra nueva)',                      'Equipo Aurora', now() - interval '12 days'),
  ('HR-006', 'Estado cambiado a "Dañado"',                                     'Equipo Aurora', now() - interval '8 days'),
  ('HR-007', 'Estado cambiado a "En uso"',                                     'Equipo Aurora', now() - interval '2 days');
