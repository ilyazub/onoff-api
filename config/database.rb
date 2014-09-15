require 'data_mapper'

# If you want the logs displayed you have to do this before the call to setup
DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, 'postgres://onoff:onoff@localhost:5432/onoff_development')

DataMapper.repository(:default).adapter.resource_naming_convention = DataMapper::NamingConventions::Resource::UnderscoredAndPluralizedWithoutModule