require_relative './base'

module OnOff
  module API
    module Entities
      class Value < Base
        expose :id, :code, :description, :selected

        expose :unit_price, as: :unitPrice
      end
    end
  end
end