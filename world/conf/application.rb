APP_CONFIG = YAML.safe_load(
  File.read(File.expand_path('application.yml', File.dirname(__FILE__)))
).freeze

SERVER_CONFIG = APP_CONFIG['server'].freeze