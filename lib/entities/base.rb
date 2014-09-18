require 'grape-entity'

module OnOff
  module API
    module Entities
      class Base < Grape::Entity
        expose :id
      end
    end
  end
end