require_relative './base'

module OnOff
  module API
    module Entities
      class SKU < Base
        expose :id
        expose :title
        expose :unit_price, as: :unitPrice
      end
    end
  end
end