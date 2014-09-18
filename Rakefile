require 'pry'

namespace :db do
  desc "Load seeds"
  task :seeds do
    require_relative './db/seeds'

    seeds_loader = OnOff::API::DB::SeedsLoader.new
  end
end