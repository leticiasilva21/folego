-- Rode uma vez no SQL Editor do seu projeto Supabase
create table if not exists public.docs (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  path text not null,
  data jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, path)
);
alter table public.docs enable row level security;
create policy "dono le" on public.docs for select to authenticated using (auth.uid() = user_id);
create policy "dono insere" on public.docs for insert to authenticated with check (auth.uid() = user_id);
create policy "dono altera" on public.docs for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "dono apaga" on public.docs for delete to authenticated using (auth.uid() = user_id);
