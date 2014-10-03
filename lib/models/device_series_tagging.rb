require_relative './tag'
require_relative './device_series'

require_relative '../entities/device_series_tagging'

module OnOff
  module API
    module Models
      class DeviceSeriesTagging < Base
        include DataMapper::Resource

        belongs_to :tag, parent_key: [ :title ], key: true
        belongs_to :device_series, key: true

        timestamps :at

        Entity = Entities::DeviceSeriesTagging
      end
    end
  end
end