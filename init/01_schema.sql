

DROP TABLE IF EXISTS historique_vue CASCADE;
DROP TABLE IF EXISTS recommandation CASCADE;
DROP TABLE IF EXISTS film_acteur CASCADE;
DROP TABLE IF EXISTS serie_acteur CASCADE;
DROP TABLE IF EXISTS episode_acteur CASCADE;
DROP TABLE IF EXISTS film_realisateur CASCADE;
DROP TABLE IF EXISTS content_tag CASCADE;
DROP TABLE IF EXISTS tag CASCADE;
DROP TABLE IF EXISTS film CASCADE;
DROP TABLE IF EXISTS serie CASCADE;
DROP TABLE IF EXISTS episode CASCADE;
DROP TABLE IF EXISTS livestream CASCADE;
DROP TABLE IF EXISTS content CASCADE;
DROP TABLE IF EXISTS personne CASCADE;
DROP TABLE IF EXISTS "user" CASCADE;
DROP TABLE IF EXISTS plan CASCADE;


CREATE TABLE plan (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	price NUMERIC,
	advantages JSONB
);

CREATE TABLE "user" (
	id SERIAL PRIMARY KEY,
	email VARCHAR(255) UNIQUE NOT NULL,
	country VARCHAR(100),
	plan_id INTEGER REFERENCES plan(id),
	appliance_date DATE
);


CREATE TABLE content (
	id SERIAL PRIMARY KEY,
	type VARCHAR(10) NOT NULL CHECK (type IN ('film', 'serie', 'episode', 'live')),
	title VARCHAR(255) NOT NULL,
	description TEXT,
	country_production VARCHAR(100),
	release_date DATE NOT NULL CHECK (release_date <= CURRENT_DATE),
	meta JSONB
);


CREATE TABLE personne (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	birth_date DATE,
	biography TEXT
);


CREATE TABLE film (
	content_id INTEGER PRIMARY KEY REFERENCES content(id) ON DELETE CASCADE,
	classification_age VARCHAR(10),
	budget NUMERIC
);

CREATE TABLE serie (
	content_id INTEGER PRIMARY KEY REFERENCES content(id) ON DELETE CASCADE,
	nb_seasons INTEGER
);

CREATE TABLE episode (
	content_id INTEGER PRIMARY KEY REFERENCES content(id) ON DELETE CASCADE,
	series_id INTEGER NOT NULL REFERENCES serie(content_id) ON DELETE CASCADE,
	season INTEGER,
	nb_episode INTEGER
);

CREATE TABLE livestream (
	content_id INTEGER PRIMARY KEY REFERENCES content(id) ON DELETE CASCADE,
	date_live TIMESTAMP,
	creator_id INTEGER REFERENCES personne(id)
);


CREATE TABLE tag (
	id SERIAL PRIMARY KEY,
	parent_id INTEGER REFERENCES tag(id),
	nom VARCHAR(100) NOT NULL
);


CREATE TABLE content_tag (
	content_id INTEGER REFERENCES content(id) ON DELETE CASCADE,
	tag_id INTEGER REFERENCES tag(id) ON DELETE CASCADE,
	PRIMARY KEY (content_id, tag_id)
);


CREATE TABLE film_acteur (
	film_id INTEGER REFERENCES film(content_id) ON DELETE CASCADE,
	acteur_id INTEGER REFERENCES personne(id) ON DELETE CASCADE,
	PRIMARY KEY (film_id, acteur_id)
);
CREATE TABLE serie_acteur (
	serie_id INTEGER REFERENCES serie(content_id) ON DELETE CASCADE,
	acteur_id INTEGER REFERENCES personne(id) ON DELETE CASCADE,
	PRIMARY KEY (serie_id, acteur_id)
);
CREATE TABLE episode_acteur (
	episode_id INTEGER REFERENCES episode(content_id) ON DELETE CASCADE,
	acteur_id INTEGER REFERENCES personne(id) ON DELETE CASCADE,
	PRIMARY KEY (episode_id, acteur_id)
);
CREATE TABLE film_realisateur (
	film_id INTEGER REFERENCES film(content_id) ON DELETE CASCADE,
	realisateur_id INTEGER REFERENCES personne(id) ON DELETE CASCADE,
	PRIMARY KEY (film_id, realisateur_id)
);


CREATE TABLE historique_vue (
	user_id INTEGER REFERENCES "user"(id) ON DELETE CASCADE,
	content_id INTEGER REFERENCES content(id) ON DELETE CASCADE,
	date_vue TIMESTAMP,
	progression INTEGER CHECK (progression >= 0 AND progression <= 100),
	PRIMARY KEY (user_id, content_id, date_vue)
);


CREATE TABLE recommandation (
	user_id INTEGER REFERENCES "user"(id) ON DELETE CASCADE,
	content_id INTEGER REFERENCES content(id) ON DELETE CASCADE,
	score_algorithme NUMERIC,
	raison JSONB,
	PRIMARY KEY (user_id, content_id)
);


CREATE INDEX idx_content_meta_gin ON content USING GIN (meta);
CREATE INDEX idx_plan_advantages_gin ON plan USING GIN (advantages);
CREATE INDEX idx_recommandation_raison_gin ON recommandation USING GIN (raison);
