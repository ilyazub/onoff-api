require_relative '../../entities/base'

module OnOff
  module API
    module Admin
      module Entities
        class Range < OnOff::API::Entities::Base
          expose :id, :title
        end
      end
    end
  end
end