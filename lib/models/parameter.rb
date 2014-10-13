require_relative './device_series_sku'
require_relative './value'

require_relative '../entities/parameter'

module OnOff
  module API
    module Models
      class Parameter < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :device_series_sku_id, Integer, required: true, unique_index: :device_series_sku_parameter_variable
        property :variable, String, required: true, unique_index: :device_series_sku_parameter_variable
        property :description, String, required: true

        belongs_to :device_series_sku, 'DeviceSeriesSKU', key: true

        has n, :values, 'Value', constraint: :destroy

        timestamps :at

        Entity = Entities::Parameter
      end
    end
  end
end