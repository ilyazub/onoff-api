require_relative './parameter'

require_relative '../entities/value'

module OnOff
  module API
    module Models
      class Value < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :code, String, required: true
        property :description, String, required: true

        belongs_to :parameter, 'Parameter'

        timestamps :at

        Entity = Entities::Value
      end
    end
  end
end