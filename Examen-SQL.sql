-- Examen-SQL


-- Exercice 1 : Artistes nés avant 1950
-- On filtre la table artistes sur l'année de naissance
SELECT nom, `annéeNaiss`
FROM artiste
WHERE `annéeNaiss` < 1950;




-- Exercice 2 : Titres des films de genre Drame
-- On filtre la table films avec le genre 'Drame'
SELECT titre
FROM film
WHERE genre = 'Drame';


-- Exercice 3 : Rôles joués par Bruce Willis
-- Jointure artiste → rôle pour retrouver ses rôles
SELECT nomRôle
FROM role r
JOIN artiste a ON r.idActeur = a.idArtiste
WHERE a.nom = 'Willis' AND a.prénom = 'Bruce';


-- Exercice 4 : Réalisateur de Memento
-- Jointure film → artiste via idRéalisateur
SELECT a.nom, a.prénom
FROM film f
JOIN artiste a ON f.idRéalisateur = a.idArtiste
WHERE f.titre = 'Memento';


-- Exercice 5 : Notes obtenues par Fargo
-- Jointure notation → film pour récupérer les notes
SELECT note
FROM notation n
JOIN film f ON n.idFilm = f.idFilm
WHERE f.titre = 'Fargo';


-- Exercice 6 : Acteur ayant joué Chewbacca
-- On cherche le nom de l'acteur pour un rôle spécifique




SELECT a.nom, a.prénom
FROM role r
JOIN artiste a ON r.idActeur = a.idArtiste
WHERE r.nomRôle = 'Chewbacca';


-- Exercice 7 : Films où Bruce Willis joue John McClane
-- Double condition : nom de l'acteur et rôle joué
SELECT f.titre
FROM film f
JOIN role r ON f.idFilm = r.idFilm
JOIN artiste a ON r.idActeur = a.idArtiste
WHERE a.nom = 'Willis' AND a.prénom = 'Bruce'
  AND r.nomRôle = 'John McClane';




-- Exercice 8 : Acteurs de Sueurs froides
SELECT a.nom, a.prénom
FROM film f
JOIN role r ON f.idFilm = r.idFilm
JOIN artiste a ON r.idActeur = a.idArtiste
WHERE f.titre = 'Sueurs froides';






-- Exercice 9 : Films notés par l’internaute Prénom0 Nom0
SELECT DISTINCT f.titre
FROM internaute i
JOIN notation n ON n.email = i.email
JOIN film f ON n.idFilm = f.idFilm




WHERE (i.prénom = 'Prénom0' AND i.nom = 'Nom0');








-- Exercice 10 : Films de Tim Burton avec Johnny Depp
-- Double jointure : réalisateur + acteur
SELECT DISTINCT f.titre
FROM film f
JOIN artiste r ON f.idRéalisateur = r.idArtiste
JOIN role ro ON f.idFilm = ro.idFilm
JOIN artiste a ON ro.idActeur = a.idArtiste
WHERE r.nom = 'Burton' AND r.prénom = 'Tim'
  AND a.nom = 'Depp' AND a.prénom = 'Johnny';






-- Exercice 11 : Films avec Woody Allen et ses rôles
SELECT f.titre, r.nomRôle
FROM film f
JOIN role r ON f.idFilm = r.idFilm
JOIN artiste a ON r.idActeur = a.idArtiste
WHERE a.nom = 'Allen' AND a.prénom = 'Woody';


-- Exercice 12 : Metteurs en scène jouant dans leurs propres films
SELECT a.nom, r.nomRôle, f.titre
FROM artiste a
JOIN film f ON f.idRéalisateur = a.idArtiste
JOIN role r ON r.idActeur = a.idArtiste AND r.idFilm = f.idFilm
ORDER BY a.nom, f.titre;




-- Exercice 13 : Films de Tarantino sans sa présence comme acteur
SELECT f.titre
FROM film f
LEFT JOIN role r ON f.idFilm = r.idFilm AND r.idActeur = (
  SELECT idArtiste FROM artiste WHERE nom = 'Tarantino' AND prénom = 'Quentin'
)
WHERE f.idRéalisateur = (
  SELECT idArtiste FROM artiste WHERE nom = 'Tarantino' AND prénom = 'Quentin'
)
AND r.idFilm IS NULL;












-- Exercice 14 : Acteurs n'ayant jamais réalisé
SELECT a.nom, r.nomRôle, f.titre
FROM artiste a
JOIN role r ON a.idArtiste = r.idActeur
JOIN film f ON r.idFilm = f.idFilm
WHERE a.idArtiste NOT IN (
  SELECT DISTINCT idRéalisateur FROM film
);




-- Exercice 15 : Films de Hitchcock sans James Stewart
SELECT f.titre
FROM film f
LEFT JOIN role r ON f.idFilm = r.idFilm AND r.idActeur = 142
WHERE f.idRéalisateur = 138 AND r.idFilm IS NULL;
















-- Exercice 16 : Films où le réalisateur et un acteur ont le même prénom
SELECT f.titre, a.nom AS realisateur, b.nom AS acteur
FROM film f
JOIN artiste a ON f.idRéalisateur = a.idArtiste
JOIN role r ON r.idFilm = f.idFilm
JOIN artiste b ON r.idActeur = b.idArtiste
WHERE a.prénom = b.prénom
  AND a.idArtiste != b.idArtiste;


-- Exercice 17 : Films sans rôle
SELECT titre
FROM film
WHERE idFilm NOT IN (
  SELECT DISTINCT idFilm FROM role
);




-- Exercice 18 : Films non notés par Prénom1 Nom1




SELECT titre
FROM film
WHERE idFilm NOT IN (
  SELECT idFilm FROM notation
  WHERE email = 'prenom1.nom1@example.com'
);


-- Exercice 19 : Acteurs n'ayant jamais réalisé
SELECT nom, prénom
FROM artiste
WHERE idArtiste NOT IN (
  SELECT DISTINCT idRéalisateur FROM film
);




-- Exercice 20 : Moyenne des notes du film Memento
SELECT AVG(note)
FROM notation n
JOIN film f ON n.idFilm = f.idFilm
WHERE f.titre = 'Memento';




-- Exercice 21 : Réalisateurs et nombre de films
SELECT a.idArtiste, a.nom, a.prénom, COUNT(f.idFilm) AS nb_films
FROM artiste a
JOIN film f ON a.idArtiste = f.idRéalisateur
GROUP BY a.idArtiste;




-- Exercice 22 : Réalisateurs ayant fait au moins 2 films
SELECT a.nom, a.prénom
FROM artiste a
JOIN film f ON a.idArtiste = f.idRéalisateur
GROUP BY a.idArtiste
HAVING COUNT(f.idFilm) >= 2;




-- Exercice 23 : Films avec une moyenne des notes > 7
SELECT f.titre
FROM film f
JOIN notation n ON f.idFilm = n.idFilm
GROUP BY f.titre
HAVING AVG(n.note) > 7;






