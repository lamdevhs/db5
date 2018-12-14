/*
CREATE SEQUENCE dept_seq MINVALUE 1 INCREMENT 1;

INSERT INTO departement VALUES (NEXTVAL('dept_seq'), 'ISIS'), (NEXTVAL('dept_seq'), 'INFO'), (NEXTVAL('dept_seq'), 'SQL');

SELECT * FROM departement;
*/

/*
CREATE VIEW reserv_par_enseignant (id, enseignant, nb_de_reservations) AS
	SELECT E.enseignant_id, E.nom, COUNT(*)
	FROM Enseignant E, Reservation R
	WHERE E.enseignant_id = R.enseignant_id
	GROUP BY E.enseignant_id;

SELECT * FROM reserv_par_enseignant;


SELECT * FROM reserv_par_enseignant
WHERE nb_de_reservations >= ALL (SELECT nb_de_reservations FROM reserv_par_enseignant);

SELECT nom, prenom FROM Enseignant
WHERE enseignant_id NOT IN (SELECT id FROM reserv_par_enseignant);


CREATE VIEW info_enseignant (matricule, nom, prenom, email) AS
	SELECT enseignant_id, nom, prenom, email
	FROM Enseignant;

SELECT * FROM info_enseignant;


CREATE OR REPLACE RULE update_info_enseignant AS ON UPDATE
TO info_enseignant DO INSTEAD
	UPDATE Enseignant SET email = NEW.email WHERE enseignant_id = NEW.matricule;



UPDATE info_enseignant SET email = 'elyes.lamine@gmail.com'
	WHERE nom = 'Lamine';

SELECT * FROM info_enseignant;
SELECT * FROM Enseignant;
*/
CREATE OR REPLACE RULE insert_info_enseignant AS ON UPDATE
TO info_enseignant DO INSTEAD
	INSERT INTO Enseignant (enseignant_id, departement_id, nom, prenom, grade, telephone,
		fax, email)
	VALUES (NEW.matricule, '1', NEW.nom, NEW.prenom, NULL, NULL, NULL, NEW.email);

INSERT INTO info_enseignant (matricule, nom, prenom, email)
	VALUES (42, 'Montaut', 'Thierry', 'tm@coolprof.com');