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

        has n, :device_series_skus, 'DeviceSeriesSKU', constraint: :destroy

        timestamps :at

        Entity = Entities::SKU
      end
    end
  end
end