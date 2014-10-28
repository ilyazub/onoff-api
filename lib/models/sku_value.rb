require_relative './sku_parameter'
require_relative './value'

require_relative '../entities/value'

module OnOff
  module API
    module Models
      class SKUValue < Base
        include DataMapper::Resource

        property :unit_price, Float, required: true, default: 0.0

        belongs_to :sku_parameter, 'SKUParameter', key: true, required: true
        belongs_to :value,                         key: true, required: true

        timestamps :at

        Entity = Entities::SKUValue
      end
    end
  end
end