require_relative './base'

require_relative './device_series_stock_keeping_unit'
require_relative './device_series'

require_relative '../entities/stock_keeping_unit'

module OnOff
  module API
    module Models
      class StockKeepingUnit < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :title, String, required: true, unique_index: true
        property :price, Float, required: true, default: 0.0

        has n, :device_series_stock_keeping_units
        has n, :device_series, through: :device_series_stock_keeping_units

        timestamps :at

        Entity = Entities::StockKeepingUnit
      end
    end
  end
end