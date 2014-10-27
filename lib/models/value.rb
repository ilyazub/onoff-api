require_relative './parameter'

require_relative '../entities/value'

module OnOff
  module API
    module Models
      class Value < Base
        include DataMapper::Resource

        property :parameter_id, Integer, key: true, unique_index: :parameter_code, required: true
        property :code, String, key: true, unique_index: :parameter_code, required: true

        property :description, String, required: true
        property :unit_price, Float, required: true, default: 0.0
        property :selected, Boolean, required: true, default: false

        belongs_to :parameter

        timestamps :at

        Entity = Entities::Value

        validates_uniqueness_of :code, scope: :parameter_id, message: "There's already a value of that code in this parameter"
      end
    end
  end
end