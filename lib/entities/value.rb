require_relative './base'

module OnOff
  module API
    module Entities
      class Value < Base
        expose :id
        expose :code, :description
        expose :unit_price, as: :unitPrice
        expose :selected
      end
    end
  end
end