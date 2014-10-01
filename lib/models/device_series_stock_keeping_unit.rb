require_relative './stock_keeping_unit'
require_relative './device_series'

require_relative '../entities/device_series_stock_keeping_unit'

module OnOff
  module API
    module Models
      class DeviceSeriesStockKeepingUnit < Base
        include DataMapper::Resource

        property :amount, Integer, required: true, default: 1

        belongs_to :stock_keeping_unit, key: true
        belongs_to :device_series, key: true

        timestamps :at

        Entity = Entities::DeviceSeriesStockKeepingUnit
      end
    end
  end
end