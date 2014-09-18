require_relative './base'

module OnOff
  module API
    module Entities
      class DeviceGroup < Base
        expose :title
      end
    end
  end
end