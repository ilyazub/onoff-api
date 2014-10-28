require_relative './base'

require_relative './device'
require_relative './series'

require_relative './device_series_sku'
require_relative './parameter'
require_relative './tagging'

require_relative '../entities/device_series'

module OnOff
  module API
    module Models
      class DeviceSeries < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true

        belongs_to  :device,              required: true
        belongs_to  :series,              'Series', required: true
        has n,      :parameters
        has n,      :device_series_skus,  'DeviceSeriesSKU', constraint: :destroy
        has n,      :taggings,            constraint: :destroy
        has n,      :tags,                through: :taggings

        timestamps :at

        Entity = Entities::DeviceSeries
      end
    end
  end
end