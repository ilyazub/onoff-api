require_relative './base'

module OnOff
  module API
    module Entities
      class Value < Base
        expose :id, :code, :description, :selected, :image_url
      end
    end
  end
end