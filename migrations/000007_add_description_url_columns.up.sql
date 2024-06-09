ALTER TABLE movies
ADD COLUMN description TEXT NOT NULL DEFAULT 'default_description',
ADD COLUMN url TEXT NOT NULL DEFAULT 'default_url';