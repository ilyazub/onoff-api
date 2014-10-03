require_relative './base'

module OnOff
  module API
    module Entities
      class DeviceSeriesOptionValue < Base
        expose :option_id

        expose :code, :description, documentation: { type: 'String' }
      end
    end
  end
end