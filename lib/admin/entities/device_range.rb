require_relative '../../entities/base'
require_relative './device_range_sku'

module OnOff
  module API
    module Admin
      module Entities
        class DeviceRange < OnOff::API::Entities::Base
          expose :device_series_skus, as: :skus, using: DeviceRangeSku
        end
      end
    end
  end
end