require_relative './base'
require_relative './manufacturer'

module OnOff
  module API
    module Entities
      class Series < Base
        expose :id, :title

        expose :manufacturer, using: Manufacturer
      end
    end
  end
end