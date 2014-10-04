require_relative './base'

module OnOff
  module API
    module Entities
      class DeviceSeriesParameterValue < Base
        expose :parameter_id

        expose :code, :description, documentation: { type: 'String' }
      end
    end
  end
end