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

    desc 'Check matching of SKU titles in price-list and compiled titles in catalogue'
    task :check_matches do
      unique_compiled_titles = OnOff::API::Models::SKUValue.distinct(:compiled_title).map(&:compiled_title)

      File.open('tmp/unique_compiled_titles.txt', 'w+') { |f| f.write(unique_compiled_titles.join("\r\n")) }
    end
  end
end