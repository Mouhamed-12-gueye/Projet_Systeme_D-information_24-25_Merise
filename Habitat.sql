
-- Table : Client
CREATE TABLE Client (
    CodeClient      CHAR(15)     PRIMARY KEY,
    Nom             VARCHAR(50)  NOT NULL,
    Prenom          VARCHAR(50)  NOT NULL,
    Adresse         VARCHAR(100) NOT NULL,
    Contact         VARCHAR(20)  NOT NULL
);

-- Table : Employe
CREATE TABLE Employe (
    Code_Emp        CHAR(15)     PRIMARY KEY,
    Nom_EMP         VARCHAR(50)  NOT NULL,
    Prenom_EMP      VARCHAR(50)  NOT NULL,
    Adresse         VARCHAR(100) NOT NULL,
    Contact         VARCHAR(20)  NOT NULL,
    Fonction        VARCHAR(30)  NOT NULL
);

-- Table : Demande
CREATE TABLE Demande (
    Code_Demande    CHAR(20)     PRIMARY KEY,
    Date_Demande    DATE         NOT NULL,
    Description     TEXT         NOT NULL,
    Statut          VARCHAR(20)  NOT NULL,
    CodeClient      CHAR(15)     NOT NULL,
    Code_Emp        CHAR(15)     NOT NULL
);

-- Table : Projet
CREATE TABLE Projet (
    Code_Projet         CHAR(20)     PRIMARY KEY,
    Description_projet  TEXT         NOT NULL,
    DateCreation        DATE         NOT NULL,
    Statut              VARCHAR(20)  NOT NULL
);

-- Table : Devis
CREATE TABLE Devis (
    Code_devis      CHAR(20)     PRIMARY KEY,
    Montant         DECIMAL(12,2) NOT NULL,
    DateAdmission   DATE         NOT NULL,
    DateValidation  DATE,
    Statut          VARCHAR(20)  NOT NULL,
    Code_Projet     CHAR(20)     NOT NULL
);

-- Table : Sous_Traitants
CREATE TABLE Sous_Traitants (
    Code_ST     CHAR(20)     PRIMARY KEY,
    Nom_ST      VARCHAR(50)  NOT NULL,
    Prenom_ST   VARCHAR(50)  NOT NULL,
    Specialite  VARCHAR(50)  NOT NULL
);

-- Table : Mission
CREATE TABLE Mission (
    Code_Mission        CHAR(20)     PRIMARY KEY,
    Nombre_Personne     INTEGER      NOT NULL,
    Code_Projet         CHAR(20)     NOT NULL,
    Code_ST             CHAR(20)     NOT NULL
);

-- Table : Vendeur
CREATE TABLE Vendeur (
    Code_Vendeur    CHAR(15)     PRIMARY KEY,
    Nom_Vendeur     VARCHAR(50)  NOT NULL,
    Prenom          VARCHAR(50)  NOT NULL,
    Adresse         TEXT         NOT NULL
);

-- Table : Terrain
CREATE TABLE Terrain (
    Code_Terrain    CHAR(20)      PRIMARY KEY,
    Adresse         TEXT          NOT NULL,
    Superficie      DECIMAL(10,2) NOT NULL,
    Prix            DECIMAL(12,2) NOT NULL,
    Ville           VARCHAR(50)   NOT NULL,
    Code_Vendeur    CHAR(15)      NOT NULL
);

-- =========================
-- SECTION 3 : Contraintes d'intégrité référentielles (Clés étrangères)
-- =========================

ALTER TABLE Demande
    ADD CONSTRAINT FK_Demande_Client
        FOREIGN KEY (CodeClient) REFERENCES Client(CodeClient),
    ADD CONSTRAINT FK_Demande_Employe
        FOREIGN KEY (Code_Emp) REFERENCES Employe(Code_Emp);

ALTER TABLE Devis
    ADD CONSTRAINT FK_Devis_Projet
        FOREIGN KEY (Code_Projet) REFERENCES Projet(Code_Projet);

ALTER TABLE Mission
    ADD CONSTRAINT FK_Mission_Projet
        FOREIGN KEY (Code_Projet) REFERENCES Projet(Code_Projet),
    ADD CONSTRAINT FK_Mission_SousTraitant
        FOREIGN KEY (Code_ST) REFERENCES Sous_Traitants(Code_ST);

ALTER TABLE Terrain
    ADD CONSTRAINT FK_Terrain_Vendeur
        FOREIGN KEY (Code_Vendeur) REFERENCES Vendeur(Code_Vendeur);

-- ========================
-- SECTION 4 : Index pour optimisation des requêtes
-- ========================

CREATE INDEX IX_Client_Nom           ON Client(Nom);
CREATE INDEX IX_Employe_Fonction     ON Employe(Fonction);
CREATE INDEX IX_Demande_Statut       ON Demande(Statut);
CREATE INDEX IX_Devis_Statut         ON Devis(Statut);
CREATE INDEX IX_Projet_DateCreation  ON Projet(DateCreation);
CREATE INDEX IX_Terrain_Ville        ON Terrain(Ville);
