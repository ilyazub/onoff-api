require_relative './base'

module OnOff
  module API
    module Entities
      class SelectedValue < Base
        expose :cart_id, :code
      end
    end
  end
end