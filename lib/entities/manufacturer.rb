require_relative './base'

module OnOff
  module API
    module Entities
      class Manufacturer < Base
        expose :id, :title, :country
      end
    end
  end
end