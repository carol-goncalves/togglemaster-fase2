INSERT INTO api_keys (name, key_hash, is_active)
VALUES (
  'compose-local',
  '0028070c9380cbd5af21250137a9283ade258f4982111e5aafd8c2544f609641',
  true
)
ON CONFLICT (key_hash) DO NOTHING;
