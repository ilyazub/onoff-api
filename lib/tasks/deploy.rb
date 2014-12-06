require_relative './import'

desc 'Deploy and restart server'
task deploy: [
  'deploy:update_code',
  'db:migrate',
  'deploy:restart'
]

namespace :deploy do
  @user = 'deployer'
  @host = '178.62.239.198'
  @repository = 'git@github.com:ilyazub/onoff-api.git'
  @branch = 'origin/master'
  @deployment_path = "/home/#{@user}/websites/onoff-api"

  desc 'Setup folder'
  task :setup do
    remote_task([
      create_folder_if_not_exists,
      git_clone
    ])
  end

  desc 'Update code'
  task :update_code do
    remote_task([
      update_code_command,
      bundle_install_command
    ])
  end

  desc 'Restart server'
  task :restart do
    remote_task(restart_server_command)
  end

  desc 'Import data and prices from spreadsheet to database'
  task 'db:migrate' do
    remote_task(migrate_command)
  end

  desc 'Import data and prices from spreadsheet to database'
  task 'db:import' do
    remote_task(import_data_command)
  end

  def remote_task(commands, options = {})
    commands = Array(commands)
    commands.each do |command|
      sh "ssh #{@user}@#{@host} \"#{source_profile} && #{change_dir} && #{command}\""
    end
  end

  def source_profile
    "source /home/#{@user}/.profile"
  end

  def change_dir
    "cd #{@deployment_path}"
  end

  def create_folder_if_not_exists
    "mkdir -p #{@deployment_path}"
  end

  def git_clone
    "git clone -b #{@branch} #{@repository} #{@deployment_path}"
  end

  def update_code_command
    [
      "git fetch origin",
      "git reset --hard #{@branch}"
    ].join(" && ")
  end

  def bundle_install_command
    "/home/#{@user}/.rbenv/shims/bundle install --without development test"
  end

  def restart_server_command
    "/home/#{@user}/.rbenv/shims/bundle exec pumactl -F ./config/production.rb restart"
  end

  def migrate_command
    "/home/#{@user}/.rbenv/shims/bundle exec rake db:migrate"
  end

  def import_data_command
    "/home/#{@user}/.rbenv/shims/bundle exec rake db:import"
  end
end