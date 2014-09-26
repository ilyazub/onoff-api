require_relative './base'

module OnOff
  module API
    module Entities
      class DeviceSeries < Base
        expose :device_id, :series_id
        expose :title, :manufacturer, documentation: { type: 'String' }
      end
    end
  end
end