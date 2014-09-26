require_relative './base'

module OnOff
  module API
    module Entities
      class Device < Base
        expose :title, documentation: { type: 'String' }
        expose :device_group_id
      end
    end
  end
end