-- ROUTE//EU v0.5 · Supabase-opsætning
-- Kør hele filen i Supabase → SQL Editor → New query → Run.
-- HUSK: skift 'SKIFT-MIG' (nederst i afsnit 3) til jeres egen PIN-kode, før I kører filen.

-- 1) Tabeller -------------------------------------------------------------
create table if not exists public.players (
  id               uuid primary key,
  session          text not null,          -- workshop-koden, fx "AAU"
  name             text not null,
  level            int  not null default 1,
  score            int  not null default 0,
  solved           int  not null default 0,
  best             jsonb not null default '{}'::jsonb,
  attempts         int  not null default 0,
  hints            int  not null default 0,
  last_result      text,
  level_started_at timestamptz default now(),
  updated_at       timestamptz default now(),
  joined_at        timestamptz default now()
);
create index if not exists players_session on public.players (session);

create table if not exists public.events (
  id         bigint generated always as identity primary key,
  session    text not null,
  player_id  uuid,
  name       text not null,
  kind       text not null,                -- join | solve | improve | finish
  level      int,
  points     int,
  created_at timestamptz default now()
);
create index if not exists events_session on public.events (session, created_at desc);

-- 2) Elevernes adgang (anon-nøglen) ----------------------------------------
alter table public.players enable row level security;
alter table public.events  enable row level security;

drop policy if exists "alle kan se spillere"    on public.players;
drop policy if exists "elever kan oprette sig"  on public.players;
drop policy if exists "elever kan opdatere"     on public.players;
drop policy if exists "alle kan se events"      on public.events;
drop policy if exists "elever kan sende events" on public.events;

create policy "alle kan se spillere"   on public.players for select to anon using (true);
create policy "elever kan oprette sig" on public.players for insert to anon
  with check (char_length(name) between 2 and 20 and score between 0 and 1000);
create policy "elever kan opdatere"    on public.players for update to anon
  using (true) with check (char_length(name) between 2 and 20 and score between 0 and 1000);
create policy "alle kan se events"      on public.events for select to anon using (true);
create policy "elever kan sende events" on public.events for insert to anon
  with check (kind in ('join','solve','improve','finish') and coalesce(points,0) between 0 and 100);

-- 3) Underviser-PIN (ligger kun i databasen, ikke i koden) -----------------
create table if not exists public.admin_secret (pin text not null);
alter table public.admin_secret enable row level security;   -- ingen policies = ingen kan læse den udefra
delete from public.admin_secret;
insert into public.admin_secret (pin) values ('SKIFT-MIG');

create or replace function public.check_pin(p text) returns boolean
  language sql security definer stable set search_path = public as $$
  select exists (select 1 from public.admin_secret where pin = p);
$$;
create or replace function public.is_admin() returns boolean
  language sql security definer stable set search_path = public as $$
  select exists (select 1 from public.admin_secret
    where pin = coalesce(current_setting('request.headers', true)::json->>'x-admin-pin', ''));
$$;
grant execute on function public.check_pin(text) to anon;
grant execute on function public.is_admin() to anon;

drop policy if exists "underviser sletter spillere" on public.players;
drop policy if exists "underviser sletter events"   on public.events;
create policy "underviser sletter spillere" on public.players for delete to anon using (public.is_admin());
create policy "underviser sletter events"   on public.events  for delete to anon using (public.is_admin());

-- 4) Pause-knappen ---------------------------------------------------------
create table if not exists public.rooms (
  session    text primary key,
  paused     boolean not null default false,
  updated_at timestamptz default now()
);
alter table public.rooms enable row level security;
drop policy if exists "alle kan se pause"          on public.rooms;
drop policy if exists "underviser opretter pause"  on public.rooms;
drop policy if exists "underviser ændrer pause"    on public.rooms;
create policy "alle kan se pause"         on public.rooms for select to anon using (true);
create policy "underviser opretter pause" on public.rooms for insert to anon with check (public.is_admin());
create policy "underviser ændrer pause"   on public.rooms for update to anon using (public.is_admin()) with check (public.is_admin());
insert into public.rooms (session, paused) values ('AAU', false) on conflict (session) do nothing;

-- 5) Live-opdateringer til scoreboard, panel og pause ----------------------
do $$ begin alter publication supabase_realtime add table public.players;
exception when duplicate_object then null; end $$;
do $$ begin alter publication supabase_realtime add table public.events;
exception when duplicate_object then null; end $$;
do $$ begin alter publication supabase_realtime add table public.rooms;
exception when duplicate_object then null; end $$;
