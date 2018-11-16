INSERT INTO client (NUMCLI, NOM, PRENOM, DATENAISS, RUE, CP, VILLE) VALUES
  (1, 'Dupont', 'Albert', '1970-06-01', 'Rue de Crimee', 69001, 'Lyon'),
  (2, 'West', 'James', '1963-09-03', 'Studio', 0, 'Hollywood'),
  (3, 'Martin', 'Marie', '1978-06-05', 'Rue des Acacias', 69130, 'Ecully'),
  (4, 'Durand', 'Gaston', '1980-11-15', 'Rue de la Meuse', 69008, 'Lyon'),
  (5, 'Titgoutte', 'Justine', '1975-02-28', 'Chemin du Chateau', 69630, 'Chaponost'),
  (6, 'Dupond', 'Noemie', '1957-09-18', 'Rue de Dole', 69007, 'Lyon')
;

INSERT INTO fournisseur (NUMFOUR, RAISONSOC) VALUES
  (11, 'Top Jouet'),
  (12, 'Mega Fringue'),
  (13, 'Madame Meuble'),
  (14, 'Tout le Sport')
;

INSERT INTO produit (NUMPROD, DESI, PRIXUNI, NUMFOUR) VALUES
  (101, 'Soldat qui tire', 50.00, 11),
  (102, 'Cochon qui rit', 50.00, 11),
  (103, 'Poupée qui pleure', 100.00, 11),

  (104, 'Jeans', 250.00, 12),
  (105, 'Blouson', 350.00, 12),
  (106, 'Chaussures', 200.00, 12),
  (107, 'T-shirt', 100.00, 12),

  (108, 'Table', 500.00, 13),
  (109, 'Chaise', 100.00, 13),
  (110, 'Armoire', 1000.00, 13),
  (111, 'Lit', 5000.00, 13),

  (112, 'Raquette de tennis', 300.00, 14),
  (113, 'VTT', 699.00, 14),
  (114, 'Ballon', 75.00, 14)
;

INSERT INTO commande (NUMCLI, NUMPROD, QUANTITE, DATEC) VALUES
  (1, 110, 1, '1999-09-24'),
  (1, 108, 1, '1999-09-24'),
  (1, 109, 4, '1999-09-24'),

  (3, 101, 2, '1999-09-24'),
  (3, 102, 1, '1999-09-24'),

  (4, 104, 3, '1999-09-24'),
  (4, 105, 1, '1999-09-24'),
  (4, 106, 2, '1999-09-24'),
  (4, 107, 5, '1999-09-24'),

  (5, 114, 10, '1999-09-24'),

  (6, 102, 2, '1999-09-24'),
  (6, 103, 5, '1999-09-24'),
  (6, 114, NULL, '1999-09-24')
;
