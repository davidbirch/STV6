
LEGACY_DB = YAML.load_file(File.join(Rails.root, "config", "legacy_database.yml"))[Rails.env.to_s]  