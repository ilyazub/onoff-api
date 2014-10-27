require_relative './sku'
require_relative './device_series'
require_relative './parameter'

require_relative '../entities/device_series_sku'

module OnOff
  module API
    module Models
      class DeviceSeriesSKU < Base
        include DataMapper::Resource

        property :id, Serial, required: true, key: true
        property :amount, Integer, required: true, default: 1
        property :layer, Integer, required: true, default: 1

        belongs_to :sku, 'SKU', required: true
        belongs_to :device_series, required: true

        has n, :parameters, constraint: :destroy
        has n, :values, through: :parameters

        timestamps :at

        Entity = Entities::DeviceSeriesSKU
      end
    end
  end
end