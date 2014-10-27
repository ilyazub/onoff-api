require_relative './parameter'

require_relative '../entities/value'

module OnOff
  module API
    module Models
      class Value < Base
        include DataMapper::Resource

        belongs_to :parameter, key: true
        property :code, String, key: true, required: true

        property :description, String, required: true
        property :unit_price, Float, required: true, default: 0.0
        property :selected, Boolean, required: true, default: false

        timestamps :at

        Entity = Entities::Value
      end
    end
  end
end