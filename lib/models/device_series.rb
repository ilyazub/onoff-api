require_relative './device'
require_relative './series'
require_relative './manufacturer'

require_relative '../entities/device_series'

module OnOff
  module API
    module Models
      class DeviceSeries < Base
        include DataMapper::Resource

        belongs_to :device, key: true
        belongs_to :series, 'Series', key: true
        belongs_to :manufacturer, key: true

        timestamps :at

        Entity = Entities::DeviceSeries
      end
    end
  end
end