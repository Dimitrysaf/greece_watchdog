-- ═══════════════════════════════════════════════════════════════
-- Παρατηρητήριο Ελλάδας — Supabase Schema v2
-- ΜΟΝΟ ΔΟΜΗ — χωρίς δεδομένα
-- ═══════════════════════════════════════════════════════════════


-- ───────────────────────────────────────────────────────────────
-- EXTENSIONS
-- ───────────────────────────────────────────────────────────────

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";


-- ═══════════════════════════════════════════════════════════════
-- LOOKUP TABLES
-- ═══════════════════════════════════════════════════════════════


CREATE TABLE IF NOT EXISTS categories (
  id          SERIAL PRIMARY KEY,
  code        TEXT        NOT NULL UNIQUE,
  label       TEXT        NOT NULL,
  title       TEXT        NOT NULL,
  description TEXT,
  color_hex   TEXT,
  sort_order  INTEGER     NOT NULL DEFAULT 0,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


CREATE TABLE IF NOT EXISTS documentation_orders (
  id          SERIAL PRIMARY KEY,
  code        TEXT        NOT NULL UNIQUE,
  label       TEXT        NOT NULL,
  title       TEXT        NOT NULL,
  description TEXT,
  sort_order  INTEGER     NOT NULL DEFAULT 0,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


CREATE TABLE IF NOT EXISTS incident_statuses (
  id          SERIAL PRIMARY KEY,
  code        TEXT        NOT NULL UNIQUE,
  label       TEXT        NOT NULL,
  description TEXT,
  color_hex   TEXT,
  sort_order  INTEGER     NOT NULL DEFAULT 0,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


CREATE TABLE IF NOT EXISTS incident_types (
  id          SERIAL PRIMARY KEY,
  code        TEXT        NOT NULL UNIQUE,
  label       TEXT        NOT NULL,
  description TEXT,
  sort_order  INTEGER     NOT NULL DEFAULT 0,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


CREATE TABLE IF NOT EXISTS sections (
  id          SERIAL PRIMARY KEY,
  key         TEXT        NOT NULL UNIQUE,
  label       TEXT        NOT NULL,
  description TEXT,
  icon        TEXT,
  sort_order  INTEGER     NOT NULL DEFAULT 0,
  is_active   BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


CREATE TABLE IF NOT EXISTS subsections (
  id         SERIAL PRIMARY KEY,
  section_id INTEGER     NOT NULL REFERENCES sections(id) ON DELETE CASCADE,
  key        TEXT        NOT NULL,
  label      TEXT        NOT NULL,
  sort_order INTEGER     NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (section_id, key)
);


-- ═══════════════════════════════════════════════════════════════
-- CORE TABLES
-- ═══════════════════════════════════════════════════════════════


CREATE TABLE IF NOT EXISTS profiles (
  id           UUID        PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT,
  avatar_url   TEXT,
  bio          TEXT,
  role         TEXT        NOT NULL DEFAULT 'viewer'
                           CHECK (role IN ('viewer', 'contributor', 'editor', 'admin')),
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


CREATE TABLE IF NOT EXISTS incidents (
  id                     TEXT        PRIMARY KEY,
  title                  TEXT        NOT NULL,
  slug                   TEXT        UNIQUE,
  date_label             TEXT        NOT NULL,
  date_from              DATE,
  date_to                DATE,

  section_id             INTEGER     NOT NULL REFERENCES sections(id),
  subsection_id          INTEGER              REFERENCES subsections(id),
  category_id            INTEGER     NOT NULL REFERENCES categories(id),
  type_id                INTEGER              REFERENCES incident_types(id),
  documentation_order_id INTEGER     NOT NULL REFERENCES documentation_orders(id),
  status_id              INTEGER     NOT NULL REFERENCES incident_statuses(id),

  description            TEXT        NOT NULL,
  extended_description   TEXT,
  score                  INTEGER     NOT NULL CHECK (score BETWEEN 1 AND 10),

  is_published           BOOLEAN     NOT NULL DEFAULT TRUE,
  created_by             UUID                 REFERENCES profiles(id),
  created_at             TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at             TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_incidents_section    ON incidents(section_id);
CREATE INDEX IF NOT EXISTS idx_incidents_status     ON incidents(status_id);
CREATE INDEX IF NOT EXISTS idx_incidents_category   ON incidents(category_id);
CREATE INDEX IF NOT EXISTS idx_incidents_score      ON incidents(score DESC);
CREATE INDEX IF NOT EXISTS idx_incidents_date_from  ON incidents(date_from DESC);
CREATE INDEX IF NOT EXISTS idx_incidents_published  ON incidents(is_published);


CREATE TABLE IF NOT EXISTS incident_references (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id  TEXT        NOT NULL REFERENCES incidents(id) ON DELETE CASCADE,
  url          TEXT,
  label        TEXT,
  source_type  TEXT        CHECK (source_type IN ('official', 'news', 'report', 'video', 'social', 'other')),
  published_at DATE,
  sort_order   INTEGER     NOT NULL DEFAULT 0,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_refs_incident ON incident_references(incident_id);


CREATE TABLE IF NOT EXISTS tags (
  id         SERIAL PRIMARY KEY,
  slug       TEXT        NOT NULL UNIQUE,
  label      TEXT        NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


CREATE TABLE IF NOT EXISTS incident_tags (
  incident_id TEXT    NOT NULL REFERENCES incidents(id) ON DELETE CASCADE,
  tag_id      INTEGER NOT NULL REFERENCES tags(id)      ON DELETE CASCADE,
  PRIMARY KEY (incident_id, tag_id)
);


CREATE TABLE IF NOT EXISTS incident_relations (
  incident_id   TEXT NOT NULL REFERENCES incidents(id) ON DELETE CASCADE,
  related_id    TEXT NOT NULL REFERENCES incidents(id) ON DELETE CASCADE,
  relation_type TEXT CHECK (relation_type IN ('related', 'caused_by', 'follow_up', 'contradicts')),
  PRIMARY KEY (incident_id, related_id),
  CHECK (incident_id <> related_id)
);


CREATE TABLE IF NOT EXISTS comments (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id TEXT        NOT NULL REFERENCES incidents(id) ON DELETE CASCADE,
  user_id     UUID        NOT NULL REFERENCES profiles(id)  ON DELETE CASCADE,
  parent_id   UUID                 REFERENCES comments(id)  ON DELETE CASCADE,
  content     TEXT        NOT NULL,
  is_visible  BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_comments_incident ON comments(incident_id);
CREATE INDEX IF NOT EXISTS idx_comments_parent   ON comments(parent_id);


CREATE TABLE IF NOT EXISTS edit_proposals (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id      TEXT        NOT NULL REFERENCES incidents(id) ON DELETE CASCADE,
  user_id          UUID        NOT NULL REFERENCES profiles(id)  ON DELETE CASCADE,
  proposed_changes JSONB       NOT NULL,
  reason           TEXT        NOT NULL,
  status           TEXT        NOT NULL DEFAULT 'pending'
                               CHECK (status IN ('pending', 'approved', 'rejected', 'withdrawn')),
  reviewed_by      UUID                 REFERENCES profiles(id),
  reviewed_at      TIMESTAMPTZ,
  review_note      TEXT,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_proposals_incident ON edit_proposals(incident_id);
CREATE INDEX IF NOT EXISTS idx_proposals_status   ON edit_proposals(status);


CREATE TABLE IF NOT EXISTS audit_log (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  table_name TEXT        NOT NULL,
  record_id  TEXT        NOT NULL,
  action     TEXT        NOT NULL CHECK (action IN ('INSERT', 'UPDATE', 'DELETE')),
  old_values JSONB,
  new_values JSONB,
  user_id    UUID                 REFERENCES profiles(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_audit_table   ON audit_log(table_name, record_id);
CREATE INDEX IF NOT EXISTS idx_audit_user    ON audit_log(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_created ON audit_log(created_at DESC);


-- ═══════════════════════════════════════════════════════════════
-- ROW LEVEL SECURITY
-- ═══════════════════════════════════════════════════════════════

ALTER TABLE categories           ENABLE ROW LEVEL SECURITY;
ALTER TABLE documentation_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE incident_statuses    ENABLE ROW LEVEL SECURITY;
ALTER TABLE incident_types       ENABLE ROW LEVEL SECURITY;
ALTER TABLE sections             ENABLE ROW LEVEL SECURITY;
ALTER TABLE subsections          ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles             ENABLE ROW LEVEL SECURITY;
ALTER TABLE incidents            ENABLE ROW LEVEL SECURITY;
ALTER TABLE incident_references  ENABLE ROW LEVEL SECURITY;
ALTER TABLE tags                 ENABLE ROW LEVEL SECURITY;
ALTER TABLE incident_tags        ENABLE ROW LEVEL SECURITY;
ALTER TABLE incident_relations   ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments             ENABLE ROW LEVEL SECURITY;
ALTER TABLE edit_proposals       ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_log            ENABLE ROW LEVEL SECURITY;

-- Lookup tables: όλοι διαβάζουν, μόνο admin γράφει
CREATE POLICY "categories_public_read"     ON categories           FOR SELECT USING (true);
CREATE POLICY "doc_orders_public_read"     ON documentation_orders FOR SELECT USING (true);
CREATE POLICY "statuses_public_read"       ON incident_statuses    FOR SELECT USING (true);
CREATE POLICY "types_public_read"          ON incident_types       FOR SELECT USING (true);
CREATE POLICY "sections_public_read"       ON sections             FOR SELECT USING (true);
CREATE POLICY "subsections_public_read"    ON subsections          FOR SELECT USING (true);
CREATE POLICY "tags_public_read"           ON tags                 FOR SELECT USING (true);
CREATE POLICY "incident_tags_public_read"  ON incident_tags        FOR SELECT USING (true);
CREATE POLICY "relations_public_read"      ON incident_relations   FOR SELECT USING (true);

CREATE POLICY "categories_admin_write"     ON categories           FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));
CREATE POLICY "doc_orders_admin_write"     ON documentation_orders FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));
CREATE POLICY "statuses_admin_write"       ON incident_statuses    FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));
CREATE POLICY "types_admin_write"          ON incident_types       FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));
CREATE POLICY "sections_admin_write"       ON sections             FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));
CREATE POLICY "subsections_admin_write"    ON subsections          FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- Profiles
CREATE POLICY "profiles_public_read"  ON profiles FOR SELECT USING (true);
CREATE POLICY "profiles_own_update"   ON profiles FOR UPDATE USING (auth.uid() = id);

-- Incidents
CREATE POLICY "incidents_public_read"   ON incidents FOR SELECT USING (is_published = TRUE);
CREATE POLICY "incidents_editor_write"  ON incidents FOR ALL    USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('editor', 'admin')));

-- References
CREATE POLICY "refs_public_read"   ON incident_references FOR SELECT USING (true);
CREATE POLICY "refs_editor_write"  ON incident_references FOR ALL    USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('editor', 'admin')));

-- Comments
CREATE POLICY "comments_public_read"  ON comments FOR SELECT USING (is_visible = TRUE);
CREATE POLICY "comments_auth_insert"  ON comments FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "comments_own_update"   ON comments FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "comments_own_delete"   ON comments FOR DELETE USING (auth.uid() = user_id);
CREATE POLICY "comments_admin_manage" ON comments FOR ALL    USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('editor', 'admin')));

-- Edit proposals
CREATE POLICY "proposals_public_read"   ON edit_proposals FOR SELECT USING (true);
CREATE POLICY "proposals_auth_insert"   ON edit_proposals FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "proposals_own_withdraw"  ON edit_proposals FOR UPDATE USING (auth.uid() = user_id AND status = 'pending');
CREATE POLICY "proposals_admin_review"  ON edit_proposals FOR UPDATE USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('editor', 'admin')));

-- Audit log
CREATE POLICY "audit_admin_read"  ON audit_log FOR SELECT USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));


-- ═══════════════════════════════════════════════════════════════
-- FUNCTIONS & TRIGGERS
-- ═══════════════════════════════════════════════════════════════

CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER incidents_updated_at  BEFORE UPDATE ON incidents  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER profiles_updated_at   BEFORE UPDATE ON profiles   FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER comments_updated_at   BEFORE UPDATE ON comments   FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER sections_updated_at   BEFORE UPDATE ON sections   FOR EACH ROW EXECUTE FUNCTION set_updated_at();


CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO profiles (id, display_name)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1))
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();


CREATE OR REPLACE FUNCTION audit_incidents()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_log (table_name, record_id, action, old_values, new_values, user_id)
  VALUES (
    'incidents',
    COALESCE(NEW.id, OLD.id),
    TG_OP,
    CASE WHEN TG_OP = 'INSERT' THEN NULL ELSE row_to_json(OLD)::JSONB END,
    CASE WHEN TG_OP = 'DELETE' THEN NULL ELSE row_to_json(NEW)::JSONB END,
    auth.uid()
  );
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER incidents_audit
  AFTER INSERT OR UPDATE OR DELETE ON incidents
  FOR EACH ROW EXECUTE FUNCTION audit_incidents();


-- ═══════════════════════════════════════════════════════════════
-- VIEWS
-- ═══════════════════════════════════════════════════════════════

CREATE OR REPLACE VIEW incidents_full AS
SELECT
  i.id,
  i.title,
  i.slug,
  i.date_label,
  i.date_from,
  i.date_to,
  i.description,
  i.extended_description,
  i.score,
  i.is_published,
  i.created_at,
  i.updated_at,

  s.key        AS section_key,
  s.label      AS section_label,
  s.icon       AS section_icon,

  sub.key      AS subsection_key,
  sub.label    AS subsection_label,

  c.code       AS category_code,
  c.label      AS category_label,
  c.title      AS category_title,
  c.color_hex  AS category_color,

  t.code       AS type_code,
  t.label      AS type_label,

  d.code       AS doc_order_code,
  d.label      AS doc_order_label,
  d.title      AS doc_order_title,

  st.code      AS status_code,
  st.label     AS status_label,
  st.color_hex AS status_color

FROM incidents i
LEFT JOIN sections             s   ON i.section_id             = s.id
LEFT JOIN subsections          sub ON i.subsection_id          = sub.id
LEFT JOIN categories           c   ON i.category_id            = c.id
LEFT JOIN incident_types       t   ON i.type_id                = t.id
LEFT JOIN documentation_orders d   ON i.documentation_order_id = d.id
LEFT JOIN incident_statuses    st  ON i.status_id              = st.id
WHERE i.is_published = TRUE;


CREATE OR REPLACE VIEW incident_references_agg AS
SELECT
  incident_id,
  jsonb_agg(
    jsonb_build_object(
      'id',           id,
      'url',          url,
      'label',        label,
      'source_type',  source_type,
      'published_at', published_at
    ) ORDER BY sort_order
  ) AS references
FROM incident_references
GROUP BY incident_id;