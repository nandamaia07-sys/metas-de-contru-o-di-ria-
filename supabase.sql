-- Rode este script UMA vez no Supabase: SQL Editor > New query > Run

create table if not exists public.meu_futuro_metas (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  id      text not null,
  u       bigint not null,
  deleted boolean not null default false,
  dados   jsonb,
  primary key (user_id, id)
);

alter table public.meu_futuro_metas enable row level security;

create policy "dono le"      on public.meu_futuro_metas for select using (auth.uid() = user_id);
create policy "dono insere"  on public.meu_futuro_metas for insert with check (auth.uid() = user_id);
create policy "dono altera"  on public.meu_futuro_metas for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "dono apaga"   on public.meu_futuro_metas for delete using (auth.uid() = user_id);
