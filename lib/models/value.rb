require_relative './parameter'
require_relative './sku_value'

require_relative '../entities/value'

module OnOff
  module API
    module Models
      class Value < Base
        include DataMapper::Resource

        property :id,           Serial,   key: true, required: true
        property :parameter_id, Integer,  unique_index: :parameter_code, required: true
        property :code,         String,   unique_index: :parameter_code, required: true
        property :description,  String,   required: true
        property :selected,     Boolean,  default: false, required: true

        belongs_to  :parameter,   required: true
        has n,      :sku_values,  'SKUValue', constraint: :destroy

        timestamps :at

        Entity = Entities::Value

        validates_uniqueness_of :code, scope: :parameter_id, message: "There's already a value of that code in this parameter"
      end
    end
  end
end