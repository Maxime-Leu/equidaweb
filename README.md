EquidaWeb

Application web de gestion des ventes aux enchères équines, développée dans le cadre du **BTS SIO - Épreuve E6**.

---

## Table des matières

- [Présentation](#présentation)
- [Fonctionnalités](#fonctionnalités)
- [Architecture](#architecture)
- [Modèle de données](#modèle-de-données)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Structure du projet](#structure-du-projet)
- [Technologies utilisées](#technologies-utilisées)
- [Auteur](#auteur)

---

## Présentation

**EquidaWeb** est une application web Java/Jakarta EE permettant la gestion d'une plateforme de ventes aux enchères de chevaux. Elle offre un interface permettant de consulter, ajouter et modifier des ventes, des chevaux, et de suivre les enchères en temps réel.

---

## Fonctionnalités

### Gestion des ventes
- Lister toutes les ventes (triées par date)
- Consulter le détail d'une vente avec la liste des chevaux proposés
- Ajouter une nouvelle vente (nom, date, lieu, catégorie)
- Modifier une vente existante

### Gestion des chevaux
- Lister tous les chevaux avec leur race
- Consulter la fiche détaillée d'un cheval (nom, sexe, SIRE, date de naissance, race, père, mère)
- Afficher les courses auxquelles le cheval a participé (nom de la course, date, position)
- Ajouter un nouveau cheval

### Gestion des enchères
- Placer une enchère sur un lot
- Vérification automatique que la mise est supérieure au prix de départ et à l'enchère en cours
- Redirection avec message de succès ou d'erreur

---

## Architecture

Le projet suit le patron **MVC (Modèle - Vue - Contrôleur)** :

```
Navigateur
    │
    ▼
Servlet (Contrôleur)          ← package servlet/
    │
    ├──► DAO (Accès BDD)      ← package database/
    │         │
    │         └──► MariaDB
    │
    ├──► Modèle (POJO)        ← package model/
    │
    └──► JSP (Vue)            ← WEB-INF/views/
```

### Packages Java

| Package | Rôle |
|---|---|
| `servlet` | Contrôleurs HTTP (ChevalServlet, VenteServlet, EnchereServlet) |
| `database` | DAOs et gestion de la connexion à la base de données |
| `model` | Classes métier (POJO) |
| `test` | Classes de test unitaire des modèles |
| `sio.equidaweb` | Configuration Jakarta REST |

---

## Modèle de données

La base de données `equida` contient les tables suivantes :

```
pays         ← référentiel pays
race         ← races de chevaux
client       ← clients (acheteurs et vendeurs)
  ├── acheteur
  └── vendeur
cheval       ← catalogue équin (avec père/mère auto-référencé)
course       ← courses hippiques
cheval_course← participation d'un cheval à une course (avec position)
cheval_parent← table de liaison parents (redondante avec pere_id/mere_id)
categvente   ← catégories de vente
lieu         ← lieux de vente (avec nombre de boxes)
vente        ← sessions de vente
lot          ← lots mis en vente (1 cheval = 1 lot par vente)
enchere      ← enchères placées sur les lots
courriel     ← courriels envoyés aux clients
piecejointe  ← pièces jointes aux courriels
```

**Données de démo incluses :** 60 chevaux, 10 races, 24 clients, 13 ventes, 54 lots, 63 enchères.

---

## Prérequis

- **JDK 11+** (Jakarta EE 10)
- **Apache Tomcat 10+** (ou tout serveur compatible Jakarta EE)
- **MariaDB** (port `3306` par défaut)
- **NetBeans** (recommandé) ou Maven

---

## Installation

### 1. Cloner le dépôt

```bash
git clone https://github.com/Maxime-Leu/equidaweb.git
cd equidaweb
```

### 2. Créer la base de données

Connectez-vous à MariaDB et exécutez le script SQL fourni :

```bash
mysql -u root -p < src/main/java/database/script/equida.sql
```

Ou depuis votre client SQL, exécutez le contenu du fichier `equida.sql`. Cela va :
- Créer la base `equida`
- Créer toutes les tables avec leurs contraintes
- Insérer les données de démo

### 3. Configurer la connexion

La connexion est définie dans `ConnexionServlet.java`. Vérifiez que les paramètres correspondent à votre environnement :

```java
// src/main/java/database/ConnexionServlet.java
cnx = DriverManager.getConnection(
    "jdbc:mariadb://127.0.0.1:3306/equida",
    "root",
    ""     // ← Modifiez si votre root a un mot de passe
);
```

>  **Note :** Au lycée, le port MariaDB peut être `3307`. Vérifiez et adaptez si nécessaire.

### 4. Compiler et déployer

**Avec NetBeans :**
1. Ouvrir le projet (`File > Open Project`)
2. Configurer un serveur Tomcat dans les propriétés du projet
3. `Run > Run Project` (F6)

**Avec Maven :**
```bash
mvn clean package
# Déployer le .war généré dans le dossier webapps de Tomcat
```

### 5. Accéder à l'application

```
http://localhost:8080/equidaweb/
```

---

## Structure du projet

```
equidaweb/
├── src/main/
│   ├── java/
│   │   ├── database/
│   │   │   ├── ConnexionServlet.java     # Listener de connexion BDD (contexte)
│   │   │   ├── Connexionbdd.java         # Utilitaire de connexion standalone
│   │   │   ├── DaoCheval.java            # CRUD chevaux
│   │   │   ├── DaoVente.java             # CRUD ventes
│   │   │   ├── DaoLot.java               # Accès aux lots
│   │   │   ├── DaoEnchere.java           # Gestion des enchères
│   │   │   ├── DaoRace.java              # Référentiel races
│   │   │   ├── DaoLieu.java              # Référentiel lieux
│   │   │   ├── DaoCategVente.java        # Référentiel catégories
│   │   │   └── script/
│   │   │       └── equida.sql            # Script BDD complet
│   │   ├── model/
│   │   │   ├── Cheval.java
│   │   │   ├── Race.java
│   │   │   ├── Course.java
│   │   │   ├── ChevalCourse.java
│   │   │   ├── Vente.java
│   │   │   ├── Lot.java
│   │   │   ├── Enchere.java
│   │   │   ├── CategVente.java
│   │   │   └── Lieu.java
│   │   ├── servlet/
│   │   │   ├── ChevalServlet.java        # /cheval-servlet/*
│   │   │   ├── VenteServlet.java         # /vente-servlet/*
│   │   │   └── EnchereServlet.java       # /enchere-servlet/*
│   │   └── test/
│   │       ├── TestCheval.java
│   │       ├── TestVente.java
│   │       ├── TestLot.java
│   │       └── ...
│   ├── resources/
│   │   └── META-INF/persistence.xml
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── web.xml
│       │   └── views/
│       │       ├── header.jsp
│       │       ├── cheval/
│       │       │   ├── list.jsp
│       │       │   ├── show.jsp
│       │       │   └── add.jsp
│       │       └── vente/
│       │           ├── list.jsp
│       │           ├── show.jsp
│       │           ├── add.jsp
│       │           └── edit.jsp
│       └── index.jsp                     # Dashboard d'accueil
├── pom.xml
└── README.md
```

---

## Technologies utilisées

| Technologie | Version | Usage |
|---|---|---|
| Java | 11+ | Langage principal |
| Jakarta EE | 10 | Servlets, Listeners |
| MariaDB JDBC | - | Connecteur base de données |
| MariaDB | - | SGBD relationnel |
| JSP | - | Vues (templates HTML) |
| Bootstrap | 3.3.7 | Interface utilisateur |
| Apache Tomcat | 10+ | Serveur d'application |
| Maven | - | Gestion des dépendances |

---

## Routes de l'application

| URL | Méthode | Description |
|---|---|---|
| `/` | GET | Page d'accueil (dashboard) |
| `/vente-servlet/list` | GET | Liste des ventes |
| `/vente-servlet/show?idVente={id}` | GET | Détail d'une vente |
| `/vente-servlet/add` | GET / POST | Formulaire + traitement ajout vente |
| `/vente-servlet/edit?idVente={id}` | GET / POST | Formulaire + traitement modification |
| `/cheval-servlet/list` | GET | Liste des chevaux |
| `/cheval-servlet/show?idCheval={id}` | GET | Fiche détaillée d'un cheval |
| `/cheval-servlet/add` | GET / POST | Formulaire + traitement ajout cheval |
| `/enchere-servlet/ajouter` | POST | Enregistrement d'une enchère |

---

## Auteur

**Maxime Leu** — BTS SIO — Épreuve E6  
GitHub : [@Maxime-Leu](https://github.com/Maxime-Leu)
