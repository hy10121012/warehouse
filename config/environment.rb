# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Warehouse::Application.initialize!


ENV['RAILS_ENV'] ||= 'developmenrt'