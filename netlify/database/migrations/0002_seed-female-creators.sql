-- Seed four featured female creator profiles so the directory is not empty.
-- Guarded so the seed is only inserted when no rows with these names exist yet.
INSERT INTO creators (name, category, bio, twitter, instagram, tiktok, website)
SELECT * FROM (VALUES
  (
    'Sofia Martinez',
    'Photographer',
    'Portrait and editorial photographer blending natural light with bold color. Open to brand shoots and creative collaborations.',
    'sofiashoots',
    'sofia.martinez',
    'sofiashoots',
    'https://sofiamartinez.example'
  ),
  (
    'Aisha Khan',
    'Designer',
    'Brand and digital designer crafting clean identities and playful illustration systems for indie founders.',
    'aishadesigns',
    'aisha.makes',
    'aishadesigns',
    'https://aishakhan.example'
  ),
  (
    'Emma Chen',
    'Videographer',
    'Short-form video creator and editor. I turn ideas into scroll-stopping reels and documentary-style brand films.',
    'emmacreates',
    'emma.chen.films',
    'emmacreates',
    'https://emmachen.example'
  ),
  (
    'Olivia Bennett',
    'Artist',
    'Illustrator and digital artist working in dreamy, hand-drawn worlds. Available for commissions and album art.',
    'oliviadraws',
    'olivia.bennett.art',
    'oliviadraws',
    'https://oliviabennett.example'
  )
) AS seed(name, category, bio, twitter, instagram, tiktok, website)
WHERE NOT EXISTS (
  SELECT 1 FROM creators WHERE creators.name = seed.name
);
