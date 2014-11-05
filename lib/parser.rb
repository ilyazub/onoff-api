module OnOff
  module API
    class Parser
      attr_accessor :sheet

      def initialize
        DataMapper.finalize
      end

      def parse(filename)
        class_name = class_name_from_filename(filename)
        @sheet = class_name.new(filename)

        manufacturers = []
        countries     = []

        manufacturers_found = false
        countries_found     = false
        device_group_found  = false
        device_found        = false
        parameter_hash      = false
        option_found        = false

        @sheet.each do |row|
          case row[0]
          when 'Производитель'
            manufacturers_found = true
            manufacturers = row.drop(1)
          when 'Страна'
            countries_found = true
            countries = row.drop(1)
          when 'Наименование/Серия'
            raise ArgumentError.new('Производители не заданы') unless manufacturers_found
            raise ArgumentError.new('Страны производителей не заданы') unless countries_found

            series = row.drop(1)
            series.each_with_index do |title, index|
              manufacturer = Models::Manufacturer.first_or_create(title: manufacturers[index].strip, country: countries[index].strip)
              Models::Series.create(title: title.strip, manufacturer: manufacturer)
            end
          when /^Группа устройств[\:]?[\s]*([А-Яа-я]+)$/ # Заголовок группы устройств
            raise ArgumentError.new('Серии не заданы') if Models::Series.count == 0

            device_group_found = true
            Models::DeviceGroup.create(title: $1.strip)
          when /^Параметр[\s]*(.*)[\s]*-[\s]*(.*)$/ # Строка с названием параметра
            device_group_found = false
            device_found = false

            parameter_hash = { variable: $1.strip, description: $2.strip }
          when /^Опция[\s]*(.*)$/ # Опции пропустить, т.к. они пока не поддерживаются
          when String
            if device_group_found # Строка между началом и концом группы устройств
              device_found = true

              device_group = Models::DeviceGroup.last
              device = Models::Device.create(title: row[0].strip, device_group: device_group) # Первая ячейка - название устройства

              parse_device_series(row, device)
            elsif option_found
            end
          when nil
            if row.any? { |col| !col.blank? } # Не пустая строка
              if device_found # Если это не первая строка артикулов устройства
                device = Models::Device.last
                parse_device_series(row, device)
              elsif parameter_hash
                values = row.drop(1)
                values.each_with_index do |value, index|
                  if value =~ /^([\d\w]+)[\s]*-[\s]*(.*)$/ # Если значение задано и оно в правильном формате
                    series = Models::Series.get(index + 1)
                    parameter = Models::Parameter.first_or_create({ series: series, variable: parameter_hash[:variable] }, parameter_hash)
                    created_value = parameter.values.create(code: $1.strip, description: $2.strip, selected: parameter.values.count == 0)

                    device_series_skus = Models::DeviceSeriesSKU.all(device_series: { series: series }, sku: { :title.like => "%#{parameter_hash[:variable]}%" })
                    device_series_skus.each do |device_series_sku|
                      sku_parameter = device_series_sku.sku_parameters.first_or_create(parameter: parameter)
                      sku_parameter.sku_values.create(value: created_value, unit_price: rand(1..100.0))
                    end
                  end
                end
              end
            else
              device_group_found = false # Пустая строка после артикулов из группы устройств
              device_found = false
              parameter_hash = false
            end
          end
        end
      end

      def class_name_from_filename(filename)
        match = filename.match(/^.*\.(\w+)$/)
        type = {
          'ods' => 'OpenOffice',
          'xls' => 'Excel',
          'xlsx' => 'Excelx'
        }

        sheat_class = type[$1]
        raise ArgumentError.new("Поддерживаются только файлы типа ods, xls, xlsx. Тип твоего файла - #{$1}") if sheat_class.nil?

        class_name = "Roo::#{sheat_class}"
        Object.const_get(class_name)
      end

      def parse_device_series(row, device)
        skus = row.drop(1)
        skus.each_with_index do |title, index|
          if title && title.match(/^Опция[\s]*(.*)$/).nil? # Опции пропустить, т.к. они пока не поддерживаются
            device_series = Models::DeviceSeries.first_or_create(device: device, series: Models::Series.get(index + 1)) # Создать серию устройств

            title =~ /^(.*)\*(\d)$/
            title = $1 || title
            amount = $2 || 1

            sku = Models::SKU.first_or_create(title: title.strip)
            Models::DeviceSeriesSKU.create(sku: sku, device_series: device_series, amount: amount.to_i, unit_price: rand(1..100.0))
          end
        end
      end
    end
  end
end