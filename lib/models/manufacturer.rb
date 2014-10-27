require_relative './series'

require_relative '../entities/manufacturer'

module OnOff
  module API
    module Models
      class Manufacturer < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :title, String, required: true, unique: true
        property :country, String, required: true
        property :assembly, String, required: true

        has n, :series, 'Series'

        timestamps :at

        Entity = Entities::Manufacturer
      end
    end
  end
end