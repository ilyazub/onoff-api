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
  end
end