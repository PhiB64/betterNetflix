
-- Top 10 des contenus les plus vus par pays
SELECT u.country, c.title, COUNT(*) AS nb_vues
FROM historique_vue hv
JOIN "user" u ON hv.user_id = u.id
JOIN content c ON hv.content_id = c.id
GROUP BY u.country, c.title
ORDER BY u.country, nb_vues DESC
LIMIT 10;

-- Liste des séries dont la moyenne de progression des utilisateurs > 80 %
SELECT s.content_id, c.title, AVG(hv.progression) AS avg_progression
FROM serie s
JOIN content c ON s.content_id = c.id
JOIN historique_vue hv ON hv.content_id = s.content_id
GROUP BY s.content_id, c.title
HAVING AVG(hv.progression) > 80;

-- Affichage de la hiérarchie complète des tags (CTE récursif)
WITH RECURSIVE tag_hierarchy AS (
	SELECT id, nom, parent_id, 1 AS niveau
	FROM tag
	WHERE parent_id IS NULL
	UNION ALL
	SELECT t.id, t.nom, t.parent_id, th.niveau + 1
	FROM tag t
	JOIN tag_hierarchy th ON t.parent_id = th.id
)
SELECT * FROM tag_hierarchy ORDER BY niveau, nom;

-- Recommander à un utilisateur les contenus d’un acteur qu’il regarde le plus (user1)

WITH fav_acteur AS (
	SELECT fa.acteur_id, COUNT(*) AS vues
	FROM historique_vue hv
	JOIN film_acteur fa ON hv.content_id = fa.film_id
	WHERE hv.user_id = 1
	GROUP BY fa.acteur_id
	ORDER BY vues DESC
	LIMIT 1
)
SELECT c.title
FROM film_acteur fa
JOIN content c ON fa.film_id = c.id
WHERE fa.acteur_id = (SELECT acteur_id FROM fav_acteur);

-- Films du même réalisateur que le dernier film vu par un utilisateur (user1)

WITH last_film AS (
	SELECT hv.content_id
	FROM historique_vue hv
	JOIN film f ON hv.content_id = f.content_id
	WHERE hv.user_id = 1
	ORDER BY hv.date_vue DESC
	LIMIT 1
),
realisateur AS (
	SELECT fr.realisateur_id
	FROM film_realisateur fr
	WHERE fr.film_id = (SELECT content_id FROM last_film)
)
SELECT c.title
FROM film_realisateur fr
JOIN content c ON fr.film_id = c.id
WHERE fr.realisateur_id = (SELECT realisateur_id FROM realisateur)
	AND fr.film_id <> (SELECT content_id FROM last_film);

-- Abonnements possédant l’option “UHD” (requête JSONB)
SELECT * FROM plan WHERE advantages ->> 'qualite' = 'UHD';

