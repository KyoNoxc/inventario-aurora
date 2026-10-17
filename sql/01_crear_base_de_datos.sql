-- Inventario Aurora — crea toda la base de datos de una sola vez
--
-- Cómo usarlo (en un proyecto NUEVO de Supabase):
--   Supabase → SQL Editor → New query → pegar todo este archivo → Run
-- Se ejecuta una sola vez. Si sale "Success. No rows returned", quedó listo.
-- Después, si quieres datos de ejemplo, corre también 02_datos_de_ejemplo.sql.

-- ============ Inventario ============

create table items (
  id text primary key,
  name text not null,
  category text not null,
  location text not null,
  qty numeric(12,3) not null default 1,
  unit text not null default 'pza',
  status text not null default 'disponible',
  created_at timestamptz default now(),
  constraint items_unit_check check (unit in ('pza', 'm', 'kg'))
);

create table movements (
  id bigint generated always as identity primary key,
  item_id text references items(id) on delete cascade,
  action text not null,
  by_user text,
  created_at timestamptz default now()
);

-- ============ Reportes de servicio ============

create table reports (
  id bigint generated always as identity primary key,
  client text,
  service_type text,
  labor_cost numeric(10,2) default 0,
  labor_hours numeric(6,2) default 0,
  created_by text,
  created_at timestamptz default now(),
  zone text,
  site_address text,
  service_date date,
  urgent text,
  crew text,
  report_time text,
  departure_time text,
  arrival_time text,
  finish_datetime text,
  fault_reported text,
  reported_by text,
  diagnosis text,
  equipment_desc text,
  work_done text,
  site_code text,
  ordered_by text
);

create table report_items (
  id bigint generated always as identity primary key,
  report_id bigint references reports(id) on delete cascade,
  item_id text references items(id),
  item_name text not null,
  qty_used numeric(12,3) not null,
  unit text default 'pza'
);

-- ============ Seguridad ============
-- Solo pueden ver y modificar datos las personas que inicien sesión
-- con una cuenta creada por ti (Authentication → Users).

alter table items enable row level security;
alter table movements enable row level security;
alter table reports enable row level security;
alter table report_items enable row level security;

create policy "leer items" on items for select using (auth.role() = 'authenticated');
create policy "crear items" on items for insert with check (auth.role() = 'authenticated');
create policy "editar items" on items for update using (auth.role() = 'authenticated');
create policy "eliminar items" on items for delete using (auth.role() = 'authenticated');

create policy "leer movimientos" on movements for select using (auth.role() = 'authenticated');
create policy "crear movimientos" on movements for insert with check (auth.role() = 'authenticated');

create policy "leer reportes" on reports for select using (auth.role() = 'authenticated');
create policy "crear reportes" on reports for insert with check (auth.role() = 'authenticated');
create policy "editar reportes" on reports for update using (auth.role() = 'authenticated');
create policy "eliminar reportes" on reports for delete using (auth.role() = 'authenticated');

create policy "leer detalle reportes" on report_items for select using (auth.role() = 'authenticated');
create policy "crear detalle reportes" on report_items for insert with check (auth.role() = 'authenticated');
create policy "eliminar detalle reportes" on report_items for delete using (auth.role() = 'authenticated');
