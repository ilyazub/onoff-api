require_relative '../../entities/base'

module OnOff
  module API
    module Admin
      module Entities
        class DeviceRangeSku < OnOff::API::Entities::Base
          expose :id, :amount, :title
        end
      end
    end
  end
end