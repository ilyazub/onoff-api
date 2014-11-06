require 'roo'

module OnOff
  module API
    module Parser
      class Base
        attr_accessor :sheet

        def initialize
          DataMapper.finalize
        end

        def parse(path)
          @sheet = create_sheet_from_filename(path)
        end

        def create_sheet_from_filename(file)
          case File.extname(file.path)
          when '.ods' then Roo::OpenOffice.new(file.path, {}, :ignore)
          when '.xls' then Roo::Excel.new(file.path, {}, :ignore)
          when '.xlsx' then Roo::Excelx.new(file.path, {}, :ignore)
          else raise "Неподдерживаемый тип файла: #{file.path}. Поддерживаются только файлы типа ods, xls, xlsx."
          end
        end
      end
    end
  end
end