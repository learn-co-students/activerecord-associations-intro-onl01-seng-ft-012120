require 'bundler/setup'
require "sinatra/activerecord"
Bundler.require

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}