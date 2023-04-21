CREATE TABLE photos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    image TEXT NOT NULL # Это должна быть ссылка
);

CREATE TABLE videos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    video_url TEXT NOT NULL # Это должна быть ссылка
);

CREATE TABLE articles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    content TEXT
);

CREATE TABLE content (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    content_type TEXT NOT NULL CHECK (content_type IN ('photo', 'video', 'article')),
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);
ALTER TABLE content ADD COLUMN photo_id UUID REFERENCES photos(id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE content ADD COLUMN video_id UUID REFERENCES videos(id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE content ADD COLUMN article_id UUID REFERENCES articles(id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE content ADD CONSTRAINT unique_content CHECK (
    (photo_id IS NOT NULL)::integer +
    (video_id IS NOT NULL)::integer +
    (article_id IS NOT NULL)::integer = 1
);

ALTER TABLE photos ADD COLUMN content_id UUID REFERENCES content(id) ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE videos ADD COLUMN content_id UUID REFERENCES content(id) ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE articles ADD COLUMN content_id UUID REFERENCES content(id) ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED;

CREATE TABLE tags (
id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
name VARCHAR(255) NOT NULL,
description TEXT
);

CREATE TABLE categories (
id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
name VARCHAR(255) NOT NULL,
description TEXT
);

CREATE TABLE authors (
id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
first_name VARCHAR(255),
last_name VARCHAR(255),
email VARCHAR(255)
);

CREATE TABLE tag_content (
    id SERIAL PRIMARY KEY,
    tag_id INTEGER REFERENCES tags(id),
    content_id INTEGER REFERENCES content(id)
);
CREATE TABLE categorie_content (
    id SERIAL PRIMARY KEY,
    categorie_id INTEGER REFERENCES categories(id),
    content_id INTEGER REFERENCES content(id)
);
CREATE TABLE author_content (
    id SERIAL PRIMARY KEY,
    author_id INTEGER REFERENCES authorss(id),
    content_id INTEGER REFERENCES content(id)
);