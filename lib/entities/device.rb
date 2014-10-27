require_relative './base'

module OnOff
  module API
    module Entities
      class Device < Base
        expose :id, :title, :device_group_id
      end
    end
  end
end