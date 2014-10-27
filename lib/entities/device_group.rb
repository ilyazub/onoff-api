require_relative './base'

module OnOff
  module API
    module Entities
      class DeviceGroup < Base
        expose :id, :title
      end
    end
  end
end