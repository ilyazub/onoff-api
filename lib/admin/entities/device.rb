require_relative '../../entities/base'
require_relative './device_range'

module OnOff
  module API
    module Admin
      module Entities
        class Device < OnOff::API::Entities::Base
          expose :id, :code, :title, :index

          expose :device_series, as: :deviceRanges, using: DeviceRange
        end
      end
    end
  end
end