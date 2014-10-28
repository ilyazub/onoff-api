require_relative './series'
require_relative './value'
require_relative './sku_parameter'

require_relative '../entities/parameter'

module OnOff
  module API
    module Models
      class Parameter < Base
        include DataMapper::Resource

        property :id,           Serial, key: true, required: true
        property :series_id,    Integer, unique_index: :series_parameter, required: true
        property :variable,     String, unique_index: :series_parameter, required: true
        property :description,  String, required: true

        belongs_to  :series,          required: true
        has n,      :sku_parameters,  'SKUParameter', constraint: :destroy
        has n,      :values,          constraint: :destroy

        timestamps :at

        validates_uniqueness_of :variable, scope: :series_id, message: "There's already a parameter of that variable in this series"

        Entity = Entities::Parameter
      end
    end
  end
end