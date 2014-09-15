require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, 'postgres://onoff:onoff@localhost:5432/onoff_development')

DataMapper.repository(:default).adapter.resource_naming_convention = DataMapper::NamingConventions::Resource::UnderscoredAndPluralizedWithoutModule