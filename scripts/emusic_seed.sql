-- Seed data for emusic database (MariaDB 11.x)
-- Idempotent inserts using ON DUPLICATE KEY UPDATE, explicit IDs for FK consistency

START TRANSACTION;

-- Ensure we are using the correct database
USE `emusic`;

-- 1) Base reference data
-- jours
INSERT INTO `jour` (`id`, `libelle`) VALUES
  (1, 'Lundi'),
  (2, 'Mardi'),
  (3, 'Mercredi'),
  (4, 'Jeudi'),
  (5, 'Vendredi'),
  (6, 'Samedi'),
  (7, 'Dimanche')
ON DUPLICATE KEY UPDATE `id` = `id`;

-- types (disciplines)
INSERT INTO `type` (`id`, `nom`) VALUES
  (1, 'Piano'),
  (2, 'Guitare'),
  (3, 'Violon'),
  (4, 'Batterie'),
  (5, 'Solfège')
ON DUPLICATE KEY UPDATE `id` = `id`;

-- tranches (quotients familiaux)
INSERT INTO `tranche` (`id`, `libelle`, `quotient_mini`) VALUES
  (1, 'A', 0),
  (2, 'B', 500),
  (3, 'C', 800),
  (4, 'D', 1000)
ON DUPLICATE KEY UPDATE `id` = `id`;

-- 2) Mappings tranche <-> type
INSERT INTO `tranche_type` (`tranche_id`, `type_id`) VALUES
  (1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
  (2, 1), (2, 2), (2, 3), (2, 4), (2, 5),
  (3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
  (4, 1), (4, 2), (4, 3), (4, 4), (4, 5)
ON DUPLICATE KEY UPDATE `tranche_id` = `tranche_id`;

-- 3) Cours (depend on type, jour)
INSERT INTO `cours` (`id`, `libelle`, `age_mini`, `heure_debut`, `heure_fin`, `type_id`, `jour_id`) VALUES
  (1, 'Piano Débutant 6-8 ans', 6, '17:00:00', '18:00:00', 1, 3),  -- Mercredi
  (2, 'Guitare Ados',          12, '18:00:00', '19:30:00', 2, 5), -- Vendredi
  (3, 'Solfège Tous',           8, '10:00:00', '11:00:00', 5, 6),  -- Samedi
  (4, 'Violon Intermédiaire',  10, '17:30:00', '18:30:00', 3, 2)   -- Mardi
ON DUPLICATE KEY UPDATE `id` = `id`;

-- 4) Responsables (depend on tranche)
INSERT INTO `responsable` (
  `id`, `nom`, `prenom`, `num_rue`, `rue`, `copos`, `ville`, `tel`, `mail`, `tranche_id`
) VALUES
  (1, 'Martin',  'Sophie', 12, 'Rue des Lilas',    69001, 'Lyon',      612345678, 'sophie.martin@example.com', 2),
  (2, 'Durand',  'Paul',   5,  'Avenue de Paris',  75012, 'Paris',     623456789, 'paul.durand@example.com',   1),
  (3, 'Bernard', 'Claire', 24, 'Bd de la République', 33000, 'Bordeaux', 634567890, 'claire.bernard@example.com', 3)
ON DUPLICATE KEY UPDATE `id` = `id`;

-- 5) Elèves (depend on tranche)
INSERT INTO `eleve` (
  `id`, `nom`, `prenom`, `num_rue`, `rue`, `copos`, `ville`, `tel`, `mail`, `tranche_id`
) VALUES
  (1, 'Martin',  'Emma',  12, 'Rue des Lilas',      69001, 'Lyon',     698765432, 'emma.martin@example.com',  2),
  (2, 'Durand',  'Lucas',  5, 'Avenue de Paris',    75012, 'Paris',    677889900, 'lucas.durand@example.com', 1),
  (3, 'Bernard', 'Léa',   24, 'Bd de la République',33000, 'Bordeaux', 655443322, 'lea.bernard@example.com',  3)
ON DUPLICATE KEY UPDATE `id` = `id`;

-- 6) Liens élève-responsable
INSERT INTO `eleve_responsable` (`eleve_id`, `responsable_id`) VALUES
  (1, 1),
  (2, 2),
  (3, 3)
ON DUPLICATE KEY UPDATE `eleve_id` = `eleve_id`;

-- 7) Inscriptions (depend on eleve, cours)
-- Note: column name is date_inscrption in schema
INSERT INTO `inscription` (`id`, `date_inscrption`, `eleve_id`, `cours_id`) VALUES
  (1, '2025-09-10', 1, 1),
  (2, '2025-09-12', 2, 2),
  (3, '2025-09-13', 3, 3)
ON DUPLICATE KEY UPDATE `id` = `id`;

-- 8) Paiements (depend on inscription)
INSERT INTO `paiement` (`id`, `montant`, `date_paiement`, `inscription_id`) VALUES
  (1, 120.00, '2025-09-15', 1),
  (2, 150.50, '2025-09-20', 2),
  (3,  90.00, '2025-09-21', 3)
ON DUPLICATE KEY UPDATE `id` = `id`;

-- 9) Doctrine migration versions (as provided)
INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
  ('DoctrineMigrations\\Version20251013122523', '2025-10-13 12:39:04', 203),
  ('DoctrineMigrations\\Version20251013123845', '2025-10-13 12:57:48', 366),
  ('DoctrineMigrations\\Version20251013125428', '2025-10-13 12:57:48', 184),
  ('DoctrineMigrations\\Version20251013125914', '2025-10-13 12:59:31', 1057),
  ('DoctrineMigrations\\Version20251013132915', '2025-10-13 13:29:27', 153),
  ('DoctrineMigrations\\Version20251013133132', '2025-10-13 13:31:41', 1072),
  ('DoctrineMigrations\\Version20251013133335', '2025-10-13 13:33:42', 1069),
  ('DoctrineMigrations\\Version20251013133457', '2025-10-13 13:35:55', 152),
  ('DoctrineMigrations\\Version20251013133732', '2025-10-13 13:37:40', 1031),
  ('DoctrineMigrations\\Version20251013134412', '2025-10-13 13:44:17', 185),
  ('DoctrineMigrations\\Version20251013134521', '2025-10-13 13:45:26', 1073),
  ('DoctrineMigrations\\Version20251013134823', '2025-10-13 13:48:28', 1205),
  ('DoctrineMigrations\\Version20251013135002', '2025-10-13 13:50:09', 160),
  ('DoctrineMigrations\\Version20251013135207', '2025-10-13 13:52:13', 1017),
  ('DoctrineMigrations\\Version20251013135721', '2025-10-13 13:57:24', 1076),
  ('DoctrineMigrations\\Version20251013135944', '2025-10-13 13:59:53', 153),
  ('DoctrineMigrations\\Version20251013140127', '2025-10-13 14:01:31', 1057)
ON DUPLICATE KEY UPDATE `version` = `version`;

COMMIT;