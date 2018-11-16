CREATE TABLE client (
  NUMCLI       int  primary key,
  NOM          varchar(80),
  PRENOM       varchar(80),
  DATENAISS    date,
  RUE          varchar(120),
  CP           int,
  VILLE        varchar(80)
);

CREATE TABLE fournisseur (
  NUMFOUR      int primary key,
  RAISONSOC    varchar(80)
);

CREATE TABLE produit (
  NUMPROD      int primary key,
  DESI         varchar(120),
  PRIXUNI      real,
  NUMFOUR      int references fournisseur(NUMFOUR)
);

CREATE TABLE commande (
  NUMCLI       int references client(NUMCLI),
  NUMPROD      int references produit(NUMPROD),
  QUANTITE     int,
  DATEC        date
);
