require 'roo'

module OnOff
  module API
    module Parser
      class Base
        attr_accessor :sheet

        def initialize
          DataMapper.finalize
        end

        def parse(file, options = {})
          @sheet = create_sheet_from_file(file, options)
        end

        def create_sheet_from_file(file, options)
          Roo::Spreadsheet.open(file, options)
        end
      end
    end
  end
end