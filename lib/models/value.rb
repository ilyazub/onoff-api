require_relative './parameter'

require_relative '../entities/value'

module OnOff
  module API
    module Models
      class Value < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true

        property :parameter_id, Integer, required: true, unique_index: :parameter_code
        property :code, String, required: true, unique_index: :parameter_code

        property :description, String, required: true
        property :unit_price, Float, required: true, default: 0.0
        property :selected_by_default, Boolean, required: true, default: false

        belongs_to :parameter, 'Parameter'
        has n, :selected_values, constraint: :destroy

        timestamps :at

        Entity = Entities::Value
      end
    end
  end
end