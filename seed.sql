-- Sri Rudra Clinic — first-run seed
-- Creates the MVP clinic + Prasad's owner user.
--
--   Default login:
--     username: prasad
--     password: sriRudra@2026
--
-- CHANGE THIS PASSWORD ON FIRST LOGIN (Settings → Change password).
-- If you want a different default, regenerate the hash below:
--     node tools/hash-password.mjs "YourNewPassword"
-- and replace the value in the INSERT statement.

INSERT OR IGNORE INTO clinics (id, code, name, address, phone) VALUES
  (1, 'mvp', 'Sri Rudra · MVP Double Road',
   'Bhavana Heights, 2nd Floor, MVP Double Road, Visakhapatnam - 530017',
   '+918197241389');

INSERT OR IGNORE INTO users (id, clinic_id, username, password_hash, full_name, phone, role) VALUES
  (1, 1, 'prasad',
   '$2b$10$im0lJ6gog4Lu3nNRQ65/COeOFykqk5KO0sXN47TbVuDYRGnvzVQwy',
   'Prasad', '+917032054275', 'owner');

-- Extra staff account (optional) — remove or change as you like.
-- Default password: sriRudra@2026 (same hash as above).
INSERT OR IGNORE INTO users (id, clinic_id, username, password_hash, full_name, phone, role) VALUES
  (2, 1, 'staff',
   '$2b$10$im0lJ6gog4Lu3nNRQ65/COeOFykqk5KO0sXN47TbVuDYRGnvzVQwy',
   'Front Desk', NULL, 'staff');
