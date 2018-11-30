CREATE TABLE personnel (
  NOM    varchar(20) primary key,
  ROLE   varchar(20)
);

CREATE TABLE numero (
  TITRE        varchar(30)  primary key,
  NATURE       varchar(20),
  RESPONSABLE  varchar(20)
);


CREATE TABLE accessoire (
  NOM          varchar(30) primary key,
  COULEUR      numeric(5,2),
  RATELIER     numeric(2),
  CAMION       numeric(1)
);

CREATE TABLE utilisation (
  TITRE        varchar(30) references numero(TITRE),
  UTILISATEUR  varchar(20) references personnel(NOM),
  ACCESSOIRE   varchar(30) references accessoire(NOM),
  primary key(UTILISATEUR, TITRE, ACCESSOIRE)
);

ALTER TABLE numero ADD CONSTRAINT resp_fk FOREIGN KEY (RESPONSABLE) REFERENCES personnel(NOM);
