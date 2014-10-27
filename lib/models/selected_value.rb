require_relative './cart'

require_relative '../entities/selected_value'

module OnOff
  module API
    module Models
      class SelectedValue < Base
        include DataMapper::Resource

        belongs_to :cart, key: true, required: true
        property :code, String, key: true, required: true

        timestamps :at

        Entity = Entities::SelectedValue
      end
    end
  end
end