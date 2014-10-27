require_relative './base'
require_relative './device'

require_relative '../entities/device_group'

module OnOff
  module API
    module Models
      class DeviceGroup < Base
        include DataMapper::Resource

        property :id, Serial, required: true
        property :title, String, required: true, unique: true

        has n, :devices, constraint: :destroy

        timestamps :at

        Entity = Entities::DeviceGroup
      end
    end
  end
end