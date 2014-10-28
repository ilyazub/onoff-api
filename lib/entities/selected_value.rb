require_relative './base'

module OnOff
  module API
    module Entities
      class SelectedValue < Base
        expose :cart_id, :series_id, :value_id
      end
    end
  end
end