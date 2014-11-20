require_relative '../../entities/base'
require_relative './device'

module OnOff
  module API
    module Admin
      module Entities
        class DeviceGroup < OnOff::API::Entities::Base
          expose :id, :title

          expose :devices, using: Device
        end
      end
    end
  end
end