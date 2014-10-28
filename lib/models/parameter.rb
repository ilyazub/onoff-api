require_relative './device_series_sku'
require_relative './value'

require_relative '../entities/parameter'

module OnOff
  module API
    module Models
      class Parameter < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true

        property :device_series_sku_id, Integer, unique_index: :device_series_sku_parameter, required: true
        property :variable, String, unique_index: :device_series_sku_parameter, required: true
        property :description, String, required: true

        belongs_to :device_series_sku, 'DeviceSeriesSKU', required: true
        has n, :skus, 'SKU', through: :device_series_sku

        has n, :values, constraint: :destroy

        timestamps :at

        validates_uniqueness_of :variable, scope: :device_series_sku_id, message: "There's already a parameter of that variable in this device series SKU"

        Entity = Entities::Parameter

        def min_price
          selected_value = values.detect { |value| value.selected }
          selected_value.unit_price
        end
      end
    end
  end
end