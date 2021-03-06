require 'grape'
require 'pry'
require 'mongoid'
require 'sidekiq'
require 'active_support/all'

Dir["./teamhero/*.rb"].each { |file| require file }
Dir["./teamhero/services/*.rb"].each { |file| require file }
Dir["./teamhero/models/*.rb"].each { |file| require file }
Dir["./teamhero/workers/*.rb"].each { |file| require file }

Mongoid.load!('config/mongoid.yml')
