desc "Deploy and restart server"
task deploy: [
  'deploy:update_code',
  'deploy:restart'
]

namespace :deploy do
  @user = 'onoff'
  @host = '166.63.124.211'
  @repository = 'git@github.com:ilyazub/onoff-api.git'
  @branch = 'origin/master'
  @deployment_path = 'websites/onoff-api'

  desc 'Update code'
  task :update_code do
    sh "ssh #{@user}@#{@host} \"#{update_code_commands}\""
  end

  desc 'Restart server'
  task :restart do
    sh "ssh #{@user}@#{@host} \"#{restart_server_commands}\""
  end

  def update_code_commands
    [
      "cd #{@deployment_path}",
      "git fetch origin",
      "git reset --hard #{@branch}"
    ].join(" && ")
  end

  def restart_server_commands
    [
      "cd #{@deployment_path}",
      "/home/onoff/.rbenv/shims/bundle exec rake app:kill",
      "/home/onoff/.rbenv/shims/bundle exec rackup -D"
    ].join(" && ")
  end
end