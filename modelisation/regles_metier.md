# Règles métier – BetterNetflix

## Content
- Chaque contenu (film, série, épisode, live) possède un identifiant unique, un titre, une description, un pays de production, une date de sortie et des métadonnées (JSONB).
- Le type de contenu est obligatoirement l’un des suivants : film, serie, episode, live.

## Film
- Un film est un contenu de type "film".
- Un film possède une classification d’âge et un budget.

## Série
- Une série est un contenu de type "serie".
- Une série possède un nombre de saisons.

## Épisode
- Un épisode est un contenu de type "episode".
- Un épisode appartient obligatoirement à une série (clé étrangère non nulle).
- Un épisode possède un numéro de saison et un numéro d’épisode.

## Live stream
- Un live stream est un contenu de type "live".
- Un live stream est lié à un créateur indépendant.
- Un live stream ne possède pas de durée.

## Personne
- Chaque personne (acteur, réalisateur, créateur) possède un identifiant, un nom, une date de naissance et une biographie.
- Un acteur ou réalisateur peut participer à plusieurs films, séries ou épisodes (relations n-n via tables de liaison).

## Utilisateur
- Chaque utilisateur possède un email unique, un pays, un plan d’abonnement et une date d’inscription.
- Un utilisateur ne peut avoir qu’un seul plan actif à la fois.

## Plan
- Chaque plan possède un nom, un prix et des avantages (JSONB).
- Les avantages peuvent inclure la qualité, le nombre de profils, des options (offline, kids_mode…).

## Tag
- Les tags sont hiérarchiques : un tag peut avoir un parent (ou être racine).
- Un contenu peut avoir plusieurs tags (relation n-n).

## Historique de visionnage
- Un historique est créé à chaque visionnage de contenu par un utilisateur.
- La progression est comprise entre 0 et 100 %.
- Un utilisateur peut avoir plusieurs historiques pour différents contenus.

## Recommandation
- Les recommandations sont personnalisées par utilisateur et contenu.
- Le score d’algorithme est un nombre réel.
- La raison de la recommandation est stockée en JSONB.

## Contraintes générales
- La date de sortie d’un contenu ne peut pas être dans le futur.
- Les emails utilisateurs sont uniques.
- Les clés étrangères doivent toujours référencer des entités existantes.
- Les tables de liaison assurent l’intégrité des relations n-n.
