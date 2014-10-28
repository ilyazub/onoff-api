require_relative './cart'
require_relative './series'

require_relative '../entities/selected_value'

module OnOff
  module API
    module Models
      class SelectedValue < Base
        include DataMapper::Resource

        property :value_id, Integer, required: true

        belongs_to :cart, key: true, required: true
        belongs_to :parameter, key: true, required: true

        timestamps :at

        Entity = Entities::SelectedValue
      end
    end
  end
end