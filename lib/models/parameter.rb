require_relative './series'
require_relative './sku_parameter'
require_relative './value'
require_relative './selected_value'

require_relative '../entities/parameter'

module OnOff
  module API
    module Models
      class Parameter < Base
        include DataMapper::Resource

        property :id,           Serial, key: true, required: true
        property :series_id,    Integer, required: true
        property :variable,     String, required: true
        property :description,  String, required: true

        belongs_to  :series,          required: true
        has n,      :sku_parameters,  'SKUParameter', constraint: :destroy
        has n,      :values,          constraint: :destroy
        has n,      :selected_values, constraint: :destroy

        timestamps :at

        Entity = Entities::Parameter
      end
    end
  end
end