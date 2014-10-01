require_relative './base'

require_relative './device_series'
require_relative './stock_keeping_unit'

module OnOff
  module API
    module Entities
      class DeviceSeriesStockKeepingUnit < Base
        expose :amount
        expose :stock_keeping_unit, using: StockKeepingUnit
      end
    end
  end
end