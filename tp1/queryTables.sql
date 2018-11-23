/* test */

\echo :::::::::::: Question 1
SELECT * FROM client;

\echo :::::::::::: Question 15
SELECT DISTINCT nom
FROM client C, commande M
WHERE
	C.numcli = M.numcli	AND
	M.quantite = 1;

\echo :::::::::::: Question 16
SELECT C.numcli, SUM(M.quantite) as Quantite_Totale
FROM client C, commande M
WHERE
	C.numcli = M.numcli
GROUP BY C.numcli
ORDER BY C.numcli ASC;

\echo :::::::::::: Question 17
SELECT P.numprod, AVG(M.quantite) as Quantite_Moyenne
FROM produit P, commande M
WHERE
	P.numprod = M.numprod
GROUP BY P.numprod
HAVING COUNT(*) > 1
ORDER BY P.numprod ASC;

\echo :::::::::::: Question 18
SELECT P.numprod as Produit_Le_Moins_Cher
FROM produit P
WHERE
	P.prixuni <= ALL (SELECT P.prixuni from produit P);

\echo :::::::::::: Question 23
CREATE VIEW Total_Depenses (nom, total) AS
	(SELECT C.nom, SUM(P.prixuni*M.quantite)
	FROM produit P, client C, commande M
	WHERE C.numcli = M.numcli AND P.numprod = M.numprod
	GROUP BY C.numcli);
SELECT * FROM Total_Depenses;


\echo :::::::::::: Question 24
SELECT T.nom FROM Total_Depenses T
  WHERE T.total >= ALL (SELECT T.total FROM Total_Depenses T);