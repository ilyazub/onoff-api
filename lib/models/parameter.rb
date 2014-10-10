require_relative './device_series_sku'
require_relative './parameter_value'
require_relative './sku_parameter'

require_relative '../entities/parameter'

module OnOff
  module API
    module Models
      class Parameter < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :device_series_id, Integer, required: true, unique_index: :unique_device_series_variable
        property :variable, String, required: true, unique_index: :unique_device_series_variable
        property :description, String, required: true

        belongs_to :device_series

        has n, :values, 'ParameterValue', constraint: :destroy
        has n, :sku_parameters, 'SKUParameter', constraint: :destroy

        timestamps :at

        Entity = Entities::Parameter
      end
    end
  end
end