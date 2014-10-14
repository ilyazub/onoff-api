require_relative './cart_item'
require_relative './value'

require_relative '../entities/selected_value'

module OnOff
  module API
    module Models
      class SelectedValue < Base
        include DataMapper::Resource

        belongs_to :cart_item, key: true
        belongs_to :value, key: true

        timestamps :at

        Entity = Entities::SelectedValue
      end
    end
  end
end