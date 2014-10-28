require_relative './base'

module OnOff
  module API
    module Entities
      class Value < Base
        expose :id, :code, :description, :selected
      end
    end
  end
end