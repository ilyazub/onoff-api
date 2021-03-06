require 'yaml'

module OnOff
  module API
    class Application
      attr_accessor :config, :env, :database, :root, :logfile

      def initialize
        @env = ENV['API_ENV'] ||= 'development'
        @root = File.dirname(File.dirname(__FILE__))

        @logfile = File.new("#{root}/log/#{env}.log", 'a+')
        @logfile.sync = true

        @config = {
          database: YAML.load(Tilt::ERBTemplate.new('./config/database.yaml').render(binding))
        }

        @database = Database.new(@config[:database][env])

        self
      end

      def images_folder
        folders = {
          development: proc { File.join(File.dirname(root), '/onoff-images') },
          production: proc { File.join(ENV['HOME'], '/images') }
        }

        folders[env.to_sym].call
      end

      def connection_string
        @database.to_s
      end

      def db_vars
        @database.config
      end

      def env_vars
        @database.env_vars
      end

      class Database
        attr_accessor :config

        def initialize(config)
          @config = config
        end

        def connection_string
          "#{config['adapter']}://#{config['username']}:#{config['password']}@#{config['host']}:#{config['port']}/#{config['database']}"
        end

        def name
          config['database']
        end

        def env_vars
          "PGHOST=#{config['host']} PGPORT=#{config['port']} PGDATABASE=#{config['template']} PGUSER=#{config['username']} PGPASSWORD=#{config['password']}"
        end

        def to_s
          connection_string
        end
      end
    end

    def self.application
      @application ||= Application.new
    end
  end
end