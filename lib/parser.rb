module OnOff
  module API
    class Parser
      attr_accessor :sheet

      def initialize
        DataMapper.finalize
      end

      def parse(filename)
        match = filename.match(/^.*\.(\w+)$/)
        type = {
          cvs: 'CVS',
          ods: 'OpenOffice',
          xls: 'Excel',
          xlsx: 'Excelx'
        }

        class_name = "Roo::#{type[match[1].to_sym]}"
        spreadsheet_class = Object.const_get(class_name)
        @sheet = spreadsheet_class.new(filename) unless match.nil?

        manufacturers = []
        countries = []

        device_group_found = false
        parameters_found = false

        @sheet.each do |row|
          # row.reject!(&:blank?)

          manufacturers = row.drop(1) if row[0] == 'Производитель'
          countries = row.drop(1) if row[0] == 'Страна'

          if row[0] == 'Наименование/Серия'
            raise ArgumentError.new('Производители не заданы') if manufacturers.size == 0
            raise ArgumentError.new('Страны производителей не заданы') if countries.size == 0

            series = row.drop(1)
            series.each_with_index do |title, index|
              manufacturer = Models::Manufacturer.first_or_create(title: manufacturers[index], country: countries[index])
              Models::Series.create(title: title, manufacturer: manufacturer)
            end
          end

          device_group = row[0].match(/^Группа устройств: (.*)$/) unless row[0].nil?
          unless device_group.nil?
            raise ArgumentError.new('Серии не заданы') if Models::Series.count == 0
            Models::DeviceGroup.create(title: device_group[1])
            device_group_found = true
          end

          if device_group_found
            device_group = Models::DeviceGroup.last
            device = Models::Device.create(title: row[0], device_group: device_group)

            skus = row.drop(1)
            skus.each_with_index do |title, index|
              if title && title.match(/^Опция/).nil?
                if Models::Series.count - index <= 0
                  Models::DeviceSeries.create(device: device, series: Models::Series.get(index + 1))
                end

                sku = Models::SKU.first_or_create(title: title)
                Models::DeviceSeriesSKU.create(sku: sku, unit_price: rand(1..100.0))
              end
            end

            device_group_found = false if row[0].nil?
          end

          parameter = row[0].match(/^Параметр (.*) - (.*)$/) unless row[0].nil?
          unless parameter.nil?

          end
        end
      end
    end
  end
end