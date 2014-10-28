require_relative './base'
require_relative './device_series_sku'

require_relative '../entities/sku'

module OnOff
  module API
    module Models
      class SKU < Base
        include DataMapper::Resource

        property :id, Serial, required: true, key: true
        property :title, String, required: true, unique: true
        property :unit_price, Float, required: true, default: 0.0

        has n, :device_series_skus, 'DeviceSeriesSKU', constraint: :destroy
        has n, :device_series, 'DeviceSeries', through: :device_series_skus

        has n, :parameters, through: :device_series_skus

        timestamps :at

        Entity = Entities::SKU
      end
    end
  end
end