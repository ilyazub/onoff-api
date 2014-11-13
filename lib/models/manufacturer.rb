require_relative './series'

require_relative '../entities/manufacturer'

module OnOff
  module API
    module Models
      class Manufacturer < Base
        include DataMapper::Resource

        property :id, Serial, key: true, required: true
        property :title, String, required: true, unique_index: :unique_manufacturer
        property :country, String, required: true, unique_index: :unique_manufacturer

        has n, :series, 'Series', constraint: :destroy

        timestamps :at

        validates_uniqueness_of :title, scope: :country, message: "There's already a manufacturer of that title in this country"

        Entity = Entities::Manufacturer
      end
    end
  end
end