require 'pry'

Dir["#{File.dirname(__FILE__) }/models/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__) }/entities/*.rb"].each { |file| require file }

require_relative './routes/main'