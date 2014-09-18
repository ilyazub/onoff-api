require_relative './base'
require_relative '../entities/device_group'

module OnOff
  module API
    module Models
      class DeviceGroup < Base
        include DataMapper::Resource

        property :id, Serial, required: true
        property :title, String, required: true

        has n, :devices

        timestamps :at

        def entity
          Entities::DeviceGroup.new(self)
        end
      end
    end
  end
end