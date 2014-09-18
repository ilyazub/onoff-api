require 'dm-timestamps'

require_relative '../../config/database'

module OnOff
  module API
    module Models
      class Base
        def self.create_all(list)
          list.each do |item|
            self.create item
          end

          self.all
        end
      end
    end
  end
end