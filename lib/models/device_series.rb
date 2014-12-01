require_relative './base'

require_relative './device'
require_relative './series'

require_relative './device_series_sku'

require_relative '../entities/device_series'

module OnOff
  module API
    module Models
      class DeviceSeries < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true

        belongs_to  :device,              required: true
        belongs_to  :series,              'Series', required: true
        has n,      :device_series_skus,  'DeviceSeriesSKU', constraint: :destroy

        timestamps :at

        Entity = Entities::DeviceSeries
      end
    end
  end
end