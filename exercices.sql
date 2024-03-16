
--1. Liste des Potions : Numéro, libellé, formule et cONstituant principal. (5 lignes)
SELECT * FROM Potion;

--2. Liste des noms des trophées rapportant 3 points. (2 lignes)
SELECT c.nom_categ FROM categorie c WHERE c.nb_points = 3;

--3. Liste des villages (noms) cONtenant plus de 35 huttes. (4 lignes)
SELECT * FROM village WHERE nb_huttes > 35;

--4. Liste des trophées (numéros) pris en mai / juin 52. (4 lignes)
SELECT * FROM trophee WHERE date_prise between '20520501' AND '20520630';

--5. Noms des habitants commençant par 'a' et cONtenant la lettre 'r'. (3 lignes)
SELECT * FROM habitant WHERE habitant.nom like 'A%' AND habitant.nom like '%r%';

--6. Numéros des habitants ayant bu les Potions numéros 1, 3 ou 4. (8 lignes)
SELECT DISTINCT habitant.num_hab FROM habitant JOIN absorber ON habitant.num_hab = absorber.num_hab WHERE absorber.num_Potion in (1,3,4);

--7. Liste des trophées : numéro, date de prise, nom de la catégorie et nom du preneur. (10lignes)
SELECT num_trophee, date_prise, code_cat, num_resserre FROM trophee;

--8. Nom des habitants qui habitent à Aquilona. (7 lignes)
SELECT habitant.num_hab, habitant.nom, habitant.age, habitant.num_qualite FROM habitant JOIN village ON habitant.num_village = village.num_village WHERE village.nom_village = 'Aquilona';

--9. Nom des habitants ayant pris des trophées de catégorie Bouclier de Légat. (2 lignes)
SELECT habitant.nom FROM habitant JOIN trophee ON habitant.num_hab = trophee.num_preneur JOIN categorie ON trophee.code_cat = categorie.code_cat WHERE categorie.nom_categ = 'Bouclier de Légat';

--10. Liste des Potions (libellés) fabriquées par Panoramix : libellé, formule et cONstituantprincipal. (3 lignes)
SELECT Potion.lib_Potion, Potion.formule, Potion.cONstituant_principal FROM Potion JOIN fabriquer ON Potion.num_Potion = fabriquer.num_Potion JOIN habitant ON fabriquer.num_hab = habitant.num_hab WHERE habitant.nom = 'Panoramix';

--11. Liste des Potions (libellés) absorbées par Homéopatix. (2 lignes)
SELECT DISTINCT p.lib_Potion FROM Potion p JOIN absorber a ON p.num_Potion = a.num_Potion JOIN habitant h ON a.num_hab = h.num_hab WHERE h.nom = 'Homéopatix';

--12. Liste des habitants (noms) ayant absorbé une Potion fabriquée par l'habitant numéro 3. (4 lignes)
SELECT DISTINCT h.nom FROM habitant h JOIN absorber a ON h.num_hab = a.num_hab JOIN fabriquer f ON a.num_Potion = f.num_Potion WHERE f.num_hab = 3;

--13. Liste des habitants (noms) ayant absorbé une Potion fabriquée par Amnésix. (7 lignes)
SELECT DISTINCT h.nom FROM habitant h JOIN absorber a ON h.num_hab = a.num_hab JOIN fabriquer f ON a.num_Potion = f.num_Potion JOIN Potion p ON f.num_Potion = p.num_Potion JOIN habitant h2 ON f.num_hab = h2.num_hab WHERE h2.nom = 'Amnésix';

--14. Nom des habitants dONt la qualité n'est pAS renseignée. (2 lignes)
SELECT nom FROM habitant WHERE num_qualite ISNULL;

--15. Nom des habitants ayant cONsommé la Potion magique n°1 (c'est le libellé de laPotion) en février 52. (3 lignes)
SELECT DISTINCT h.nom FROM habitant h JOIN absorber a ON h.num_hab = a.num_hab JOIN Potion p ON a.num_Potion = p.num_Potion WHERE p.lib_Potion = 'Potion magique n°1' AND a.date_a BETWEEN '20520201' AND '20520228';

--16. Nom et âge des habitants par ordre alphabétique. (22 lignes)
SELECT nom, age  FROM habitant order by nom;

--17. Liste des resserres clASsées de la plus grand à la plus petite : nom de resserre et nom du village. (3 lignes)
SELECT r.nom_resserre, v.nom_village FROM resserre r JOIN village v ON r.num_village = v.num_village order by r.superficie desc;

--***

--18. Nombre d'habitants du village numéro 5. (4)
SELECT COUNT(*) AS nombre_habitnats FROM habitant WHERE num_village =5;

--19. Nombre de points gagnés par Goudurix. (5)
SELECT h.nom, SUM (c.nb_points) AS points FROM habitant h JOIN trophee t ON h.num_hab = t.num_preneur JOIN categorie c ON t.code_cat = c.code_cat WHERE h.nom = 'Goudurix' GROUP BY  h.nom;

--20. Date de première prise de trophée. (03/04/52)
SELECT MIN(date_prise) AS premiere_prise FROM trophee t JOIN habitant h ON t.num_preneur = h.num_hab;

--21. Nombre de louches de Potion magique n°2 (c'est le libellé de la Potion) absorbées. (19)
SELECT SUM (a.quantite) AS nombre_louches FROM Potion p JOIN absorber a ON p.num_Potion = a.num_Potion WHERE p.lib_Potion = 'Potion magique n°2';

--22. Superficie la plus grand. (895)
SELECT MAX(superficie) AS plus_grand_superficie FROM resserre;

--***

--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)
SELECT v.nom_village, COUNT(h.num_hab) AS nombre_habitants FROM village v left JOIN habitant h ON v.num_village = h.num_village GROUP BY v.nom_village;

--24. Nombre de trophées par habitant (6 lignes)
SELECT h.nom, COUNT(t.num_trophee) AS nombre_trophees FROM habitant h inner JOIN trophee t ON h.num_hab = t.num_preneur GROUP BY h.nom;

--25. Moyenne d'âge des habitants par province (nom de province, calcul). (3 lignes)
SELECT p.nom_province, AVG(h.age) AS moyenne_age FROM habitant h JOIN village v ON h.num_village = v.num_village JOIN province p ON v.num_province = p.num_province GROUP BY p.nom_province;

--26. Nombre de Potions différentes absorbées par chaque habitant (nom et nombre). (9lignes)
SELECT h.nom, COUNT(DISTINCT a.num_Potion) AS nombre_Potions_diff FROM habitant h JOIN absorber a ON h.num_hab = a.num_hab GROUP BY h.nom;

--27. Nom des habitants ayant bu plus de 2 louches de Potion zen. (1 ligne)
SELECT h.nom FROM habitant h JOIN absorber a ON h.num_hab = a.num_hab JOIN potion p ON a.num_potion = p.num_potion WHERE p.num_potion = (SELECT num_potion FROM potion WHERE lib_potion = 'Potion Zen') AND a.quantite > 2;

--***
--28. Noms des villages dans lesquels ON trouve une resserre (3 lignes)
SELECT DISTINCT v.nom_village FROM village v JOIN resserre r ON v.num_village = r.num_village;

--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)
SELECT nom_village FROM village ORDER BY nb_huttes desc LIMIT 1;

--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes).
SELECT h.nom, COUNT(t.num_trophee) AS nb_trophees FROM habitant h JOIN trophee t ON h.num_hab = t.num_preneur GROUP BY h.nom HAVING COUNT(t.num_trophee) > (SELECT COUNT(t.num_trophee) FROM habitant h JOIN trophee t ON h.num_hab = t.num_preneur WHERE h.nom = 'Obélix');

