-- ============================================================
-- BASE EQUIDA - SCRIPT COMPLET
-- Structure + données (60 chevaux, 24 clients, 13 ventes...)
-- Généré pour le BTS SIO - Épreuve E6 - Maxime LEU
-- ============================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET NAMES utf8mb4;
SET time_zone = "+00:00";
SET FOREIGN_KEY_CHECKS = 0;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `equida`
--

-- --------------------------------------------------------
-- SUPPRESSION DES TABLES (ordre inverse des FK)
-- --------------------------------------------------------
DROP TABLE IF EXISTS `piecejointe`;
DROP TABLE IF EXISTS `courriel`;
DROP TABLE IF EXISTS `enchere`;
DROP TABLE IF EXISTS `lot`;
DROP TABLE IF EXISTS `cheval_course`;
DROP TABLE IF EXISTS `cheval_parent`;
DROP TABLE IF EXISTS `acheteur`;
DROP TABLE IF EXISTS `vendeur`;
DROP TABLE IF EXISTS `cheval`;
DROP TABLE IF EXISTS `vente`;
DROP TABLE IF EXISTS `categvente`;
DROP TABLE IF EXISTS `lieu`;
DROP TABLE IF EXISTS `course`;
DROP TABLE IF EXISTS `client`;
DROP TABLE IF EXISTS `pays`;
DROP TABLE IF EXISTS `race`;

-- --------------------------------------------------------
-- STRUCTURE DES TABLES
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `pays` (
  `code` char(3) NOT NULL,
  `nom` varchar(150) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `race` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(20) DEFAULT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `rue` varchar(255) DEFAULT NULL,
  `copos` varchar(20) DEFAULT NULL,
  `ville` varchar(150) DEFAULT NULL,
  `adresseMessagerie` varchar(150) DEFAULT NULL,
  `pays_code` char(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_client_pays` (`pays_code`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `acheteur` (
  `client_id` int(11) NOT NULL,
  `formation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `vendeur` (
  `client_id` int(11) NOT NULL,
  `ca` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `categvente` (
  `code` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `lieu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ville` varchar(150) DEFAULT NULL,
  `nbBoxes` int(11) DEFAULT NULL,
  `commentaires` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `cheval` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) NOT NULL,
  `sexe` varchar(10) DEFAULT NULL,
  `sire` varchar(10) DEFAULT NULL,
  `dateNaissance` date DEFAULT NULL,
  `race_id` int(11) DEFAULT NULL,
  `pere_id` int(11) DEFAULT NULL,
  `mere_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cheval_race` (`race_id`),
  KEY `fk_cheval_pere` (`pere_id`),
  KEY `fk_cheval_mere` (`mere_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) NOT NULL,
  `lieu` varchar(150) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `cheval_course` (
  `cheval_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`cheval_id`,`course_id`),
  KEY `fk_cheval_course_course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `cheval_parent` (
  `cheval_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  PRIMARY KEY (`cheval_id`,`parent_id`),
  KEY `fk_cheval_parent_parent` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `vente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) NOT NULL,
  `dateDebutVente` date DEFAULT NULL,
  `categvente_code` int(11) DEFAULT NULL,
  `lieu_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vente_categvente` (`categvente_code`),
  KEY `fk_vente_lieu` (`lieu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `lot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prixDepart` int(11) DEFAULT NULL,
  `vente_id` int(11) DEFAULT NULL,
  `cheval_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lot_vente` (`vente_id`),
  KEY `fk_lot_cheval` (`cheval_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `enchere` (
  `numero` int(11) NOT NULL AUTO_INCREMENT,
  `montant` decimal(12,2) NOT NULL,
  `acheteur_id` int(11) NOT NULL,
  `lot_id` int(11) NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `fk_enchere_acheteur` (`acheteur_id`),
  KEY `fk_enchere_lot` (`lot_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `courriel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `objet` varchar(255) DEFAULT NULL,
  `corps` text DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_courriel_client` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `piecejointe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chemin` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `courriel_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_piecejointe_courriel` (`courriel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- CONTRAINTES FK
-- --------------------------------------------------------
ALTER TABLE `acheteur`
  ADD CONSTRAINT `fk_acheteur_client` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`);

ALTER TABLE `vendeur`
  ADD CONSTRAINT `fk_vendeur_client` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`);

ALTER TABLE `client`
  ADD CONSTRAINT `fk_client_pays` FOREIGN KEY (`pays_code`) REFERENCES `pays` (`code`);

ALTER TABLE `cheval`
  ADD CONSTRAINT `fk_cheval_mere` FOREIGN KEY (`mere_id`) REFERENCES `cheval` (`id`),
  ADD CONSTRAINT `fk_cheval_pere` FOREIGN KEY (`pere_id`) REFERENCES `cheval` (`id`),
  ADD CONSTRAINT `fk_cheval_race` FOREIGN KEY (`race_id`) REFERENCES `race` (`id`);

ALTER TABLE `cheval_course`
  ADD CONSTRAINT `fk_cheval_course_cheval` FOREIGN KEY (`cheval_id`) REFERENCES `cheval` (`id`),
  ADD CONSTRAINT `fk_cheval_course_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

ALTER TABLE `cheval_parent`
  ADD CONSTRAINT `fk_cheval_parent_cheval` FOREIGN KEY (`cheval_id`) REFERENCES `cheval` (`id`),
  ADD CONSTRAINT `fk_cheval_parent_parent` FOREIGN KEY (`parent_id`) REFERENCES `cheval` (`id`);

ALTER TABLE `vente`
  ADD CONSTRAINT `fk_vente_categvente` FOREIGN KEY (`categvente_code`) REFERENCES `categvente` (`code`),
  ADD CONSTRAINT `fk_vente_lieu` FOREIGN KEY (`lieu_id`) REFERENCES `lieu` (`id`);

ALTER TABLE `lot`
  ADD CONSTRAINT `fk_lot_cheval` FOREIGN KEY (`cheval_id`) REFERENCES `cheval` (`id`),
  ADD CONSTRAINT `fk_lot_vente` FOREIGN KEY (`vente_id`) REFERENCES `vente` (`id`);

ALTER TABLE `enchere`
  ADD CONSTRAINT `fk_enchere_acheteur` FOREIGN KEY (`acheteur_id`) REFERENCES `acheteur` (`client_id`),
  ADD CONSTRAINT `fk_enchere_lot` FOREIGN KEY (`lot_id`) REFERENCES `lot` (`id`);

ALTER TABLE `courriel`
  ADD CONSTRAINT `fk_courriel_client` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`);

ALTER TABLE `piecejointe`
  ADD CONSTRAINT `fk_piecejointe_courriel` FOREIGN KEY (`courriel_id`) REFERENCES `courriel` (`id`);

-- --------------------------------------------------------
-- DONNÉES
-- --------------------------------------------------------

INSERT INTO `pays` (`code`, `nom`) VALUES
('FRA', 'France'),
('GBR', 'United Kingdom'),
('GER', 'Germany'),
('USA', 'United States'),
('IRE', 'Ireland'),
('ITA', 'Italy'),
('ESP', 'Spain'),
('AUS', 'Australia'),
('JPN', 'Japan'),
('UAE', 'United Arab Emirates'),
('ARG', 'Argentina'),
('BEL', 'Belgium'),
('NLD', 'Netherlands'),
('CHE', 'Switzerland'),
('CAN', 'Canada'),
('NZL', 'New Zealand');

INSERT INTO `race` (`id`, `libelle`) VALUES
(1,  'Pur-sang'),
(2,  'Frison'),
(3,  'Arabe'),
(4,  'Quarter Horse'),
(5,  'Selle Français'),
(6,  'Anglo-Arabe'),
(7,  'Hanovrien'),
(8,  'Lusitanien'),
(9,  'Trotteur Français'),
(10, 'KWPN');

INSERT INTO `client` (`id`, `titre`, `nom`, `prenom`, `rue`, `copos`, `ville`, `adresseMessagerie`, `pays_code`) VALUES
(1,  'M.',   'Dupont',      'Jean',     '12 rue des Lilas',      '75000', 'Paris',            'jean.dupont@mail.com',         'FRA'),
(2,  'Mme',  'Smith',       'Anna',     '45 Elm Street',         '10001', 'New York',         'anna.smith@mail.com',          'USA'),
(3,  'M.',   'Brown',       'James',    '7 Baker Street',        'NW1',   'London',           'james.brown@mail.co.uk',       'GBR'),
(4,  'Mme',  'Müller',      'Clara',    '23 Hauptstrasse',       '10115', 'Berlin',           'clara.mueller@mail.de',        'GER'),
(5,  'M.',   'Leclerc',     'Pierre',   '3 avenue Foch',         '69001', 'Lyon',             'pierre.leclerc@mail.fr',       'FRA'),
(6,  'Mme',  'Dubois',      'Sophie',   '18 rue Pasteur',        '33000', 'Bordeaux',         'sophie.dubois@mail.fr',        'FRA'),
(7,  'M.',   'Martin',      'Louis',    '9 rue du Château',      '44000', 'Nantes',           'louis.martin@mail.fr',         'FRA'),
(8,  'M.',   'O\'Brien',    'Liam',     '22 Grafton Street',     'D02',   'Dublin',           'liam.obrien@mail.ie',          'IRE'),
(9,  'Mme',  'Rossi',       'Giulia',   '5 Via Roma',            '00100', 'Rome',             'giulia.rossi@mail.it',         'ITA'),
(10, 'M.',   'Garcia',      'Carlos',   '14 Calle Mayor',        '28001', 'Madrid',           'carlos.garcia@mail.es',        'ESP'),
(11, 'Mme',  'Tanaka',      'Yuki',     '1-2-3 Shibuya',         '150',   'Tokyo',            'yuki.tanaka@mail.jp',          'JPN'),
(12, 'M.',   'Al Rashid',   'Rashid',   'PO Box 1000',           '00000', 'Dubai',            'rashid.alrashid@mail.ae',      'UAE'),
(13, 'M.',   'Van der Berg','Pieter',   '77 Herengracht',        '1015',  'Amsterdam',        'pieter.vdberg@mail.nl',        'NLD'),
(14, 'Mme',  'Laurent',     'Camille',  '6 Place Bellecour',     '69002', 'Lyon',             'camille.laurent@mail.fr',      'FRA'),
(15, 'M.',   'Hughes',      'William',  '10 King Street',        'SW1',   'London',           'william.hughes@mail.co.uk',    'GBR'),
(16, 'Mme',  'Fernandez',   'Isabella', '25 Av. Corrientes',     'C1043', 'Buenos Aires',     'isabella.fernandez@mail.ar',   'ARG'),
(17, 'M.',   'Dupré',       'Antoine',  '12 rue de la Paix',     '75001', 'Paris',            'antoine.dupre@mail.fr',        'FRA'),
(18, 'Mme',  'Schmidt',     'Helena',   '8 Unter den Linden',    '10117', 'Berlin',           'helena.schmidt@mail.de',       'GER'),
(19, 'M.',   'Murray',      'Patrick',  '3 O\'Connell Street',   'D01',   'Dublin',           'patrick.murray@mail.ie',       'IRE'),
(20, 'Mme',  'Chen',        'Wei',      '88 Nanjing Road',       '200001','Shanghai',         'wei.chen@mail.cn',             'JPN'),
(21, 'M.',   'Moreau',      'Frédéric', '45 cours Mirabeau',     '13100', 'Aix-en-Provence',  'frederic.moreau@mail.fr',      'FRA'),
(22, 'Mme',  'De Vries',    'Anna',     '14 Keizersgracht',      '1015',  'Amsterdam',        'anna.devries@mail.nl',         'NLD'),
(23, 'M.',   'Benali',      'Karim',    '7 rue Ibn Khaldoun',    '20000', 'Casablanca',       'karim.benali@mail.ma',         'ESP'),
(24, 'M.',   'Wilson',      'Edward',   '55 Park Avenue',        '10022', 'New York',         'edward.wilson@mail.com',       'USA');

INSERT INTO `acheteur` (`client_id`, `formation`) VALUES
(2,  'Formation de base'),
(4,  'Formation avancée'),
(5,  'Formation premium'),
(7,  'Formation de base'),
(8,  'Formation avancée'),
(10, 'Formation premium'),
(11, 'Formation de base'),
(12, 'Formation avancée'),
(13, 'Formation premium'),
(15, 'Formation de base'),
(17, 'Formation avancée'),
(19, 'Formation premium'),
(21, 'Formation de base'),
(23, 'Formation avancée'),
(24, 'Formation premium');

INSERT INTO `vendeur` (`client_id`, `ca`) VALUES
(1,   50000.00),
(3,   75000.00),
(6,  120000.00),
(9,   85000.00),
(14, 200000.00),
(16,  60000.00),
(18, 150000.00),
(20,  95000.00),
(22, 175000.00);

INSERT INTO `categvente` (`code`, `libelle`) VALUES
(1, 'Vente aux enchères'),
(2, 'Vente privée'),
(3, 'Vente en ligne'),
(4, 'Vente de yearlings'),
(5, 'Vente de prestige'),
(6, 'Vente de sport');

INSERT INTO `lieu` (`id`, `ville`, `nbBoxes`, `commentaires`) VALUES
(1,  'Paris',      50, 'Lieu principal des ventes'),
(2,  'London',     30, 'Lieu secondaire'),
(3,  'Berlin',     20, 'Lieu local'),
(4,  'Deauville',  80, 'Lieu emblématique des ventes de yearlings en France'),
(5,  'Dublin',     40, 'Principal lieu de vente en Irlande'),
(6,  'Dubai',      60, 'Ventes de prestige au Moyen-Orient'),
(7,  'Tokyo',      35, 'Ventes asiatiques haut de gamme'),
(8,  'Melbourne',  45, 'Principale salle de ventes d\'Australie'),
(9,  'Chantilly',  55, 'Haras de référence, ventes de prestige'),
(10, 'Newmarket',  70, 'Capitale mondiale des ventes de pur-sang');

INSERT INTO `cheval` (`id`, `nom`, `sexe`, `sire`, `dateNaissance`, `race_id`, `pere_id`, `mere_id`) VALUES
(1,  'Eclair',                'M', 'S123', '2018-05-10', 1,  NULL, NULL),
(2,  'Fleur',                 'F', 'S456', '2017-03-15', 2,  NULL, NULL),
(3,  'Lightning',             'M', 'S789', '2016-07-22', 3,  NULL, NULL),
(4,  'Storm',                 'F', 'S012', '2019-11-30', 4,  1,    2),
(7,  'Yakari',                'M', 'S894', '2025-09-07', 3,  NULL, NULL),
(8,  'Lechevaldechloe',       'F', 'S666', '2025-09-19', 1,  3,    4),
(9,  'Jack',                  'M', 'S111', '2025-10-15', 4,  7,    2),
(10, 'Michelle',              'F', 'S452', '2025-10-16', 2,  8,    1),
(14, 'Fhdsjs',                'F', 'S363', '2025-10-16', 2,  2,    4),
(15, 'Jdfhdskjfhdskjfhdskjf', 'F', 'S452', '2025-10-30', 3,  NULL, NULL),
(16, 'Tempête',               'M', 'S501', '2019-04-12', 1,  1,    4),
(17, 'Belle Étoile',          'F', 'S502', '2020-06-03', 5,  2,    3),
(18, 'Titan',                 'M', 'S503', '2018-09-18', 7,  3,    4),
(19, 'Aurore',                'F', 'S504', '2021-01-25', 6,  1,    2),
(20, 'Mistral',               'M', 'S505', '2017-11-07', 2,  4,    3),
(21, 'Perle Noire',           'F', 'S506', '2022-03-14', 1,  9,    10),
(22, 'Volcan',                'M', 'S507', '2016-08-29', 3,  10,   9),
(23, 'Saphir',                'F', 'S508', '2020-12-01', 8,  7,    8),
(24, 'Orion',                 'M', 'S509', '2019-07-17', 4,  8,    7),
(25, 'Comète',                'F', 'S510', '2021-05-22', 5,  16,   17),
(26, 'Diablo',                'M', 'S511', '2018-02-11', 3,  18,   17),
(27, 'Flambeau',              'M', 'S512', '2017-06-30', 1,  20,   19),
(28, 'Caramel',               'F', 'S513', '2022-08-08', 6,  22,   21),
(29, 'Tornade',               'M', 'S514', '2020-10-19', 7,  24,   23),
(30, 'Lumière',               'F', 'S515', '2019-03-05', 2,  26,   25),
(31, 'Ébène',                 'M', 'S516', '2018-07-14', 1,  3,    2),
(32, 'Cascada',               'F', 'S517', '2021-09-27', 5,  1,    4),
(33, 'Foudre',                'M', 'S518', '2017-04-03', 4,  4,    2),
(34, 'Rivière',               'F', 'S519', '2020-02-18', 6,  2,    3),
(35, 'Mirage',                'M', 'S520', '2019-11-11', 3,  7,    8),
(36, 'Galaxie',               'F', 'S521', '2022-01-30', 7,  9,    10),
(37, 'Tonnerre',              'M', 'S522', '2016-05-21', 1,  10,   9),
(38, 'Rosée',                 'F', 'S523', '2021-07-09', 8,  8,    7),
(39, 'Aquilon',               'M', 'S524', '2018-12-25', 2,  16,   17),
(40, 'Flocon',                'F', 'S525', '2020-04-15', 9,  18,   17),
(41, 'Ouragan',               'M', 'S526', '2019-08-06', 1,  20,   19),
(42, 'Mélodie',               'F', 'S527', '2022-06-19', 5,  22,   21),
(43, 'Pharaon',               'M', 'S528', '2017-10-02', 3,  24,   23),
(44, 'Ondine',                'F', 'S529', '2021-03-28', 6,  26,   25),
(45, 'Brasier',               'M', 'S530', '2018-01-17', 4,  27,   28),
(46, 'Diamant',               'F', 'S531', '2020-09-14', 1,  29,   30),
(47, 'Cyclone',               'M', 'S532', '2019-06-23', 7,  31,   32),
(48, 'Iris',                  'F', 'S533', '2022-04-05', 8,  33,   34),
(49, 'Mercure',               'M', 'S534', '2017-08-31', 2,  35,   36),
(50, 'Brume',                 'F', 'S535', '2021-11-20', 9,  37,   38),
(51, 'Fulgurant',             'M', 'S536', '2018-05-07', 1,  39,   40),
(52, 'Opale',                 'F', 'S537', '2020-07-26', 5,  41,   42),
(53, 'Zéphyr',                'M', 'S538', '2019-02-13', 3,  43,   44),
(54, 'Violette',              'F', 'S539', '2022-09-01', 6,  45,   46),
(55, 'Poséidon',              'M', 'S540', '2016-12-18', 4,  47,   48),
(56, 'Harmonie',              'F', 'S541', '2021-06-07', 10, 49,   50),
(57, 'Icare',                 'M', 'S542', '2018-03-22', 1,  51,   52),
(58, 'Jasmine',               'F', 'S543', '2020-11-15', 7,  53,   54),
(59, 'Kronos',                'M', 'S544', '2019-09-04', 2,  55,   56),
(60, 'Lavande',               'F', 'S545', '2022-02-11', 8,  57,   58),
(61, 'Malachite',             'M', 'S546', '2017-07-29', 3,  16,   17),
(62, 'Nébuleuse',             'F', 'S547', '2021-04-16', 5,  18,   19),
(63, 'Obsidienne',            'M', 'S548', '2018-10-08', 1,  20,   21),
(64, 'Pivoine',               'F', 'S549', '2020-08-03', 6,  22,   23),
(65, 'Quasar',                'M', 'S550', '2019-05-30', 4,  24,   25);

INSERT INTO `course` (`id`, `nom`, `lieu`, `date`) VALUES
(1,  'Prix de Paris',          'Longchamp',    '2023-06-20'),
(2,  'Grand National',         'Aintree',      '2023-07-15'),
(3,  'Derby',                  'Epsom',        '2023-08-01'),
(4,  'Prix de Diane',          'Chantilly',    '2023-06-11'),
(5,  'Arc de Triomphe',        'Longchamp',    '2023-10-01'),
(6,  'Dubai World Cup',        'Dubai',        '2024-03-30'),
(7,  'Japan Cup',              'Tokyo',        '2023-11-26'),
(8,  'Melbourne Cup',          'Melbourne',    '2023-11-07'),
(9,  'Irish Champion Stakes',  'Leopardstown', '2023-09-09'),
(10, 'Prix du Jockey Club',    'Chantilly',    '2024-06-02'),
(11, 'King George VI Stakes',  'Ascot',        '2024-07-27'),
(12, 'Breeders Cup Classic',   'Newmarket',    '2023-10-28');

INSERT INTO `cheval_course` (`cheval_id`, `course_id`, `position`) VALUES
(1,  1,  1), (1,  2,  2),
(2,  1,  1), (2,  2,  25),
(3,  2,  2),
(4,  1,  3), (4,  3,  3),
(7,  3,  1),
(8,  1,  5),
(16, 4,  1), (17, 4,  2), (18, 4,  3), (19, 4,  4),
(16, 5,  2), (20, 5,  1), (22, 5,  3), (31, 5,  4), (19, 5,  5),
(22, 6,  1), (24, 6,  2), (27, 6,  3), (43, 6,  4), (23, 6,  5),
(23, 7,  1), (29, 7,  2), (35, 7,  3), (56, 7,  5),
(20, 8,  1), (26, 8,  2), (33, 8,  3), (49, 8,  4), (40, 8,  5),
(17, 9,  2), (21, 9,  1), (30, 9,  3), (39, 9,  5),
(25, 10, 1), (32, 10, 2), (41, 10, 3), (47, 10, 4),
(28, 11, 1), (36, 11, 2), (44, 11, 3), (52, 11, 4), (48, 11, 5),
(37, 12, 1), (45, 12, 2), (53, 12, 3), (61, 12, 4);

INSERT INTO `cheval_parent` (`cheval_id`, `parent_id`) VALUES
(1,  2),  (3,  4),
(16, 1),  (16, 4),
(17, 2),  (17, 3),
(18, 3),  (18, 4),
(19, 1),  (19, 2),
(20, 4),  (20, 3),
(25, 16), (25, 17),
(26, 18), (26, 17),
(28, 22), (28, 21),
(29, 24), (29, 23),
(30, 26), (30, 25),
(45, 27), (45, 28),
(46, 29), (46, 30),
(51, 39), (51, 40),
(52, 41), (52, 42),
(57, 51), (57, 52);

INSERT INTO `vente` (`id`, `nom`, `dateDebutVente`, `categvente_code`, `lieu_id`) VALUES
(1,  'Vente été 2023',                 '2023-07-01', 1, 1),
(2,  'Vente privée automne',           '2023-10-15', 2, 2),
(3,  'Vente en ligne hiver',           '2023-12-05', 3, 3),
(4,  'Vente Yearlings Deauville 2024', '2024-08-15', 4, 4),
(5,  'Vente Prestige Dubai 2024',      '2024-03-20', 5, 6),
(6,  'Vente Été Paris 2024',           '2024-07-10', 1, 1),
(7,  'Vente Privée Dublin 2024',       '2024-09-05', 2, 5),
(8,  'Vente Sport Tokyo 2024',         '2024-11-12', 6, 7),
(9,  'Vente Hiver Londres 2024',       '2024-12-01', 1, 2),
(10, 'Vente Prestige Chantilly 2024',  '2024-06-18', 5, 9),
(11, 'Vente Newmarket Automne 2024',   '2024-10-08', 4, 10),
(12, 'Vente Printemps Berlin 2025',    '2025-04-22', 2, 3),
(13, 'Vente Melbourne 2025',           '2025-02-14', 1, 8);

INSERT INTO `lot` (`id`, `prixDepart`, `vente_id`, `cheval_id`) VALUES
(1,  15000, 1,  2),  (2,  12000, 2,  1),  (3,  18000, 3,  3),
(4,   2000, 2,  3),  (5,  60000, 2,  8),
(6,  25000, 4,  17), (7,  30000, 4,  18), (8,  22000, 4,  19),
(9,  28000, 4,  32), (10, 19000, 4,  34),
(11, 45000, 5,  20), (12, 80000, 5,  22), (13, 55000, 5,  27), (14, 70000, 5,  31),
(15, 15000, 6,  16), (16, 18000, 6,  21), (17, 12000, 6,  23),
(18, 20000, 6,  33), (19, 16000, 6,  35),
(20, 35000, 7,  24), (21, 27000, 7,  25), (22, 31000, 7,  36), (23, 24000, 7,  37),
(24, 20000, 8,  26), (25, 55000, 8,  29), (26, 38000, 8,  38), (27, 42000, 8,  39),
(28, 10000, 9,  28), (29, 42000, 9,  30), (30, 33000, 9,  40), (31, 25000, 9,  41),
(32, 60000, 10, 43), (33, 48000, 10, 45), (34, 72000, 10, 47), (35, 55000, 10, 49),
(36, 18000, 11, 42), (37, 22000, 11, 44), (38, 15000, 11, 46),
(39, 28000, 11, 48), (40, 20000, 11, 50),
(41, 35000, 12, 51), (42, 29000, 12, 53), (43, 41000, 12, 55), (44, 26000, 12, 57),
(45, 38000, 13, 52), (46, 44000, 13, 54), (47, 32000, 13, 56),
(48, 27000, 13, 58), (49, 50000, 13, 59),
(50, 65000, 10, 61), (51, 40000, 11, 62), (52, 30000, 12, 63),
(53, 22000, 13, 64), (54, 47000, 10, 65);

INSERT INTO `enchere` (`numero`, `montant`, `acheteur_id`, `lot_id`) VALUES
(1,  16000.00, 2,  1),  (2,  13000.00, 4,  2),  (3,  19000.00, 2,  3),
(4,  27000.00, 5,  6),  (5,  29500.00, 7,  6),  (6,  32000.00, 8,  6),
(7,  33000.00, 10, 7),  (8,  36000.00, 12, 7),
(9,  24000.00, 13, 8),  (10, 26500.00, 15, 8),
(11, 30000.00, 5,  9),  (12, 21000.00, 17, 10),
(13, 48000.00, 12, 11), (14, 53000.00, 11, 11), (15, 60000.00, 12, 11),
(16, 85000.00, 12, 12), (17, 92000.00, 15, 12),
(18, 58000.00, 24, 13), (19, 63000.00, 12, 13),
(20, 74000.00, 24, 14),
(21, 17000.00, 5,  15), (22, 20000.00, 7,  16), (23, 13500.00, 13, 17),
(24, 22000.00, 21, 18), (25, 18000.00, 23, 19),
(26, 38000.00, 8,  20), (27, 41000.00, 10, 20),
(28, 29000.00, 5,  21), (29, 33000.00, 19, 22), (30, 26000.00, 13, 23),
(31, 22000.00, 17, 24), (32, 57000.00, 12, 25),
(33, 40000.00, 21, 26), (34, 45000.00, 24, 27),
(35, 11000.00, 7,  28), (36, 44000.00, 8,  29), (37, 35000.00, 10, 30),
(38, 28000.00, 23, 31), (39, 65000.00, 12, 32), (40, 71000.00, 24, 32),
(41, 51000.00, 19, 33), (42, 55000.00, 15, 33),
(43, 78000.00, 12, 34), (44, 59000.00, 24, 35),
(45, 20000.00, 5,  36), (46, 24000.00, 13, 37), (47, 16500.00, 17, 38),
(48, 30000.00, 21, 39), (49, 22000.00, 23, 40),
(50, 38000.00, 8,  41), (51, 31000.00, 10, 42), (52, 44000.00, 19, 43),
(53, 28000.00, 5,  44), (54, 40000.00, 12, 45), (55, 47000.00, 15, 46),
(56, 34000.00, 24, 47), (57, 29000.00, 21, 48), (58, 54000.00, 12, 49),
(59, 68000.00, 24, 50), (60, 43000.00, 19, 51), (61, 32000.00, 8,  52),
(62, 46000.00, 10, 53), (63, 24000.00, 13, 54);

INSERT INTO `courriel` (`id`, `date`, `objet`, `corps`, `client_id`) VALUES
(1,  '2023-05-20', 'Invitation Vente',                    'Vous êtes invités à la vente été 2023.',                           1),
(2,  '2023-09-01', 'Rappel Vente',                        'N\'oubliez pas la vente privée automne.',                          3),
(3,  '2024-07-01', 'Invitation Vente Été Paris 2024',     'Nous vous invitons à notre grande vente estivale à Paris.',        5),
(4,  '2024-08-01', 'Catalogue Yearlings Deauville 2024',  'Retrouvez le catalogue complet de notre vente de yearlings.',      8),
(5,  '2024-03-01', 'Vente Prestige Dubai 2024',           'Une sélection exceptionnelle de chevaux de prestige vous attend.', 12),
(6,  '2024-09-01', 'Invitation Vente Privée Dublin 2024', 'Vous êtes sélectionné pour notre vente privée en Irlande.',       15),
(7,  '2024-11-01', 'Programme Vente Sport Tokyo 2024',    'Découvrez les chevaux inscrits à notre vente tokyoïte.',          11),
(8,  '2024-11-15', 'Rappel : Vente Hiver Londres 2024',   'Rappel de votre inscription à la vente hivernale de Londres.',    13),
(9,  '2024-06-10', 'Catalogue Prestige Chantilly 2024',   'Consultez notre sélection de chevaux d\'exception.',              24),
(10, '2024-09-20', 'Invitation Newmarket Automne 2024',   'Votre invitation pour la vente de Newmarket est confirmée.',      17);

INSERT INTO `piecejointe` (`id`, `chemin`, `description`, `courriel_id`) VALUES
(1,  '/docs/invitation.pdf',              'Invitation PDF',                     1),
(2,  '/docs/rappel.pdf',                  'Rappel PDF',                         2),
(3,  '/docs/catalogue_ete2024.pdf',       'Catalogue Vente Été 2024',           3),
(4,  '/docs/catalogue_yearlings2024.pdf', 'Catalogue Yearlings Deauville 2024', 4),
(5,  '/docs/catalogue_dubai2024.pdf',     'Catalogue Vente Prestige Dubai',     5),
(6,  '/docs/invitation_dublin2024.pdf',   'Invitation Vente Dublin',            6),
(7,  '/docs/programme_tokyo2024.pdf',     'Programme Vente Tokyo',              7),
(8,  '/docs/rappel_londres2024.pdf',      'Rappel Vente Londres',               8),
(9,  '/docs/catalogue_chantilly2024.pdf', 'Catalogue Prestige Chantilly',       9),
(10, '/docs/invitation_newmarket2024.pdf','Invitation Newmarket Automne',       10);

SET FOREIGN_KEY_CHECKS = 1;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
