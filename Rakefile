require 'pry'

namespace :db do
  desc "Load seeds"
  task :seeds do
    require_relative './db/seeds'

    seeds_loader = OnOff::SeedsLoader.new
  end
end