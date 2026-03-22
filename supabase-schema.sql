-- ═══════════════════════════════════════════════════════════════
-- Παρατηρητήριο Ελλάδας — Supabase Schema
-- Εκτέλεσε στο Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════════

-- Incidents table
CREATE TABLE IF NOT EXISTS incidents (
  id                  TEXT PRIMARY KEY,
  title               TEXT NOT NULL,
  date                TEXT NOT NULL,
  category            TEXT NOT NULL CHECK (category IN ('Α''', 'Β''', 'Γ''', 'Δ''', 'Ε''')),
  type                TEXT NOT NULL,
  description         TEXT NOT NULL,
  documentation_order TEXT NOT NULL CHECK (documentation_order IN ('Α''', 'Β''', 'Γ''')),
  references          TEXT[],
  score               INTEGER NOT NULL CHECK (score BETWEEN 1 AND 10),
  status              TEXT NOT NULL CHECK (status IN ('Ενεργό', 'Εκκρεμεί', 'Έκλεισε')),
  section             TEXT NOT NULL,
  subsection          TEXT,
  created_at          TIMESTAMPTZ DEFAULT NOW(),
  updated_at          TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE incidents ENABLE ROW LEVEL SECURITY;

-- Anyone can read incidents
CREATE POLICY "Public read incidents"
  ON incidents FOR SELECT
  USING (true);

-- Only authenticated admins can insert/update/delete
CREATE POLICY "Admin write incidents"
  ON incidents FOR ALL
  USING (auth.role() = 'authenticated');

-- ───────────────────────────────────────────────────────────────
-- Comments table
CREATE TABLE IF NOT EXISTS comments (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id TEXT NOT NULL REFERENCES incidents(id) ON DELETE CASCADE,
  user_id     UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  content     TEXT NOT NULL,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE comments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read comments"
  ON comments FOR SELECT
  USING (true);

CREATE POLICY "Authenticated insert comments"
  ON comments FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Own delete comments"
  ON comments FOR DELETE
  USING (auth.uid() = user_id);

-- ───────────────────────────────────────────────────────────────
-- Edit proposals table
CREATE TABLE IF NOT EXISTS edit_proposals (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id      TEXT NOT NULL REFERENCES incidents(id) ON DELETE CASCADE,
  user_id          UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  proposed_changes JSONB NOT NULL,
  reason           TEXT NOT NULL,
  status           TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  created_at       TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE edit_proposals ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read proposals"
  ON edit_proposals FOR SELECT
  USING (true);

CREATE POLICY "Authenticated insert proposals"
  ON edit_proposals FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- ───────────────────────────────────────────────────────────────
-- Profiles table (extend auth.users)
CREATE TABLE IF NOT EXISTS profiles (
  id           UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT,
  avatar_url   TEXT,
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read profiles"
  ON profiles FOR SELECT
  USING (true);

CREATE POLICY "Own update profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = id);

-- Auto-create profile on signup
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO profiles (id, display_name)
  VALUES (NEW.id, split_part(NEW.email, '@', 1));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- ───────────────────────────────────────────────────────────────
-- Indexes
CREATE INDEX IF NOT EXISTS idx_incidents_section ON incidents(section);
CREATE INDEX IF NOT EXISTS idx_incidents_status  ON incidents(status);
CREATE INDEX IF NOT EXISTS idx_incidents_score   ON incidents(score DESC);
CREATE INDEX IF NOT EXISTS idx_comments_incident ON comments(incident_id);
