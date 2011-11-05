redis = YAML.load(ERB.new(File.read(Rails.root.join('config','redis.yml'))).result)[Rails.env]
REDIS = Redis.new(redis.symbolize_keys)
