-- Script de population de la base de données emusic
-- Données d'exemple pour l'école de musique
-- Date de création: 2025-10-13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Insertion des jours de la semaine
INSERT INTO `jour` (`id`, `libelle`) VALUES
(1, 'Lundi'),
(2, 'Mardi'),
(3, 'Mercredi'),
(4, 'Jeudi'),
(5, 'Vendredi'),
(6, 'Samedi'),
(7, 'Dimanche');

-- Insertion des types de cours
INSERT INTO `type` (`id`, `nom`) VALUES
(1, 'Piano'),
(2, 'Guitare'),
(3, 'Violon'),
(4, 'Flûte'),
(5, 'Batterie'),
(6, 'Chant'),
(7, 'Saxophone'),
(8, 'Éveil musical'),
(9, 'Formation musicale'),
(10, 'Ensemble instrumental');

-- Insertion des tranches tarifaires (basées sur le quotient familial)
INSERT INTO `tranche` (`id`, `libelle`, `quotient_mini`) VALUES
(1, 'Tranche A (QF < 500)', 0),
(2, 'Tranche B (QF 500-800)', 500),
(3, 'Tranche C (QF 800-1200)', 800),
(4, 'Tranche D (QF > 1200)', 1200);

-- Association tranches-types (tous les types disponibles pour toutes les tranches)
INSERT INTO `tranche_type` (`tranche_id`, `type_id`) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9), (2, 10),
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (3, 8), (3, 9), (3, 10),
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (4, 8), (4, 9), (4, 10);

-- Insertion des cours
INSERT INTO `cours` (`id`, `libelle`, `age_mini`, `heure_debut`, `heure_fin`, `type_id`, `jour_id`) VALUES
(1, 'Piano débutant enfants', 6, '14:00:00', '15:00:00', 1, 3),
(2, 'Piano intermédiaire', 10, '15:00:00', '16:00:00', 1, 3),
(3, 'Piano adultes', 16, '18:00:00', '19:00:00', 1, 2),
(4, 'Guitare débutant', 8, '16:00:00', '17:00:00', 2, 4),
(5, 'Guitare avancé', 12, '17:00:00', '18:00:00', 2, 4),
(6, 'Violon enfants', 6, '14:30:00', '15:30:00', 3, 1),
(7, 'Violon adultes', 16, '19:00:00', '20:00:00', 3, 1),
(8, 'Flûte traversière', 8, '15:30:00', '16:30:00', 4, 5),
(9, 'Batterie débutant', 10, '16:30:00', '17:30:00', 5, 6),
(10, 'Batterie confirmé', 14, '17:30:00', '18:30:00', 5, 6),
(11, 'Chant enfants', 8, '14:00:00', '15:00:00', 6, 2),
(12, 'Chant adultes', 16, '20:00:00', '21:00:00', 6, 2),
(13, 'Saxophone', 12, '18:00:00', '19:00:00', 7, 5),
(14, 'Éveil musical 3-5 ans', 3, '10:00:00', '10:45:00', 8, 6),
(15, 'Formation musicale débutant', 6, '11:00:00', '12:00:00', 9, 6),
(16, 'Formation musicale avancé', 10, '13:00:00', '14:00:00', 9, 6),
(17, 'Ensemble de guitares', 12, '19:00:00', '20:30:00', 10, 4),
(18, 'Orchestre junior', 8, '15:00:00', '16:30:00', 10, 6);

-- Insertion des responsables (parents/tuteurs)
INSERT INTO `responsable` (`id`, `nom`, `prenom`, `num_rue`, `rue`, `copos`, `ville`, `tel`, `mail`, `tranche_id`) VALUES
(1, 'Martin', 'Sophie', 15, 'Rue de la Paix', 75001, 'Paris', 142345678, 'sophie.martin@email.com', 2),
(2, 'Dubois', 'Pierre', 23, 'Avenue des Champs', 75008, 'Paris', 145678901, 'pierre.dubois@email.com', 3),
(3, 'Moreau', 'Marie', 8, 'Rue Victor Hugo', 69001, 'Lyon', 478901234, 'marie.moreau@email.com', 1),
(4, 'Leroy', 'Jean', 42, 'Boulevard Saint-Michel', 75005, 'Paris', 143567890, 'jean.leroy@email.com', 4),
(5, 'Roux', 'Catherine', 7, 'Place de la République', 13001, 'Marseille', 491234567, 'catherine.roux@email.com', 2),
(6, 'Petit', 'Michel', 19, 'Rue de Rivoli', 75004, 'Paris', 144567123, 'michel.petit@email.com', 3),
(7, 'Garnier', 'Isabelle', 31, 'Avenue Foch', 33000, 'Bordeaux', 556789012, 'isabelle.garnier@email.com', 1),
(8, 'Blanc', 'François', 12, 'Rue Nationale', 59000, 'Lille', 320456789, 'francois.blanc@email.com', 4),
(9, 'Simon', 'Nathalie', 5, 'Cours Mirabeau', 13100, 'Aix-en-Provence', 442345678, 'nathalie.simon@email.com', 2),
(10, 'Bernard', 'Alain', 28, 'Rue de la Liberté', 21000, 'Dijon', 380567890, 'alain.bernard@email.com', 3);

-- Insertion des élèves
INSERT INTO `eleve` (`id`, `nom`, `prenom`, `num_rue`, `rue`, `copos`, `ville`, `tel`, `mail`, `tranche_id`) VALUES
(1, 'Martin', 'Lucas', 15, 'Rue de la Paix', 75001, 'Paris', 142345679, 'lucas.martin@email.com', 2),
(2, 'Martin', 'Emma', 15, 'Rue de la Paix', 75001, 'Paris', 142345680, 'emma.martin@email.com', 2),
(3, 'Dubois', 'Hugo', 23, 'Avenue des Champs', 75008, 'Paris', 145678902, 'hugo.dubois@email.com', 3),
(4, 'Moreau', 'Léa', 8, 'Rue Victor Hugo', 69001, 'Lyon', 478901235, 'lea.moreau@email.com', 1),
(5, 'Leroy', 'Nathan', 42, 'Boulevard Saint-Michel', 75005, 'Paris', 143567891, 'nathan.leroy@email.com', 4),
(6, 'Roux', 'Chloé', 7, 'Place de la République', 13001, 'Marseille', 491234568, 'chloe.roux@email.com', 2),
(7, 'Petit', 'Tom', 19, 'Rue de Rivoli', 75004, 'Paris', 144567124, 'tom.petit@email.com', 3),
(8, 'Garnier', 'Manon', 31, 'Avenue Foch', 33000, 'Bordeaux', 556789013, 'manon.garnier@email.com', 1),
(9, 'Blanc', 'Théo', 12, 'Rue Nationale', 59000, 'Lille', 320456790, 'theo.blanc@email.com', 4),
(10, 'Simon', 'Jade', 5, 'Cours Mirabeau', 13100, 'Aix-en-Provence', 442345679, 'jade.simon@email.com', 2),
(11, 'Bernard', 'Maxime', 28, 'Rue de la Liberté', 21000, 'Dijon', 380567891, 'maxime.bernard@email.com', 3),
(12, 'Dupont', 'Zoé', 14, 'Rue Mozart', 75016, 'Paris', 145123456, 'zoe.dupont@email.com', 1),
(13, 'Lemaire', 'Antoine', 9, 'Avenue Beethoven', 69003, 'Lyon', 472345678, 'antoine.lemaire@email.com', 2),
(14, 'Rousseau', 'Clara', 22, 'Rue Chopin', 13006, 'Marseille', 496543210, 'clara.rousseau@email.com', 3),
(15, 'Faure', 'Paul', 6, 'Boulevard Bach', 31000, 'Toulouse', 561234567, 'paul.faure@email.com', 4);

-- Association élèves-responsables
INSERT INTO `eleve_responsable` (`eleve_id`, `responsable_id`) VALUES
(1, 1), (2, 1), -- Lucas et Emma Martin avec Sophie Martin
(3, 2), -- Hugo Dubois avec Pierre Dubois
(4, 3), -- Léa Moreau avec Marie Moreau
(5, 4), -- Nathan Leroy avec Jean Leroy
(6, 5), -- Chloé Roux avec Catherine Roux
(7, 6), -- Tom Petit avec Michel Petit
(8, 7), -- Manon Garnier avec Isabelle Garnier
(9, 8), -- Théo Blanc avec François Blanc
(10, 9), -- Jade Simon avec Nathalie Simon
(11, 10), -- Maxime Bernard avec Alain Bernard
(12, 1), -- Zoé Dupont avec Sophie Martin (garde partagée)
(13, 3), -- Antoine Lemaire avec Marie Moreau (famille recomposée)
(14, 5), -- Clara Rousseau avec Catherine Roux (famille recomposée)
(15, 8); -- Paul Faure avec François Blanc (famille recomposée)

-- Inscription des élèves aux cours
INSERT INTO `inscription` (`id`, `date_inscrption`, `eleve_id`, `cours_id`) VALUES
(1, '2025-09-01', 1, 1), -- Lucas Martin -> Piano débutant enfants
(2, '2025-09-01', 1, 15), -- Lucas Martin -> Formation musicale débutant
(3, '2025-09-01', 2, 14), -- Emma Martin -> Éveil musical 3-5 ans
(4, '2025-09-02', 3, 4), -- Hugo Dubois -> Guitare débutant
(5, '2025-09-02', 3, 16), -- Hugo Dubois -> Formation musicale avancé
(6, '2025-09-03', 4, 6), -- Léa Moreau -> Violon enfants
(7, '2025-09-03', 5, 2), -- Nathan Leroy -> Piano intermédiaire
(8, '2025-09-04', 6, 11), -- Chloé Roux -> Chant enfants
(9, '2025-09-04', 7, 9), -- Tom Petit -> Batterie débutant
(10, '2025-09-05', 8, 8), -- Manon Garnier -> Flûte traversière
(11, '2025-09-05', 9, 10), -- Théo Blanc -> Batterie confirmé
(12, '2025-09-06', 10, 11), -- Jade Simon -> Chant enfants
(13, '2025-09-06', 11, 13), -- Maxime Bernard -> Saxophone
(14, '2025-09-07', 12, 1), -- Zoé Dupont -> Piano débutant enfants
(15, '2025-09-07', 13, 5), -- Antoine Lemaire -> Guitare avancé
(16, '2025-09-08', 14, 12), -- Clara Rousseau -> Chant adultes
(17, '2025-09-08', 15, 3), -- Paul Faure -> Piano adultes
(18, '2025-09-10', 1, 18), -- Lucas Martin -> Orchestre junior (2e cours)
(19, '2025-09-10', 3, 17), -- Hugo Dubois -> Ensemble de guitares (2e cours)
(20, '2025-09-11', 5, 18); -- Nathan Leroy -> Orchestre junior (2e cours)

-- Paiements des inscriptions
INSERT INTO `paiement` (`id`, `montant`, `date_paiement`, `inscription_id`) VALUES
(1, 180.00, '2025-09-01', 1), -- Paiement Lucas Piano
(2, 120.00, '2025-09-01', 2), -- Paiement Lucas Formation musicale
(3, 90.00, '2025-09-01', 3), -- Paiement Emma Éveil musical
(4, 200.00, '2025-09-02', 4), -- Paiement Hugo Guitare
(5, 140.00, '2025-09-02', 5), -- Paiement Hugo Formation musicale
(6, 150.00, '2025-09-03', 6), -- Paiement Léa Violon
(7, 220.00, '2025-09-03', 7), -- Paiement Nathan Piano
(8, 130.00, '2025-09-04', 8), -- Paiement Chloé Chant
(9, 200.00, '2025-09-04', 9), -- Paiement Tom Batterie
(10, 160.00, '2025-09-05', 10), -- Paiement Manon Flûte
(11, 240.00, '2025-09-05', 11), -- Paiement Théo Batterie
(12, 130.00, '2025-09-06', 12), -- Paiement Jade Chant
(13, 210.00, '2025-09-06', 13), -- Paiement Maxime Saxophone
(14, 120.00, '2025-09-07', 14), -- Paiement Zoé Piano (tranche A)
(15, 200.00, '2025-09-07', 15), -- Paiement Antoine Guitare
(16, 150.00, '2025-09-08', 16), -- Paiement Clara Chant
(17, 250.00, '2025-09-08', 17), -- Paiement Paul Piano adultes
(18, 100.00, '2025-09-10', 18), -- Paiement Lucas Orchestre
(19, 110.00, '2025-09-10', 19), -- Paiement Hugo Ensemble
(20, 120.00, '2025-09-11', 20), -- Paiement Nathan Orchestre
-- Paiements échelonnés (2e trimestre)
(21, 180.00, '2025-12-01', 1), -- 2e paiement Lucas Piano
(22, 120.00, '2025-12-01', 2), -- 2e paiement Lucas Formation
(23, 90.00, '2025-12-01', 3), -- 2e paiement Emma Éveil
(24, 200.00, '2025-12-02', 4), -- 2e paiement Hugo Guitare
(25, 140.00, '2025-12-02', 5); -- 2e paiement Hugo Formation

COMMIT;

-- Vérification des données insérées
SELECT 'Jours' as Table_Name, COUNT(*) as Nb_Records FROM jour
UNION ALL
SELECT 'Types', COUNT(*) FROM type
UNION ALL
SELECT 'Tranches', COUNT(*) FROM tranche
UNION ALL
SELECT 'Cours', COUNT(*) FROM cours
UNION ALL
SELECT 'Responsables', COUNT(*) FROM responsable
UNION ALL
SELECT 'Élèves', COUNT(*) FROM eleve
UNION ALL
SELECT 'Inscriptions', COUNT(*) FROM inscription
UNION ALL
SELECT 'Paiements', COUNT(*) FROM paiement
UNION ALL
SELECT 'Associations élève-responsable', COUNT(*) FROM eleve_responsable
UNION ALL
SELECT 'Associations tranche-type', COUNT(*) FROM tranche_type;