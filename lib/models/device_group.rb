require_relative './base'
# require_relative './parameter'

require_relative '../entities/device_group'

module OnOff
  module API
    module Models
      class DeviceGroup < Base
        include DataMapper::Resource

        property :id, Serial, required: true
        property :title, String, required: true, unique_index: true

        has n, :devices, constraint: :destroy

        # has n, :parameters, constraint: :destroy

        timestamps :at

        Entity = Entities::DeviceGroup
      end
    end
  end
end