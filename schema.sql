-- Sri Rudra Clinic — admin/staff portal schema
-- D1 (SQLite dialect). Run: wrangler d1 execute sri-rudra --file=schema.sql --remote

CREATE TABLE IF NOT EXISTS clinics (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  code       TEXT NOT NULL UNIQUE,      -- short slug (e.g. 'mvp', 'gajuwaka')
  name       TEXT NOT NULL,
  address    TEXT,
  phone      TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS users (
  id            INTEGER PRIMARY KEY AUTOINCREMENT,
  clinic_id     INTEGER REFERENCES clinics(id) ON DELETE SET NULL,
  username      TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,           -- bcrypt
  full_name     TEXT NOT NULL,
  phone         TEXT,                    -- E.164, used for OTP delivery
  role          TEXT NOT NULL DEFAULT 'staff', -- owner | admin | audiologist | slp | frontdesk | staff | readonly
  is_active     INTEGER NOT NULL DEFAULT 1,
  created_at    TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at    TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS idx_users_clinic ON users(clinic_id);

CREATE TABLE IF NOT EXISTS sessions (
  id         TEXT PRIMARY KEY,          -- opaque id (also the sub-claim in JWT)
  user_id    INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  ip         TEXT,
  ua         TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  expires_at TEXT NOT NULL,
  revoked_at TEXT
);
CREATE INDEX IF NOT EXISTS idx_sessions_user ON sessions(user_id);

-- OTPs — hashed with SHA-256 (not stored plaintext). One live OTP per user.
CREATE TABLE IF NOT EXISTS otps (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id    INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  purpose    TEXT NOT NULL,             -- 'password_reset' | 'phone_verify'
  code_hash  TEXT NOT NULL,
  attempts   INTEGER NOT NULL DEFAULT 0,
  expires_at TEXT NOT NULL,
  consumed_at TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS idx_otps_user ON otps(user_id, purpose);

-- Auth attempts — rate-limit brute-force
CREATE TABLE IF NOT EXISTS auth_attempts (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  username   TEXT,
  ip         TEXT,
  success    INTEGER NOT NULL DEFAULT 0,
  reason     TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS idx_attempts_recent ON auth_attempts(username, created_at);
CREATE INDEX IF NOT EXISTS idx_attempts_ip ON auth_attempts(ip, created_at);

-- Audit trail
CREATE TABLE IF NOT EXISTS audit_log (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id    INTEGER REFERENCES users(id) ON DELETE SET NULL,
  clinic_id  INTEGER REFERENCES clinics(id) ON DELETE SET NULL,
  action     TEXT NOT NULL,             -- 'login' | 'payment.create' | 'password.change' | ...
  entity     TEXT,                       -- 'payment' | 'user' | ...
  entity_id  TEXT,
  meta_json  TEXT,
  ip         TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS idx_audit_user ON audit_log(user_id, created_at);

-- Patients (minimal shape for now — enough for payments & reports to reference)
CREATE TABLE IF NOT EXISTS patients (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  clinic_id  INTEGER NOT NULL REFERENCES clinics(id) ON DELETE CASCADE,
  mrn        TEXT,                       -- medical record number, clinic-local
  full_name  TEXT NOT NULL,
  phone      TEXT,
  dob        TEXT,
  sex        TEXT,
  notes      TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS idx_patients_clinic ON patients(clinic_id);
CREATE INDEX IF NOT EXISTS idx_patients_phone ON patients(phone);

-- Appointments
CREATE TABLE IF NOT EXISTS appointments (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  clinic_id  INTEGER NOT NULL REFERENCES clinics(id) ON DELETE CASCADE,
  patient_id INTEGER REFERENCES patients(id) ON DELETE SET NULL,
  patient_name TEXT NOT NULL,            -- denormalized for walk-ins
  patient_phone TEXT,
  service    TEXT NOT NULL,              -- audio | aid | ped | adult | other
  scheduled_for TEXT NOT NULL,            -- ISO datetime
  duration_min INTEGER NOT NULL DEFAULT 45,
  status     TEXT NOT NULL DEFAULT 'scheduled', -- scheduled | done | no_show | cancelled
  notes      TEXT,
  created_by INTEGER REFERENCES users(id) ON DELETE SET NULL,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS idx_appts_clinic_date ON appointments(clinic_id, scheduled_for);

-- Payments — cash / upi / card + advances + refunds
CREATE TABLE IF NOT EXISTS payments (
  id            INTEGER PRIMARY KEY AUTOINCREMENT,
  clinic_id     INTEGER NOT NULL REFERENCES clinics(id) ON DELETE CASCADE,
  patient_id    INTEGER REFERENCES patients(id) ON DELETE SET NULL,
  patient_name  TEXT NOT NULL,
  patient_phone TEXT,
  amount_paise  INTEGER NOT NULL,        -- store in paise (₹1 = 100)
  method        TEXT NOT NULL,           -- cash | upi | card
  kind          TEXT NOT NULL DEFAULT 'payment', -- payment | advance | refund | ha_token
  ha_token      TEXT,                     -- hearing-aid token reference
  reference     TEXT,                     -- UPI txn / card slip / receipt
  notes         TEXT,
  paid_at       TEXT NOT NULL DEFAULT (datetime('now')),
  created_by    INTEGER REFERENCES users(id) ON DELETE SET NULL,
  created_at    TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS idx_payments_clinic_date ON payments(clinic_id, paid_at);

-- Expenses (per-clinic)
CREATE TABLE IF NOT EXISTS expenses (
  id           INTEGER PRIMARY KEY AUTOINCREMENT,
  clinic_id    INTEGER NOT NULL REFERENCES clinics(id) ON DELETE CASCADE,
  category     TEXT NOT NULL,            -- rent | salary | consumables | utilities | equipment | other
  amount_paise INTEGER NOT NULL,
  method       TEXT,                     -- cash | upi | card | bank
  vendor       TEXT,
  reference    TEXT,
  notes        TEXT,
  spent_on     TEXT NOT NULL DEFAULT (date('now')),
  created_by   INTEGER REFERENCES users(id) ON DELETE SET NULL,
  created_at   TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS idx_expenses_clinic_date ON expenses(clinic_id, spent_on);

-- Staff attendance
CREATE TABLE IF NOT EXISTS attendance (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  clinic_id  INTEGER NOT NULL REFERENCES clinics(id) ON DELETE CASCADE,
  user_id    INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  day        TEXT NOT NULL,              -- YYYY-MM-DD
  check_in   TEXT,                       -- ISO datetime
  check_out  TEXT,
  status     TEXT NOT NULL DEFAULT 'present', -- present | absent | half_day | leave
  notes      TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  UNIQUE (user_id, day)
);
CREATE INDEX IF NOT EXISTS idx_attendance_clinic_day ON attendance(clinic_id, day);

-- Test reports — audiogram + impedance
CREATE TABLE IF NOT EXISTS test_reports (
  id           INTEGER PRIMARY KEY AUTOINCREMENT,
  clinic_id    INTEGER NOT NULL REFERENCES clinics(id) ON DELETE CASCADE,
  patient_id   INTEGER REFERENCES patients(id) ON DELETE SET NULL,
  patient_name TEXT NOT NULL,
  kind         TEXT NOT NULL,            -- audiogram | impedance | combined
  data_json    TEXT NOT NULL,            -- see JSON shape in README
  clinician    TEXT,
  performed_at TEXT NOT NULL DEFAULT (datetime('now')),
  created_by   INTEGER REFERENCES users(id) ON DELETE SET NULL,
  created_at   TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS idx_reports_clinic ON test_reports(clinic_id, performed_at);
CREATE INDEX IF NOT EXISTS idx_reports_patient ON test_reports(patient_id);
