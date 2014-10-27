require_relative './base'

module OnOff
  module API
    module Entities
      class Manufacturer < Base
        expose :id, :title, :country, :assembly
      end
    end
  end
end