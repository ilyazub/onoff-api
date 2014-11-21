require_relative './base'

module OnOff
  module API
    module Parser
      class Catalogue < Base
        PATTERNS = {
          MANUFACTURER:   /\AПроизводитель\z/,
          COUNTRY:        /\AСтрана\z/,
          SERIES:         /\AНаименование\/[\s]*Серия\z/,
          DEVICE_GROUP:   /\AГруппа устройств[\:]?[\s]*([А-Яа-я]+)\z/,  # Заголовок группы устройств
          PARAMETER:      /\AПараметр[\s]*(.*)[\s]*-[\s]*(.*)\z/,       # Строка с названием параметра
          OPTION:         /\AОпция[\s]*(.*)\z/,
          SKU:            /\A(.*)[\s]*\*[\s]*(\d)+(?:.*)?\z/,
          VALUE:          /\A([\d\w-]+)[\s]*[-:][\s]*(.*)\z/,
          INVALID_VALUE:  /\A(\d*[а-яА-Я]+\d*)[\s]*[-:][\s]*(.*)\z/
        }

        def parse(file, options = {})
          super

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
            when PATTERNS[:MANUFACTURER]
              manufacturers_found = true
              manufacturers = row.drop(4)
            when PATTERNS[:COUNTRY]
              countries_found = true
              countries = row.drop(4)
            when PATTERNS[:SERIES]
              raise ArgumentError.new('Производители не заданы') unless manufacturers_found
              raise ArgumentError.new('Страны производителей не заданы') unless countries_found

              series = row.drop(4)
              series.each_with_index do |title, index|
                manufacturer = Models::Manufacturer.first_or_create(title: manufacturers[index].strip, country: countries[index].strip)
                Models::Series.create(title: title.strip, manufacturer: manufacturer)
              end
            when PATTERNS[:DEVICE_GROUP]
              raise ArgumentError.new('Серии не заданы') if Models::Series.count == 0

              device_group_found = true
              Models::DeviceGroup.create(title: $1.strip)
            when PATTERNS[:PARAMETER]
              device_group_found = false
              device_found = false

              parameter_hash = { variable: $1.strip, description: $2.strip }
            when PATTERNS[:OPTION] # Опции пропустить, т.к. они пока не поддерживаются
            when String
              if device_group_found # Строка между началом и концом группы устройств
                device_found = true

                device_group = Models::DeviceGroup.last
                device = Models::Device.create(code: row[0].strip, display_on_page: row[1].to_i == 1, index: row[2].to_i, title: row[3].strip, device_group: device_group) # Первая ячейка - название устройства

                parse_device_series(row, device)
              elsif option_found
              end
            when nil
              if row.any? { |col| !col.blank? } # Не пустая строка
                if device_found # Если это не первая строка артикулов устройства
                  device = Models::Device.last
                  parse_device_series(row, device)
                elsif parameter_hash
                  parse_values(row, parameter_hash)
                end
              else
                device_group_found = false # Пустая строка после артикулов из группы устройств
                device_found = false
                parameter_hash = false
              end
            end
          end
        end

        def parse_device_series(row, device)
          skus = row.drop(4)
          skus.each_with_index { |title, index| parse_sku(device, title, index) }
        end

        def parse_sku(device, title, index)
          return if String(title).strip == '' # Пропустить пустую ячейку

          if title.match(PATTERNS[:OPTION]).nil? # Опции пропустить, т.к. они пока не поддерживаются
            device_series = Models::DeviceSeries.first_or_create(device: device, series: Models::Series.get(index + 1)) # Создать серию устройств

            title =~ PATTERNS[:SKU]
            title = $1 || title
            amount = $2 || 1

            sku = Models::SKU.first_or_create(title: title.strip)
            Models::DeviceSeriesSKU.create(sku: sku, device_series: device_series, amount: amount.to_i, unit_price: 0.0)
          end
        end

        def parse_values(row, parameter_hash)
          values = row.drop(4)
          values.each_with_index do |value, index|
            if value =~ PATTERNS[:VALUE] # Если значение задано в правильном формате
              series = Models::Series.get(index + 1)
              parameter = Models::Parameter.first_or_create({ series: series, variable: parameter_hash[:variable] }, parameter_hash)
              created_value = parameter.values.create(code: $1.strip, description: $2.strip, selected: parameter.values.count == 0)

              device_series_skus = Models::DeviceSeriesSKU.all(device_series: { series: series }, sku: { :title.like => "%#{parameter.variable}%" })
              device_series_skus.each do |device_series_sku|
                device_series_sku.update(unit_price: 0.0)

                sku_parameter = device_series_sku.sku_parameters.first_or_create(parameter: parameter)
                sku_parameter.sku_values.create(value: created_value, compiled_title: device_series_sku.title.sub(parameter.variable, created_value.code), unit_price: 0.0)
              end
            end
          end
        end
      end
    end
  end
end