require_relative './base'
require_relative './manufacturer'
require_relative './parameter'

module OnOff
  module API
    module Entities
      class Series < Base
        expose :id, :title
        expose :min_price, as: :minPrice

        expose :manufacturer, using: Manufacturer
        expose :parameters, using: Parameter
      end
    end
  end
end