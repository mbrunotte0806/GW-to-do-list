-- ---------------------------------------------------------------
-- Grunwald Aufgabenliste: Tabelle, Zugriffsschutz, Live-Updates
-- Einmal im SQL Editor des Supabase-Projekts ausfuehren.
-- Das Skript ist wiederholbar, mehrfaches Ausfuehren schadet nicht.
-- ---------------------------------------------------------------

-- 1) Tabelle -----------------------------------------------------
create table if not exists public.tasks (
  id          uuid        primary key default gen_random_uuid(),
  task        text        not null check (length(btrim(task)) > 0),
  owner       text        not null,
  deadline    date        not null,
  status      text        not null default 'offen'
                          check (status in ('offen', 'bearbeitung', 'erledigt')),
  prio        text        not null default 'mittel'
                          check (prio in ('hoch', 'mittel', 'niedrig')),
  notes       text        not null default '',
  created_by  text        not null,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

create index if not exists tasks_deadline_idx on public.tasks (deadline);
create index if not exists tasks_status_idx   on public.tasks (status);

-- 2) updated_at automatisch pflegen ------------------------------
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $fn$
begin
  new.updated_at = now();
  return new;
end;
$fn$;

drop trigger if exists tasks_set_updated_at on public.tasks;
create trigger tasks_set_updated_at
  before update on public.tasks
  for each row execute function public.set_updated_at();

-- 3) Zugriffsschutz ----------------------------------------------
-- Ohne Anmeldung ist nichts lesbar und nichts aenderbar.
-- Erlaubt ist alles nur fuer angemeldete Nutzer, also fuer das
-- gemeinsame Team-Konto.
alter table public.tasks enable row level security;

drop policy if exists tasks_select on public.tasks;
drop policy if exists tasks_insert on public.tasks;
drop policy if exists tasks_update on public.tasks;
drop policy if exists tasks_delete on public.tasks;

create policy tasks_select on public.tasks
  for select to authenticated using (true);

create policy tasks_insert on public.tasks
  for insert to authenticated with check (true);

create policy tasks_update on public.tasks
  for update to authenticated using (true) with check (true);

create policy tasks_delete on public.tasks
  for delete to authenticated using (true);

-- 4) Live-Aktualisierung -----------------------------------------
-- Sorgt dafuer, dass Aenderungen sofort in allen offenen
-- Browsern erscheinen.
do $pub$
begin
  alter publication supabase_realtime add table public.tasks;
exception
  when duplicate_object then null;
end;
$pub$;
