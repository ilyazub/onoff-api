require_relative './cart'
require_relative './parameter'

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

        def self.get_or_create(params = {})
          if selected_value = get(params[:cart_id], params[:parameter_id])
            selected_value.update(value_id: params[:value_id])
          else
            selected_value = create(cart_id: params[:cart_id], parameter_id: params[:parameter_id], value_id: params[:value_id])
          end

          selected_value
        end

        def stringified_cart_id
          cart_id.to_s
        end
      end
    end
  end
end