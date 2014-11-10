require_relative './base'

module OnOff
  module API
    module Entities
      class Device < Base
        expose :id, :code, :title
      end
    end
  end
end