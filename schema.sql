-- 扫雷Plus 排行榜表
-- 在 Supabase SQL Editor 中全选执行

CREATE TABLE IF NOT EXISTS leaderboard (
  id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name       TEXT NOT NULL,
  difficulty TEXT NOT NULL,
  time_sec   INT NOT NULL,
  accuracy   INT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_leaderboard_rank ON leaderboard (time_sec ASC, difficulty DESC);

ALTER TABLE leaderboard ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_select" ON leaderboard FOR SELECT USING (true);
CREATE POLICY "allow_insert" ON leaderboard FOR INSERT WITH CHECK (true);

-- 昵称注册表，UNIQUE 约束防重复
CREATE TABLE IF NOT EXISTS nicknames (
  id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  uid  TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE nicknames ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_select_nn" ON nicknames FOR SELECT USING (true);
CREATE POLICY "allow_insert_nn" ON nicknames FOR INSERT WITH CHECK (true);
CREATE POLICY "allow_delete_own" ON nicknames FOR DELETE USING (true);
