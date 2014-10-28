require_relative './manufacturer'
require_relative './device_series'

require_relative '../entities/series'

module OnOff
  module API
    module Models
      class Series < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :title, String, required: true, unique: :manufacturer_id

        belongs_to :manufacturer, required: true

        has n, :device_series, constraint: :destroy
        has n, :devices, through: :device_series
        has n, :device_series_skus, 'DeviceSeriesSKU', through: :device_series
        has n, :taggings, through: :device_series

        timestamps :at

        Entity = Entities::Series

        def min_price
          device_series_skus.inject(0) { |mem, device_series_sku| mem + device_series_sku.min_price }
        end

        def parameters
          # parameters_groups = device_series_skus.parameters.group_by(&:title)

          # parameters_groups.map do |parameter_group|
          #   parameter_group.inject(Parameter.new) { |new_parameter, parameter| new_parameter.values << parameter.values }
          # end

          device_series_skus.parameters.inject([]) do |mem, parameter|
            if found_parameter = mem.detect { |p| p.variable == parameter.variable }
              found_parameter.values << parameter.values
            else
              mem << parameter
            end
          end
        end
      end
    end
  end
end