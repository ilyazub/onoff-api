require 'pry'
require 'data_mapper'
require 'yaml'

require_relative './application'

require_relative '../config/database'

Dir["#{File.dirname(__FILE__)}/models/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__)}/entities/*.rb"].each { |file| require file }

require_relative './routes/main'