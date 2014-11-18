require_relative './base'

module OnOff
  module API
    module Entities
      class Device < Base
        expose :id, :code, :title, :index
      end
    end
  end
end