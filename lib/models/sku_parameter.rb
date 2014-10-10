require_relative './device_series_sku'
require_relative './parameter'

require_relative '../entities/sku_parameter'

module OnOff
  module API
    module Models
      class SKUParameter < Base
        include DataMapper::Resource

        belongs_to :device_series_sku, 'DeviceSeriesSKU', key: true
        belongs_to :parameter, key: true

        timestamps :at

        Entity = Entities::SKUParameter
      end
    end
  end
end