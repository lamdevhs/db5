/*
CREATE SEQUENCE dept_seq MINVALUE 1 INCREMENT 1;

INSERT INTO departement VALUES (NEXTVAL('dept_seq'), 'ISIS'), (NEXTVAL('dept_seq'), 'INFO'), (NEXTVAL('dept_seq'), 'SQL');

SELECT * FROM departement;

*/
\echo Question 4
CREATE VIEW reserv_par_enseignant (id, enseignant, nb_de_reservations) AS
	SELECT E.enseignant_id, E.nom, COUNT(*)
	FROM Enseignant E, Reservation R
	WHERE E.enseignant_id = R.enseignant_id
	GROUP BY E.enseignant_id;

SELECT * FROM reserv_par_enseignant;

\echo Question 5
SELECT * FROM reserv_par_enseignant
WHERE nb_de_reservations >= ALL (SELECT nb_de_reservations FROM reserv_par_enseignant);

\echo Question 6
SELECT nom, prenom FROM Enseignant
WHERE enseignant_id NOT IN (SELECT id FROM reserv_par_enseignant);


\echo Question 7
CREATE VIEW info_enseignant (matricule, nom, prenom, email) AS
	SELECT enseignant_id, nom, prenom, email
	FROM Enseignant;

SELECT * FROM info_enseignant;

\echo Question 8
CREATE OR REPLACE RULE update_info_enseignant AS ON UPDATE
TO info_enseignant DO INSTEAD
	UPDATE Enseignant SET email = NEW.email WHERE enseignant_id = NEW.matricule;

UPDATE info_enseignant SET email = 'elyes.lamine@gmail.com'
	WHERE nom = 'Lamine';

SELECT * FROM info_enseignant;
SELECT * FROM Enseignant;

\echo Question 9
CREATE OR REPLACE RULE insert_info_enseignant AS ON INSERT
TO info_enseignant DO INSTEAD
	INSERT INTO Enseignant (enseignant_id, departement_id, nom, prenom, grade, telephone,
		fax, email)
	VALUES (NEW.matricule, '1', NEW.nom, NEW.prenom, NULL, NULL, NULL, NEW.email);

INSERT INTO info_enseignant (matricule, nom, prenom, email)
	VALUES (42, 'Bidule', 'True', 'super@coolprof.com');

SELECT * FROM Enseignant;

\echo Question 10
CREATE OR REPLACE FUNCTION GetSalleCapaciteSuperieurA (arg_capacite int)
RETURNS SETOF Salle AS $$
DECLARE
	maSalle Salle%ROWTYPE;
BEGIN
	FOR maSalle in (SELECT * FROM Salle WHERE Capacite >= arg_capacite) LOOP
		RETURN NEXT maSalle;
	END LOOP ;
END; $$ LANGUAGE 'plpgsql';

select * from GetSalleCapaciteSuperieurA(30);

\echo Question 11
CREATE OR REPLACE FUNCTION GetDepartement_ID (arg_nomdept varchar)
RETURNS int AS $$
DECLARE
   row departement%ROWTYPE;
BEGIN
	FOR row in (SELECT * FROM departement WHERE nom_departement = arg_nomdept) LOOP
		RETURN row.departement_id;
		-- retourne le premier, s'il y en a plus d'un, ce qui ne devrait pas arriver
	END LOOP ;
END; $$ LANGUAGE 'plpgsql';

select E.nom, E.prenom from departement D, enseignant E
	WHERE D.departement_id = E.departement_id
	AND D.departement_id = GetDepartement_ID('ISIS');

\echo Question 12
CREATE OR REPLACE FUNCTION SonDepartement (int)
RETURNS varchar AS $$
	SELECT nom_departement
	FROM Departement D, Enseignant E
	WHERE E.enseignant_id = $1
	AND D.departement_id = E.departement_id
$$ LANGUAGE SQL;

select * from SonDepartement(5);

\echo Question 13
CREATE OR REPLACE FUNCTION MoyCapacite ()
RETURNS real AS $$
DECLARE
   sum_cap real := 0;
   nb_salles real := 0;
   row Salle%ROWTYPE;
BEGIN
	FOR row in (SELECT * FROM Salle) LOOP
		sum_cap := sum_cap + row.capacite;
		nb_salles := nb_salles + 1;
		-- retourne le premier, s'il y en a plus d'un, ce qui ne devrait pas arriver
	END LOOP ;
	IF NOT FOUND THEN
		RETURN 0;
	ELSE
		RETURN sum_cap / nb_salles;
	END IF;
END; $$ LANGUAGE 'plpgsql';

select * from MoyCapacite();

\echo Question 14
SELECT * FROM Salle WHERE Capacite >= MoyCapacite();
select * from GetSalleCapaciteSuperieurA (MoyCapacite()::INT);



\echo Question 15
SELECT * FROM Salle WHERE Capacite BETWEEN MoyCapacite()*0.85 AND MoyCapacite()*1.15 ;
SELECT * FROM Salle WHERE Capacite / MoyCapacite() BETWEEN 0.85 AND 1.15 ;

\echo Question 16
CREATE TYPE nom_prenom AS (nom varchar, prenom varchar);
CREATE OR REPLACE FUNCTION Collegues (ensid int)
RETURNS SETOF nom_prenom AS $$
DECLARE
   ensdept int;
   collegue nom_prenom;
   row Enseignant%ROWTYPE;
BEGIN
	FOR row in (SELECT * FROM Enseignant WHERE enseignant_id = ensid LIMIT 1) LOOP
		ensdept = row.departement_id;
	END LOOP;
	FOR row in (SELECT * FROM Enseignant
		  WHERE enseignant_id <> ensid
		  AND departement_id = ensdept)
	LOOP
		collegue.nom = row.nom;
		collegue.prenom = row.prenom;
		RETURN NEXT collegue;
		-- retourne le premier, s'il y en a plus d'un, ce qui ne devrait pas arriver
	END LOOP ;
END; $$ LANGUAGE 'plpgsql';

select * from Collegues(5);

\echo Question 17
DROP FUNCTION NumLignes;
CREATE OR REPLACE FUNCTION NumLignes (TableStr varchar)
RETURNS int AS $$
DECLARE
   res int;
   row RECORD; -- Taable%ROWTYPE;
BEGIN
	EXECUTE 'select COUNT(*) from ' || TableStr || '' INTO res;
	RETURN res;
END; $$ LANGUAGE 'plpgsql';

select * from NumLignes('enseignant');

\echo Question 18
CREATE OR REPLACE FUNCTION trigger_maj()
RETURNS TRIGGER AS $$
BEGIN
	NEW.nom = Upper(NEW.nom);
	RETURN NEW;
END; $$ LANGUAGE 'plpgsql';

CREATE TRIGGER my_trigger_maj BEFORE INSERT ON Enseignant FOR EACH ROW EXECUTE PROCEDURE trigger_maj();

INSERT INTO info_enseignant (matricule, nom, prenom, email)
	VALUES (44, 'Bidule', 'Truc', 'super@coolprof.com');

select * from enseignant;