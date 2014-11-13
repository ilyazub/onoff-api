require_relative './sku'
require_relative './device_series'
require_relative './sku_parameter'

require_relative '../entities/device_series_sku'

module OnOff
  module API
    module Models
      class DeviceSeriesSKU < Base
        include DataMapper::Resource

        property :id, Serial, required: true, key: true
        property :amount, Integer, required: true, default: 1
        property :unit_price, Float, required: true, default: 0.0

        belongs_to :sku, 'SKU', required: true
        belongs_to :device_series, required: true

        has n, :sku_parameters, 'SKUParameter', constraint: :destroy

        timestamps :at

        Entity = Entities::DeviceSeriesSKU

        def compiled_title(cart, series_id)
          cart.selected_values.all(parameter: { series_id: series_id }).inject(title) do |result, selected_value|
            parameter = selected_value.parameter
            value = parameter.values.get(selected_value.value_id)

            result.sub(parameter.variable, value.code)
          end
        end

        def amount_in_cart(cart)
          @amount_in_cart ||= amount * cart.specific_devices_amount(device)
        end

        def price_per_unit(cart, series_id)
          value_ids = cart.selected_values.all(parameter: { series_id: series_id }).map(&:value_id)
          sku_values = sku_parameters.sku_values.all(value_id: value_ids)

          if sku_values.size > 0
            sku_values.inject(0) { |price, value| price + value.unit_price }
          else
            unit_price
          end
        end

        def price(cart, series_id)
          price_per_unit(cart, series_id) * amount_in_cart(cart)
        end

        def title() sku.title end
        def device_id() device.id end
        def device() device_series.device end
      end
    end
  end
end