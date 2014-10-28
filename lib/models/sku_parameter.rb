require_relative './device_series_sku'
require_relative './sku_value'

require_relative '../entities/sku_parameter'

module OnOff
  module API
    module Models
      class SKUParameter < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true

        belongs_to :device_series_sku, 'DeviceSeriesSKU', required: true
        belongs_to :parameter, required: true

        has n, :sku_values, 'SKUValue', constraint: :destroy

        timestamps :at

        Entity = Entities::SKUParameter
      end
    end
  end
end