


INSERT INTO plan (name, price, advantages) VALUES
  ('Basic', 7.99, '{"qualite": "HD", "profils": 1, "features": ["offline"]}'),
  ('Premium', 13.99, '{"qualite": "UHD", "profils": 4, "features": ["offline", "kids_mode"]}'),
  ('Creator+', 19.99, '{"qualite": "UHD", "profils": 6, "features": ["offline", "kids_mode", "live"]}');


INSERT INTO "user" (email, country, plan_id, appliance_date) VALUES
  ('alice@mail.com', 'FR', 1, '2023-01-10'),
  ('bob@mail.com', 'US', 2, '2023-02-15'),
  ('carla@mail.com', 'DE', 2, '2023-03-20'),
  ('dan@mail.com', 'FR', 3, '2023-04-05');


INSERT INTO personne (name, birth_date, biography) VALUES
  ('Jean Dupont', '1980-05-12', 'Acteur français.'),
  ('Anna Schmidt', '1975-09-23', 'Réalisatrice allemande.'),
  ('John Smith', '1990-11-02', 'Acteur américain.'),
  ('Sophie Martin', '1988-07-30', 'Actrice française.');


INSERT INTO content (type, title, description, country_production, release_date, meta) VALUES
  ('film', 'Le Grand Voyage', 'Un road trip initiatique.', 'FR', '2022-12-01', '{"langues": ["fr", "en"], "duree": 120}'),
  ('serie', 'CyberDetectives', 'Enquêteurs du futur.', 'US', '2021-09-15', '{"langues": ["en"], "saisons": 2}'),
  ('episode', 'CyberDetectives S1E1', 'Premier épisode.', 'US', '2021-09-15', '{"saison": 1, "numero": 1, "duree": 45}'),
  ('live', 'Live Coding avec Alice', 'Session live de code.', 'FR', '2023-05-10', '{"theme": "programmation"}');


INSERT INTO film (content_id, classification_age, budget) VALUES
  (1, '12', 5000000);


INSERT INTO serie (content_id, nb_seasons) VALUES
  (2, 2);

INSERT INTO episode (content_id, series_id, season, nb_episode) VALUES
  (3, 2, 1, 1);


INSERT INTO livestream (content_id, date_live, creator_id) VALUES
  (4, '2023-05-10 20:00:00', 4);


INSERT INTO tag (nom) VALUES
  ('Aventure'), ('Science-Fiction'), ('Famille'), ('Action'), ('Comédie');


INSERT INTO content_tag (content_id, tag_id) VALUES
  (1, 1), (2, 2), (3, 2), (4, 5);


INSERT INTO film_acteur (film_id, acteur_id) VALUES (1, 1), (1, 3);
INSERT INTO film_realisateur (film_id, realisateur_id) VALUES (1, 2);
INSERT INTO serie_acteur (serie_id, acteur_id) VALUES (2, 3);
INSERT INTO episode_acteur (episode_id, acteur_id) VALUES (3, 3);


INSERT INTO historique_vue (user_id, content_id, date_vue, progression) VALUES
  (1, 1, '2023-12-01 21:00:00', 100),
  (2, 2, '2023-12-02 20:00:00', 80),
  (3, 3, '2023-12-03 19:00:00', 90);

INSERT INTO recommandation (user_id, content_id, score_algorithme, raison) VALUES
  (1, 2, 0.95, '{"motif": "basé sur vos vues"}'),
  (2, 1, 0.88, '{"motif": "acteur préféré"}');
