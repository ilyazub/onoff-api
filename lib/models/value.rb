require_relative './parameter'
require_relative './sku_value'

require_relative '../entities/value'

module OnOff
  module API
    module Models
      class Value < Base
        include DataMapper::Resource

        property :id,           Serial,   key: true, required: true
        property :parameter_id, Integer,  required: true
        property :code,         String,   required: true
        property :description,  String,   required: true
        property :selected,     Boolean,  default: false, required: true
        property :image_url,    String

        belongs_to  :parameter,   required: true
        has n,      :sku_values,  'SKUValue', constraint: :destroy

        timestamps :at

        Entity = Entities::Value
      end
    end
  end
end