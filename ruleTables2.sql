/*
CREATE RULE res_numero_rule AS
  ON UPDATE TO res_numero
  DO INSTEAD UPDATE numero
  	SET RESPONSABLE = new.RESPONSABLE
  	WHERE TITRE = old.TITRE
;

UPDATE res_numero SET RESPONSABLE = 'Reine de May' WHERE TITRE = 'Les Zoupalas';
*/
CREATE VIEW liste_accessoires_utilises AS
	SELECT
		U.ACCESSOIRE as nom_accessoire, U.TITRE as numero,
		A.CAMION as camion, A.RATELIER as ratelier
	FROM utilisation U, accessoire A
	WHERE U.ACCESSOIRE = A.NOM
;
/*
CREATE RULE res_numero_rule AS
  ON UPDATE TO res_numero
  DO INSTEAD UPDATE numero
  	SET RESPONSABLE = new.RESPONSABLE
  	WHERE TITRE = old.TITRE
;

UPDATE res_numero SET RESPONSABLE = 'Reine de May' WHERE TITRE = 'Les Zoupalas';
*/