require 'yaml'

path = Rails.root.join('config','application.yml')
if File.exists? path
  yaml = YAML::load( File.read(path) )
  CONFIG = yaml[Rails.env].deep_symbolize_keys
else
  raise "Missing application config, please create: #{path}"
end

