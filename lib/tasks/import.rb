namespace :db do
  desc 'Import data and prices from spreadsheet to database'
  task import: [
    'import:catalogue',
    'import:prices'
  ]

  namespace :import do
    desc 'Import data from spreadsheet to database'
    task :catalogue, :filename do |task, args|
      require './lib/parser/catalogue'

      args.with_defaults(filename: 'spreadsheets/DBex.xlsx')
      file = File.new(args[:filename])

      parser = OnOff::API::Parser::Catalogue.new
      parser.parse(file)
    end

    desc 'Import price-list from spreadsheet to database'
    task :prices, :filename do |task, args|
      require './lib/parser/prices'

      args.with_defaults(filename: 'spreadsheets/price_list.xlsx')
      file = File.new(args[:filename])

      parser = OnOff::API::Parser::Prices.new
      parser.parse(file)
    end

    desc 'Check data after import'
    task :check_data do
      unique_compiled_titles = []

      sku_titles_without_parameters = OnOff::API::Models::DeviceSeriesSKU.all(:unit_price.not => 0.0).map(&:title).uniq
      sku_values_compiled_titles = OnOff::API::Models::SKUValue.distinct(:compiled_title).map(&:compiled_title)

      unique_compiled_titles.concat(sku_titles_without_parameters)
      unique_compiled_titles.concat(sku_values_compiled_titles)

      invalid_skus = OnOff::API::Models::DeviceSeriesSKU.all(unit_price: 0.0, :id.not => OnOff::API::Models::SKUParameter.distinct(:device_series_sku_id).map(&:device_series_sku_id))
      invalid_values = OnOff::API::Models::SKUValue.all(unit_price: 0.0)

      invalid_results = invalid_skus.map(&:title).uniq
      invalid_results.concat(invalid_values.distinct(:compiled_title).map(&:compiled_title))

      File.open('tmp/import_report.txt', 'w+') do |f|
        unique_compiled_titles.unshift('Уникальные подставленные из шахматки')
        f.write(unique_compiled_titles.join("\r\n"))

        invalid_results.unshift("\r\n\r\nБез параметров и с нулевой стоимостью (импортированные с ошибками)") if invalid_results.size > 0
        f.write(invalid_results.join("\r\n"))
      end
    end
  end
end