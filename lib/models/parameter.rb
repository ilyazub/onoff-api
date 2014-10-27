require_relative './value'

require_relative '../entities/parameter'

module OnOff
  module API
    module Models
      class Parameter < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :variable, String, required: true, unique: true
        property :description, String, required: true

        has n, :values, constraint: :destroy

        timestamps :at

        Entity = Entities::Parameter
      end
    end
  end
end