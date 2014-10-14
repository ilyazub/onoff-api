require_relative './base'

module OnOff
  module API
    module Entities
      class SelectedValue < Base
        expose :cart_item_id, :value_id, documentation: { type: 'Integer' }
      end
    end
  end
end