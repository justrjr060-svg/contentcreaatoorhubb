-- Creator profiles published by users of the platform.
CREATE TABLE creators (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL DEFAULT 'Creator',
  bio TEXT NOT NULL DEFAULT '',
  twitter TEXT NOT NULL DEFAULT '',
  instagram TEXT NOT NULL DEFAULT '',
  tiktok TEXT NOT NULL DEFAULT '',
  website TEXT NOT NULL DEFAULT '',
  created_at TIMESTAMP DEFAULT NOW()
);
