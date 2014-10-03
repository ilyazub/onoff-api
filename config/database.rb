DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, OnOff::API.application.connection_string)

DataMapper.repository(:default).adapter.resource_naming_convention = DataMapper::NamingConventions::Resource::UnderscoredAndPluralizedWithoutModule