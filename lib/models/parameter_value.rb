require_relative './parameter'

require_relative '../entities/parameter_value'

module OnOff
  module API
    module Models
      class ParameterValue < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :code, String, required: true
        property :description, String, required: true

        belongs_to :parameter, 'Parameter'

        timestamps :at

        Entity = Entities::ParameterValue
      end
    end
  end
end