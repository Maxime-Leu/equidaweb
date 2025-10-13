-- Seed initial data for emusic
-- Generated: 2025-10-13

SET NAMES utf8mb4;
SET time_zone = '+00:00';

START TRANSACTION;

USE `emusic`;

-- Reference tables
INSERT INTO `jour` (`id`, `libelle`) VALUES
  (1,'Lundi'),
  (2,'Mardi'),
  (3,'Mercredi'),
  (4,'Jeudi'),
  (5,'Vendredi'),
  (6,'Samedi'),
  (7,'Dimanche')
ON DUPLICATE KEY UPDATE `libelle` = VALUES(`libelle`);

INSERT INTO `type` (`id`, `nom`) VALUES
  (1,'Piano'),
  (2,'Guitare'),
  (3,'Batterie'),
  (4,'Chant')
ON DUPLICATE KEY UPDATE `nom` = VALUES(`nom`);

INSERT INTO `tranche` (`id`, `libelle`, `quotient_mini`) VALUES
  (1,'Tranche 1',0),
  (2,'Tranche 2',500),
  (3,'Tranche 3',1000)
ON DUPLICATE KEY UPDATE `libelle` = VALUES(`libelle`), `quotient_mini` = VALUES(`quotient_mini`);

-- Many-to-many associations
INSERT IGNORE INTO `tranche_type` (`tranche_id`, `type_id`) VALUES
  (1,1),(1,2),(1,3),(1,4),
  (2,1),(2,2),(2,3),(2,4),
  (3,1),(3,2),(3,3),(3,4);

-- Cours
INSERT INTO `cours` (`id`, `libelle`, `age_mini`, `heure_debut`, `heure_fin`, `type_id`, `jour_id`) VALUES
  (1,'Piano Enfants Débutant',6,'17:00:00','18:00:00',1,3),
  (2,'Guitare Ados',12,'18:00:00','19:30:00',2,4),
  (3,'Chant Adultes',18,'19:00:00','20:30:00',4,2),
  (4,'Batterie Junior',8,'16:30:00','17:30:00',3,6),
  (5,'Piano Adultes Intermédiaire',18,'20:00:00','21:00:00',1,5)
ON DUPLICATE KEY UPDATE
  `libelle`=VALUES(`libelle`),
  `age_mini`=VALUES(`age_mini`),
  `heure_debut`=VALUES(`heure_debut`),
  `heure_fin`=VALUES(`heure_fin`),
  `type_id`=VALUES(`type_id`),
  `jour_id`=VALUES(`jour_id`);

-- Responsables (parents/tuteurs)
INSERT INTO `responsable` (
  `id`, `nom`, `prenom`, `num_rue`, `rue`, `copos`, `ville`, `tel`, `mail`, `tranche_id`
) VALUES
  (1,'Dupont','Marie',12,'Rue de la Paix',75001,'Paris',612345678,'marie.dupont@example.com',2),
  (2,'Durand','Paul',5,'Avenue Victor Hugo',44000,'Nantes',612345679,'paul.durand@example.com',1),
  (3,'Bernard','Sophie',78,'Boulevard Saint-Michel',35000,'Rennes',612345680,'sophie.bernard@example.com',3),
  (4,'Martin','Jean',24,'Rue des Lilas',69000,'Lyon',612345685,'jean.martin@example.com',2)
ON DUPLICATE KEY UPDATE
  `nom`=VALUES(`nom`),
  `prenom`=VALUES(`prenom`),
  `num_rue`=VALUES(`num_rue`),
  `rue`=VALUES(`rue`),
  `copos`=VALUES(`copos`),
  `ville`=VALUES(`ville`),
  `tel`=VALUES(`tel`),
  `mail`=VALUES(`mail`),
  `tranche_id`=VALUES(`tranche_id`);

-- Élèves
INSERT INTO `eleve` (
  `id`, `nom`, `prenom`, `num_rue`, `rue`, `copos`, `ville`, `tel`, `mail`, `tranche_id`
) VALUES
  (1,'Dupont','Lucas',12,'Rue de la Paix',75001,'Paris',612345681,'lucas.dupont@example.com',2),
  (2,'Durand','Emma',5,'Avenue Victor Hugo',44000,'Nantes',612345682,'emma.durand@example.com',1),
  (3,'Bernard','Noah',78,'Boulevard Saint-Michel',35000,'Rennes',612345683,'noah.bernard@example.com',3),
  (4,'Martin','Chloé',24,'Rue des Lilas',69000,'Lyon',612345684,'chloe.martin@example.com',2)
ON DUPLICATE KEY UPDATE
  `nom`=VALUES(`nom`),
  `prenom`=VALUES(`prenom`),
  `num_rue`=VALUES(`num_rue`),
  `rue`=VALUES(`rue`),
  `copos`=VALUES(`copos`),
  `ville`=VALUES(`ville`),
  `tel`=VALUES(`tel`),
  `mail`=VALUES(`mail`),
  `tranche_id`=VALUES(`tranche_id`);

-- Liens élève-responsable (plusieurs responsables possibles)
INSERT IGNORE INTO `eleve_responsable` (`eleve_id`, `responsable_id`) VALUES
  (1,1),
  (1,2),
  (2,2),
  (3,3),
  (4,4);

-- Inscriptions
INSERT INTO `inscription` (`id`, `date_inscrption`, `eleve_id`, `cours_id`) VALUES
  (1,'2025-09-10',1,1),
  (2,'2025-09-12',2,2),
  (3,'2025-09-15',3,4),
  (4,'2025-09-18',4,3)
ON DUPLICATE KEY UPDATE
  `date_inscrption`=VALUES(`date_inscrption`),
  `eleve_id`=VALUES(`eleve_id`),
  `cours_id`=VALUES(`cours_id`);

-- Paiements
INSERT INTO `paiement` (`id`, `montant`, `date_paiement`, `inscription_id`) VALUES
  (1,120.00,'2025-09-20',1),
  (2,150.00,'2025-09-22',2),
  (3,100.00,'2025-09-25',3)
ON DUPLICATE KEY UPDATE
  `montant`=VALUES(`montant`),
  `date_paiement`=VALUES(`date_paiement`),
  `inscription_id`=VALUES(`inscription_id`);

COMMIT;
