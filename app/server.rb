require 'rubygems'
require 'bundler/setup'
require 'grape'
require 'grape-entity'
require 'active_record'
require 'yaml'

# Require all application classes
Dir[File.dirname(__FILE__) + '/**/*.rb'].each {|f| require f}

ENVIRONMENT = ENV['RACK_ENV'] || 'development'

ActiveRecord::Base.establish_connection(
  YAML.load_file('config/database.yml')[ENVIRONMENT]
)
