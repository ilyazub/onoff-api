require_relative './base'

module OnOff
  module API
    module Parser
      class Prices < Base
        def parse(file, options = {})
          super

          is_first_row = true
          @sheet.each do |row|
            unless is_first_row
              compiled_title, type, description, unit_price = row

              Models::SKUValue.all(compiled_title: compiled_title).update(description: description, unit_price: unit_price)
              Models::DeviceSeriesSKU.all(sku: { title: compiled_title }).update(unit_price: unit_price)
            end

            is_first_row = false
          end
        end
      end
    end
  end
end