-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3307
-- Généré le : mer. 01 oct. 2025 à 09:22
-- Version du serveur : 11.3.2-MariaDB
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `equida`
--

-- --------------------------------------------------------

--
-- Structure de la table `acheteur`
--

DROP TABLE IF EXISTS `acheteur`;
CREATE TABLE IF NOT EXISTS `acheteur` (
  `client_id` int(11) NOT NULL,
  `formation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `acheteur`
--

INSERT INTO `acheteur` (`client_id`, `formation`) VALUES
(2, 'Formation de base'),
(4, 'Formation avancée');

-- --------------------------------------------------------

--
-- Structure de la table `categvente`
--

DROP TABLE IF EXISTS `categvente`;
CREATE TABLE IF NOT EXISTS `categvente` (
  `code` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categvente`
--

INSERT INTO `categvente` (`code`, `libelle`) VALUES
(1, 'Vente aux enchères'),
(2, 'Vente privée'),
(3, 'Vente en ligne');

-- --------------------------------------------------------

--
-- Structure de la table `cheval`
--

DROP TABLE IF EXISTS `cheval`;
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `cheval`
--

INSERT INTO `cheval` (`id`, `nom`, `sexe`, `sire`, `dateNaissance`, `race_id`, `pere_id`, `mere_id`) VALUES
(1, 'Eclair', 'M', 'S123', '2018-05-10', 1, 2, 3),
(2, 'Fleur', 'F', 'S456', '2017-03-15', 2, 4, 7),
(3, 'Lightning', 'M', 'S789', '2016-07-22', 3, 4, 8),
(4, 'Storm', 'F', 'S012', '2019-11-30', 4, 1, 2),
(7, 'yakari', 'M', 'S894', '2025-09-07', 3, 10, 9),
(8, 'lechevaldechloe', 'F', 'S666', '2025-09-19', 1, 3, 4),
(9, 'Jack', 'M', 'S111', '2025-10-15', 4, 7, 2),
(10, 'Michelle', 'F', 'S452', '2025-10-16', 2, 8, 1),
(14, 'fhdsjs', 'F', 'S363', '2025-10-16', 2, 2, 4),
(15, 'jdfhdskjfhdskjfhdskjf', 'F', 'S452', '2025-10-30', 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `cheval_course`
--

DROP TABLE IF EXISTS `cheval_course`;
CREATE TABLE IF NOT EXISTS `cheval_course` (
  `cheval_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`cheval_id`,`course_id`),
  KEY `fk_cheval_course_course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `cheval_course`
--

INSERT INTO `cheval_course` (`cheval_id`, `course_id`, `position`) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 1, 1),
(2, 2, 25),
(3, 2, 2),
(4, 1, 3),
(4, 3, 3),
(7, 3, 1),
(8, 1, 5);

-- --------------------------------------------------------

--
-- Structure de la table `cheval_parent`
--

DROP TABLE IF EXISTS `cheval_parent`;
CREATE TABLE IF NOT EXISTS `cheval_parent` (
  `cheval_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  PRIMARY KEY (`cheval_id`,`parent_id`),
  KEY `fk_cheval_parent_parent` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `cheval_parent`
--

INSERT INTO `cheval_parent` (`cheval_id`, `parent_id`) VALUES
(1, 2),
(3, 4);

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id`, `titre`, `nom`, `prenom`, `rue`, `copos`, `ville`, `adresseMessagerie`, `pays_code`) VALUES
(1, 'M.', 'Dupont', 'Jean', '12 rue des Lilas', '75000', 'Paris', 'jean.dupont@mail.com', 'FRA'),
(2, 'Mme', 'Smith', 'Anna', '45 Elm Street', '10001', 'New York', 'anna.smith@mail.com', 'USA'),
(3, 'M.', 'Brown', 'James', '7 Baker Street', 'NW1', 'London', 'james.brown@mail.co.uk', 'GBR'),
(4, 'Mme', 'Müller', 'Clara', '23 Hauptstrasse', '10115', 'Berlin', 'clara.mueller@mail.de', 'GER');

-- --------------------------------------------------------

--
-- Structure de la table `courriel`
--

DROP TABLE IF EXISTS `courriel`;
CREATE TABLE IF NOT EXISTS `courriel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `objet` varchar(255) DEFAULT NULL,
  `corps` text DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_courriel_client` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `courriel`
--

INSERT INTO `courriel` (`id`, `date`, `objet`, `corps`, `client_id`) VALUES
(1, '2023-05-20', 'Invitation Vente', 'Vous êtes invités à la vente été 2023.', 1),
(2, '2023-09-01', 'Rappel Vente', 'N\'oubliez pas la vente privée automne.', 3);

-- --------------------------------------------------------

--
-- Structure de la table `course`
--

DROP TABLE IF EXISTS `course`;
CREATE TABLE IF NOT EXISTS `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) NOT NULL,
  `lieu` varchar(150) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `course`
--

INSERT INTO `course` (`id`, `nom`, `lieu`, `date`) VALUES
(1, 'Prix de Paris', 'Longchamp', '2023-06-20'),
(2, 'Grand National', 'Aintree', '2023-07-15'),
(3, 'Derby', 'Epsom', '2023-08-01');

-- --------------------------------------------------------

--
-- Structure de la table `enchere`
--

DROP TABLE IF EXISTS `enchere`;
CREATE TABLE IF NOT EXISTS `enchere` (
  `numero` int(11) NOT NULL AUTO_INCREMENT,
  `montant` decimal(12,2) NOT NULL,
  `acheteur_id` int(11) NOT NULL,
  `lot_id` int(11) NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `fk_enchere_acheteur` (`acheteur_id`),
  KEY `fk_enchere_lot` (`lot_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enchere`
--

INSERT INTO `enchere` (`numero`, `montant`, `acheteur_id`, `lot_id`) VALUES
(1, 16000.00, 2, 1),
(2, 13000.00, 4, 2),
(3, 19000.00, 2, 3);

-- --------------------------------------------------------

--
-- Structure de la table `lieu`
--

DROP TABLE IF EXISTS `lieu`;
CREATE TABLE IF NOT EXISTS `lieu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ville` varchar(150) DEFAULT NULL,
  `nbBoxes` int(11) DEFAULT NULL,
  `commentaires` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `lieu`
--

INSERT INTO `lieu` (`id`, `ville`, `nbBoxes`, `commentaires`) VALUES
(1, 'Paris', 50, 'Lieu principal des ventes'),
(2, 'London', 30, 'Lieu secondaire'),
(3, 'Berlin', 20, 'Lieu local');

-- --------------------------------------------------------

--
-- Structure de la table `lot`
--

DROP TABLE IF EXISTS `lot`;
CREATE TABLE IF NOT EXISTS `lot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prixDepart` int(11) DEFAULT NULL,
  `vente_id` int(11) DEFAULT NULL,
  `cheval_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lot_vente` (`vente_id`),
  KEY `fk_lot_cheval` (`cheval_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `lot`
--

INSERT INTO `lot` (`id`, `prixDepart`, `vente_id`, `cheval_id`) VALUES
(1, 15000, 1, 2),
(2, 12000, 2, 1),
(3, 18000, 3, 3),
(4, 2000, 2, 3),
(5, 60000, 2, 8);

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `code` char(3) NOT NULL,
  `nom` varchar(150) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `pays`
--

INSERT INTO `pays` (`code`, `nom`) VALUES
('FRA', 'France'),
('GBR', 'United Kingdom'),
('GER', 'Germany'),
('USA', 'United States');

-- --------------------------------------------------------

--
-- Structure de la table `piecejointe`
--

DROP TABLE IF EXISTS `piecejointe`;
CREATE TABLE IF NOT EXISTS `piecejointe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chemin` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `courriel_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_piecejointe_courriel` (`courriel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `piecejointe`
--

INSERT INTO `piecejointe` (`id`, `chemin`, `description`, `courriel_id`) VALUES
(1, '/docs/invitation.pdf', 'Invitation PDF', 1),
(2, '/docs/rappel.pdf', 'Rappel PDF', 2);

-- --------------------------------------------------------

--
-- Structure de la table `race`
--

DROP TABLE IF EXISTS `race`;
CREATE TABLE IF NOT EXISTS `race` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `race`
--

INSERT INTO `race` (`id`, `libelle`) VALUES
(1, 'Pur-sang'),
(2, 'Frison'),
(3, 'Arabe'),
(4, 'Quarter Horse');

-- --------------------------------------------------------

--
-- Structure de la table `vendeur`
--

DROP TABLE IF EXISTS `vendeur`;
CREATE TABLE IF NOT EXISTS `vendeur` (
  `client_id` int(11) NOT NULL,
  `ca` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `vendeur`
--

INSERT INTO `vendeur` (`client_id`, `ca`) VALUES
(1, 50000.00),
(3, 75000.00);

-- --------------------------------------------------------

--
-- Structure de la table `vente`
--

DROP TABLE IF EXISTS `vente`;
CREATE TABLE IF NOT EXISTS `vente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) NOT NULL,
  `dateDebutVente` date DEFAULT NULL,
  `categvente_code` int(11) DEFAULT NULL,
  `lieu_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vente_categvente` (`categvente_code`),
  KEY `fk_vente_lieu` (`lieu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `vente`
--

INSERT INTO `vente` (`id`, `nom`, `dateDebutVente`, `categvente_code`, `lieu_id`) VALUES
(1, 'Vente été 2023', '2023-07-01', 1, 1),
(2, 'Vente privée automne', '2023-10-15', 2, 2),
(3, 'Vente en ligne hiver', '2023-12-05', 3, 3);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `acheteur`
--
ALTER TABLE `acheteur`
  ADD CONSTRAINT `fk_acheteur_client` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`);

--
-- Contraintes pour la table `cheval`
--
ALTER TABLE `cheval`
  ADD CONSTRAINT `fk_cheval_mere` FOREIGN KEY (`mere_id`) REFERENCES `cheval` (`id`),
  ADD CONSTRAINT `fk_cheval_pere` FOREIGN KEY (`pere_id`) REFERENCES `cheval` (`id`),
  ADD CONSTRAINT `fk_cheval_race` FOREIGN KEY (`race_id`) REFERENCES `race` (`id`);

--
-- Contraintes pour la table `cheval_course`
--
ALTER TABLE `cheval_course`
  ADD CONSTRAINT `fk_cheval_course_cheval` FOREIGN KEY (`cheval_id`) REFERENCES `cheval` (`id`),
  ADD CONSTRAINT `fk_cheval_course_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

--
-- Contraintes pour la table `cheval_parent`
--
ALTER TABLE `cheval_parent`
  ADD CONSTRAINT `fk_cheval_parent_cheval` FOREIGN KEY (`cheval_id`) REFERENCES `cheval` (`id`),
  ADD CONSTRAINT `fk_cheval_parent_parent` FOREIGN KEY (`parent_id`) REFERENCES `cheval` (`id`);

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `fk_client_pays` FOREIGN KEY (`pays_code`) REFERENCES `pays` (`code`);

--
-- Contraintes pour la table `courriel`
--
ALTER TABLE `courriel`
  ADD CONSTRAINT `fk_courriel_client` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`);

--
-- Contraintes pour la table `enchere`
--
ALTER TABLE `enchere`
  ADD CONSTRAINT `fk_enchere_acheteur` FOREIGN KEY (`acheteur_id`) REFERENCES `acheteur` (`client_id`),
  ADD CONSTRAINT `fk_enchere_lot` FOREIGN KEY (`lot_id`) REFERENCES `lot` (`id`);

--
-- Contraintes pour la table `lot`
--
ALTER TABLE `lot`
  ADD CONSTRAINT `fk_lot_cheval` FOREIGN KEY (`cheval_id`) REFERENCES `cheval` (`id`),
  ADD CONSTRAINT `fk_lot_vente` FOREIGN KEY (`vente_id`) REFERENCES `vente` (`id`);

--
-- Contraintes pour la table `piecejointe`
--
ALTER TABLE `piecejointe`
  ADD CONSTRAINT `fk_piecejointe_courriel` FOREIGN KEY (`courriel_id`) REFERENCES `courriel` (`id`);

--
-- Contraintes pour la table `vendeur`
--
ALTER TABLE `vendeur`
  ADD CONSTRAINT `fk_vendeur_client` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`);

--
-- Contraintes pour la table `vente`
--
ALTER TABLE `vente`
  ADD CONSTRAINT `fk_vente_categvente` FOREIGN KEY (`categvente_code`) REFERENCES `categvente` (`code`),
  ADD CONSTRAINT `fk_vente_lieu` FOREIGN KEY (`lieu_id`) REFERENCES `lieu` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
