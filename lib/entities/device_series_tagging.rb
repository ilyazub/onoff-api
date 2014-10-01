require_relative './base'
require_relative './tag'
require_relative './device_series'

module OnOff
  module API
    module Entities
      class DeviceSeriesTagging < Base
        expose :tag_id, :device_series_id
      end
    end
  end
end