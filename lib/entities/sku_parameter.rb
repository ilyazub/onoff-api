require_relative './base'

require_relative './device_series_sku'
require_relative './parameter'

module OnOff
  module API
    module Entities
      class SKUParameter < Base
        expose :parameter_id
      end
    end
  end
end