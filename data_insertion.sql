-- Fichier d'insertion de données pour la base de données emusic
-- Date de génération : 2025-10-13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- --------------------------------------------------------
-- Insertion des jours de la semaine
-- --------------------------------------------------------

INSERT INTO `jour` (`id`, `libelle`) VALUES
(1, 'Lundi'),
(2, 'Mardi'),
(3, 'Mercredi'),
(4, 'Jeudi'),
(5, 'Vendredi'),
(6, 'Samedi');

-- --------------------------------------------------------
-- Insertion des types de cours
-- --------------------------------------------------------

INSERT INTO `type` (`id`, `nom`) VALUES
(1, 'Piano'),
(2, 'Guitare'),
(3, 'Violon'),
(4, 'Flûte'),
(5, 'Batterie'),
(6, 'Chant'),
(7, 'Saxophone'),
(8, 'Violoncelle'),
(9, 'Formation Musicale'),
(10, 'Éveil Musical');

-- --------------------------------------------------------
-- Insertion des tranches tarifaires
-- --------------------------------------------------------

INSERT INTO `tranche` (`id`, `libelle`, `quotient_mini`) VALUES
(1, 'Tranche A', 0),
(2, 'Tranche B', 500),
(3, 'Tranche C', 1000),
(4, 'Tranche D', 1500),
(5, 'Tranche E', 2000);

-- --------------------------------------------------------
-- Association tranches-types (tarification par type de cours)
-- --------------------------------------------------------

INSERT INTO `tranche_type` (`tranche_id`, `type_id`) VALUES
-- Tous les types de cours disponibles pour toutes les tranches
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9), (2, 10),
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (3, 8), (3, 9), (3, 10),
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (4, 8), (4, 9), (4, 10),
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (5, 9), (5, 10);

-- --------------------------------------------------------
-- Insertion des cours
-- --------------------------------------------------------

INSERT INTO `cours` (`id`, `libelle`, `age_mini`, `heure_debut`, `heure_fin`, `type_id`, `jour_id`) VALUES
-- Lundi
(1, 'Piano Débutant', 7, '14:00:00', '15:00:00', 1, 1),
(2, 'Guitare Intermédiaire', 10, '15:00:00', '16:00:00', 2, 1),
(3, 'Formation Musicale Niveau 1', 7, '16:00:00', '17:00:00', 9, 1),
(4, 'Violon Débutant', 8, '17:00:00', '18:00:00', 3, 1),

-- Mardi
(5, 'Éveil Musical', 4, '14:00:00', '15:00:00', 10, 2),
(6, 'Batterie Débutant', 10, '15:00:00', '16:00:00', 5, 2),
(7, 'Chant Collectif', 12, '16:00:00', '17:00:00', 6, 2),
(8, 'Piano Avancé', 12, '17:00:00', '18:00:00', 1, 2),

-- Mercredi
(9, 'Éveil Musical', 4, '09:00:00', '10:00:00', 10, 3),
(10, 'Guitare Débutant', 8, '10:00:00', '11:00:00', 2, 3),
(11, 'Flûte Traversière', 9, '11:00:00', '12:00:00', 4, 3),
(12, 'Formation Musicale Niveau 2', 9, '14:00:00', '15:00:00', 9, 3),
(13, 'Violoncelle Débutant', 10, '15:00:00', '16:00:00', 8, 3),
(14, 'Saxophone Débutant', 11, '16:00:00', '17:00:00', 7, 3),

-- Jeudi
(15, 'Piano Intermédiaire', 9, '14:00:00', '15:00:00', 1, 4),
(16, 'Violon Intermédiaire', 10, '15:00:00', '16:00:00', 3, 4),
(17, 'Batterie Avancé', 13, '16:00:00', '17:00:00', 5, 4),
(18, 'Chant Individuel', 10, '17:00:00', '18:00:00', 6, 4),

-- Vendredi
(19, 'Formation Musicale Niveau 3', 11, '14:00:00', '15:00:00', 9, 5),
(20, 'Guitare Avancé', 13, '15:00:00', '16:00:00', 2, 5),
(21, 'Saxophone Intermédiaire', 13, '16:00:00', '17:00:00', 7, 5),
(22, 'Violoncelle Avancé', 14, '17:00:00', '18:00:00', 8, 5),

-- Samedi
(23, 'Éveil Musical', 4, '09:00:00', '10:00:00', 10, 6),
(24, 'Piano Débutant', 7, '10:00:00', '11:00:00', 1, 6),
(25, 'Guitare Débutant', 8, '11:00:00', '12:00:00', 2, 6),
(26, 'Formation Musicale Niveau 1', 7, '14:00:00', '15:00:00', 9, 6),
(27, 'Flûte Débutant', 9, '15:00:00', '16:00:00', 4, 6),
(28, 'Batterie Intermédiaire', 11, '16:00:00', '17:00:00', 5, 6);

-- --------------------------------------------------------
-- Insertion des responsables (parents/tuteurs)
-- --------------------------------------------------------

INSERT INTO `responsable` (`id`, `nom`, `prenom`, `num_rue`, `rue`, `copos`, `ville`, `tel`, `mail`, `tranche_id`) VALUES
(1, 'Martin', 'Sophie', 15, 'Rue de la République', 75001, 'Paris', 601234567, 'sophie.martin@email.fr', 3),
(2, 'Dubois', 'Pierre', 23, 'Avenue des Champs', 75008, 'Paris', 601234568, 'pierre.dubois@email.fr', 4),
(3, 'Bernard', 'Marie', 8, 'Rue Victor Hugo', 75016, 'Paris', 601234569, 'marie.bernard@email.fr', 2),
(4, 'Petit', 'Jean', 42, 'Boulevard Saint-Michel', 75005, 'Paris', 601234570, 'jean.petit@email.fr', 5),
(5, 'Durand', 'Claire', 17, 'Rue de Rivoli', 75004, 'Paris', 601234571, 'claire.durand@email.fr', 1),
(6, 'Leroy', 'Thomas', 31, 'Avenue Foch', 75116, 'Paris', 601234572, 'thomas.leroy@email.fr', 3),
(7, 'Moreau', 'Isabelle', 5, 'Rue Montmartre', 75002, 'Paris', 601234573, 'isabelle.moreau@email.fr', 2),
(8, 'Simon', 'Laurent', 12, 'Rue du Faubourg', 75011, 'Paris', 601234574, 'laurent.simon@email.fr', 4),
(9, 'Laurent', 'Nathalie', 28, 'Avenue de la Liberté', 75019, 'Paris', 601234575, 'nathalie.laurent@email.fr', 1),
(10, 'Lefebvre', 'Michel', 9, 'Rue des Écoles', 75006, 'Paris', 601234576, 'michel.lefebvre@email.fr', 3),
(11, 'Garnier', 'Sylvie', 19, 'Boulevard Haussmann', 75009, 'Paris', 601234577, 'sylvie.garnier@email.fr', 2),
(12, 'Rousseau', 'Marc', 6, 'Rue de la Paix', 75002, 'Paris', 601234578, 'marc.rousseau@email.fr', 5),
(13, 'Blanc', 'Catherine', 34, 'Avenue Montaigne', 75008, 'Paris', 601234579, 'catherine.blanc@email.fr', 4),
(14, 'Girard', 'François', 11, 'Rue Lafayette', 75010, 'Paris', 601234580, 'francois.girard@email.fr', 3),
(15, 'Bonnet', 'Émilie', 25, 'Rue du Commerce', 75015, 'Paris', 601234581, 'emilie.bonnet@email.fr', 1);

-- --------------------------------------------------------
-- Insertion des élèves
-- --------------------------------------------------------

INSERT INTO `eleve` (`id`, `nom`, `prenom`, `num_rue`, `rue`, `copos`, `ville`, `tel`, `mail`, `tranche_id`) VALUES
(1, 'Martin', 'Lucas', 15, 'Rue de la République', 75001, 'Paris', 612345671, 'lucas.martin@email.fr', 3),
(2, 'Martin', 'Emma', 15, 'Rue de la République', 75001, 'Paris', 612345672, 'emma.martin@email.fr', 3),
(3, 'Dubois', 'Hugo', 23, 'Avenue des Champs', 75008, 'Paris', 612345673, 'hugo.dubois@email.fr', 4),
(4, 'Bernard', 'Léa', 8, 'Rue Victor Hugo', 75016, 'Paris', 612345674, 'lea.bernard@email.fr', 2),
(5, 'Bernard', 'Tom', 8, 'Rue Victor Hugo', 75016, 'Paris', 612345675, 'tom.bernard@email.fr', 2),
(6, 'Petit', 'Chloé', 42, 'Boulevard Saint-Michel', 75005, 'Paris', 612345676, 'chloe.petit@email.fr', 5),
(7, 'Durand', 'Nathan', 17, 'Rue de Rivoli', 75004, 'Paris', 612345677, 'nathan.durand@email.fr', 1),
(8, 'Durand', 'Manon', 17, 'Rue de Rivoli', 75004, 'Paris', 612345678, 'manon.durand@email.fr', 1),
(9, 'Leroy', 'Louis', 31, 'Avenue Foch', 75116, 'Paris', 612345679, 'louis.leroy@email.fr', 3),
(10, 'Moreau', 'Julie', 5, 'Rue Montmartre', 75002, 'Paris', 612345680, 'julie.moreau@email.fr', 2),
(11, 'Simon', 'Alexandre', 12, 'Rue du Faubourg', 75011, 'Paris', 612345681, 'alexandre.simon@email.fr', 4),
(12, 'Simon', 'Sarah', 12, 'Rue du Faubourg', 75011, 'Paris', 612345682, 'sarah.simon@email.fr', 4),
(13, 'Laurent', 'Maxime', 28, 'Avenue de la Liberté', 75019, 'Paris', 612345683, 'maxime.laurent@email.fr', 1),
(14, 'Lefebvre', 'Clara', 9, 'Rue des Écoles', 75006, 'Paris', 612345684, 'clara.lefebvre@email.fr', 3),
(15, 'Garnier', 'Antoine', 19, 'Boulevard Haussmann', 75009, 'Paris', 612345685, 'antoine.garnier@email.fr', 2),
(16, 'Rousseau', 'Camille', 6, 'Rue de la Paix', 75002, 'Paris', 612345686, 'camille.rousseau@email.fr', 5),
(17, 'Blanc', 'Thomas', 34, 'Avenue Montaigne', 75008, 'Paris', 612345687, 'thomas.blanc@email.fr', 4),
(18, 'Blanc', 'Zoé', 34, 'Avenue Montaigne', 75008, 'Paris', 612345688, 'zoe.blanc@email.fr', 4),
(19, 'Girard', 'Arthur', 11, 'Rue Lafayette', 75010, 'Paris', 612345689, 'arthur.girard@email.fr', 3),
(20, 'Bonnet', 'Lola', 25, 'Rue du Commerce', 75015, 'Paris', 612345690, 'lola.bonnet@email.fr', 1),
(21, 'Bonnet', 'Noah', 25, 'Rue du Commerce', 75015, 'Paris', 612345691, 'noah.bonnet@email.fr', 1);

-- --------------------------------------------------------
-- Association élèves-responsables
-- --------------------------------------------------------

INSERT INTO `eleve_responsable` (`eleve_id`, `responsable_id`) VALUES
-- Famille Martin
(1, 1),
(2, 1),
-- Famille Dubois
(3, 2),
-- Famille Bernard
(4, 3),
(5, 3),
-- Famille Petit
(6, 4),
-- Famille Durand
(7, 5),
(8, 5),
-- Famille Leroy
(9, 6),
-- Famille Moreau
(10, 7),
-- Famille Simon
(11, 8),
(12, 8),
-- Famille Laurent
(13, 9),
-- Famille Lefebvre
(14, 10),
-- Famille Garnier
(15, 11),
-- Famille Rousseau
(16, 12),
-- Famille Blanc
(17, 13),
(18, 13),
-- Famille Girard
(19, 14),
-- Famille Bonnet
(20, 15),
(21, 15);

-- --------------------------------------------------------
-- Insertion des inscriptions
-- --------------------------------------------------------

INSERT INTO `inscription` (`id`, `date_inscrption`, `eleve_id`, `cours_id`) VALUES
-- Inscriptions de septembre 2025
(1, '2025-09-01', 1, 1),   -- Lucas Martin - Piano Débutant (Lundi)
(2, '2025-09-01', 1, 3),   -- Lucas Martin - Formation Musicale Niveau 1 (Lundi)
(3, '2025-09-01', 2, 9),   -- Emma Martin - Éveil Musical (Mercredi)
(4, '2025-09-02', 3, 2),   -- Hugo Dubois - Guitare Intermédiaire (Lundi)
(5, '2025-09-02', 3, 19),  -- Hugo Dubois - Formation Musicale Niveau 3 (Vendredi)
(6, '2025-09-03', 4, 4),   -- Léa Bernard - Violon Débutant (Lundi)
(7, '2025-09-03', 5, 10),  -- Tom Bernard - Guitare Débutant (Mercredi)
(8, '2025-09-04', 6, 7),   -- Chloé Petit - Chant Collectif (Mardi)
(9, '2025-09-04', 6, 21),  -- Chloé Petit - Saxophone Intermédiaire (Vendredi)
(10, '2025-09-05', 7, 24), -- Nathan Durand - Piano Débutant (Samedi)
(11, '2025-09-05', 8, 5),  -- Manon Durand - Éveil Musical (Mardi)
(12, '2025-09-07', 9, 15), -- Louis Leroy - Piano Intermédiaire (Jeudi)
(13, '2025-09-07', 9, 12), -- Louis Leroy - Formation Musicale Niveau 2 (Mercredi)
(14, '2025-09-08', 10, 11), -- Julie Moreau - Flûte Traversière (Mercredi)
(15, '2025-09-08', 11, 8),  -- Alexandre Simon - Piano Avancé (Mardi)
(16, '2025-09-09', 12, 6),  -- Sarah Simon - Batterie Débutant (Mardi)
(17, '2025-09-10', 13, 25), -- Maxime Laurent - Guitare Débutant (Samedi)
(18, '2025-09-10', 14, 16), -- Clara Lefebvre - Violon Intermédiaire (Jeudi)
(19, '2025-09-11', 15, 27), -- Antoine Garnier - Flûte Débutant (Samedi)
(20, '2025-09-12', 16, 22), -- Camille Rousseau - Violoncelle Avancé (Vendredi)
(21, '2025-09-12', 17, 17), -- Thomas Blanc - Batterie Avancé (Jeudi)
(22, '2025-09-13', 18, 18), -- Zoé Blanc - Chant Individuel (Jeudi)
(23, '2025-09-14', 19, 14), -- Arthur Girard - Saxophone Débutant (Mercredi)
(24, '2025-09-15', 20, 23), -- Lola Bonnet - Éveil Musical (Samedi)
(25, '2025-09-15', 21, 26), -- Noah Bonnet - Formation Musicale Niveau 1 (Samedi)
-- Inscriptions supplémentaires (certains élèves prennent plusieurs cours)
(26, '2025-09-16', 10, 26), -- Julie Moreau - Formation Musicale Niveau 1 (Samedi)
(27, '2025-09-17', 14, 12), -- Clara Lefebvre - Formation Musicale Niveau 2 (Mercredi)
(28, '2025-09-18', 19, 3),  -- Arthur Girard - Formation Musicale Niveau 1 (Lundi)
(29, '2025-09-20', 4, 26),  -- Léa Bernard - Formation Musicale Niveau 1 (Samedi)
(30, '2025-09-21', 17, 19); -- Thomas Blanc - Formation Musicale Niveau 3 (Vendredi)

-- --------------------------------------------------------
-- Insertion des paiements
-- --------------------------------------------------------

INSERT INTO `paiement` (`id`, `montant`, `date_paiement`, `inscription_id`) VALUES
-- Paiements pour les inscriptions (tarifs variables selon la tranche)
-- Tranche 1 (quotient 0-499): 150€ par cours/trimestre
-- Tranche 2 (quotient 500-999): 200€ par cours/trimestre
-- Tranche 3 (quotient 1000-1499): 250€ par cours/trimestre
-- Tranche 4 (quotient 1500-1999): 300€ par cours/trimestre
-- Tranche 5 (quotient 2000+): 350€ par cours/trimestre

-- Paiements de septembre (premier trimestre)
(1, 250, '2025-09-05', 1),   -- Lucas Martin (Tranche 3)
(2, 250, '2025-09-05', 2),   -- Lucas Martin (Tranche 3)
(3, 250, '2025-09-05', 3),   -- Emma Martin (Tranche 3)
(4, 300, '2025-09-06', 4),   -- Hugo Dubois (Tranche 4)
(5, 300, '2025-09-06', 5),   -- Hugo Dubois (Tranche 4)
(6, 200, '2025-09-07', 6),   -- Léa Bernard (Tranche 2)
(7, 200, '2025-09-07', 7),   -- Tom Bernard (Tranche 2)
(8, 350, '2025-09-08', 8),   -- Chloé Petit (Tranche 5)
(9, 350, '2025-09-08', 9),   -- Chloé Petit (Tranche 5)
(10, 150, '2025-09-10', 10), -- Nathan Durand (Tranche 1)
(11, 150, '2025-09-10', 11), -- Manon Durand (Tranche 1)
(12, 250, '2025-09-12', 12), -- Louis Leroy (Tranche 3)
(13, 250, '2025-09-12', 13), -- Louis Leroy (Tranche 3)
(14, 200, '2025-09-14', 14), -- Julie Moreau (Tranche 2)
(15, 300, '2025-09-15', 15), -- Alexandre Simon (Tranche 4)
(16, 300, '2025-09-15', 16), -- Sarah Simon (Tranche 4)
(17, 150, '2025-09-16', 17), -- Maxime Laurent (Tranche 1)
(18, 250, '2025-09-18', 18), -- Clara Lefebvre (Tranche 3)
(19, 200, '2025-09-20', 19), -- Antoine Garnier (Tranche 2)
(20, 350, '2025-09-22', 20), -- Camille Rousseau (Tranche 5)
(21, 300, '2025-09-23', 21), -- Thomas Blanc (Tranche 4)
(22, 300, '2025-09-23', 22), -- Zoé Blanc (Tranche 4)
(23, 250, '2025-09-25', 23), -- Arthur Girard (Tranche 3)
(24, 150, '2025-09-26', 24), -- Lola Bonnet (Tranche 1)
(25, 150, '2025-09-26', 25), -- Noah Bonnet (Tranche 1)
(26, 200, '2025-09-27', 26), -- Julie Moreau (Tranche 2)
(27, 250, '2025-09-28', 27), -- Clara Lefebvre (Tranche 3)
(28, 250, '2025-09-29', 28), -- Arthur Girard (Tranche 3)
(29, 200, '2025-09-30', 29), -- Léa Bernard (Tranche 2)
(30, 300, '2025-10-01', 30), -- Thomas Blanc (Tranche 4)

-- Paiements partiels (échelonnement) - Octobre
(31, 125, '2025-10-05', 1),  -- Lucas Martin - 2ème versement
(32, 125, '2025-10-05', 2),  -- Lucas Martin - 2ème versement
(33, 150, '2025-10-06', 4),  -- Hugo Dubois - 2ème versement
(34, 175, '2025-10-08', 8),  -- Chloé Petit - 2ème versement
(35, 175, '2025-10-08', 20); -- Camille Rousseau - 2ème versement

COMMIT;

-- Fin du fichier d'insertion de données
