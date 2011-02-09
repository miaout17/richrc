module Richrc
  class RailsLoader
    SCRIPT_RAILS = File.join('script', 'rails')

    def run!
      if app_path
        start_console!
      else
        puts "You are not in rails app path!"
      end
    end

    def app_path
      @app_path ||= find_app_path
    end

    private

    # Find app path and chdir to app path
    def find_app_path
      # The algorithm is mimicking from rails source code, I think there should be a smarter way
      last_dir = Dir.pwd
      until File.exists?(SCRIPT_RAILS)
        Dir.chdir("..")
        return nil if Dir.pwd==last_dir
        last_dir = Dir.pwd
      end
      Dir.pwd
    rescue SystemCallError # Recure from chdir failure
      nil
    end

    def try_load_gem(options)
      #TODO: gem version
      gem_name = options[:name]
      begin
        gem gem_name
        require options[:require] if options[:require]
        options[:on_success].call if options[:on_success]
        msg "Gem #{gem_name}: Loaded successfully"
      rescue LoadError
        msg "Gem #{gem_name}: Failed to load, is it installed?"
      end
    end

    def start_console!
      puts "Loading RichRC environment"
      load_config

      require 'irb'
      @config.gems.each { |g| try_load_gem(g) }

      require File.expand_path(File.join(app_path, "config/boot"))
      require 'rails/commands/console'
      require File.expand_path(File.join(app_path, "config/application"))

      @config.on_environment_loaded.call if @config.on_environment_loaded

      Rails.application.require_environment!
      Rails::Console.start(Rails.application)
    end

    def load_config
      current_config = File.expand_path(File.join(".", ".richrc"))
      home_config = File.expand_path(File.join(ENV["HOME"], ".richrc"))
      default_config = File.expand_path(File.join(__FILE__, "../../../config/default.rb"))

      [current_config, home_config, default_config].each do |path|
        if File.exists?(path)
          @config = ConfigLoader.load(path)
          if path==default_config
            msg "Loading default config file"
          else
            msg "Loading config: #{path}"
          end
          break
        end
      end
    end

    def msg(s)
      puts "RichRC: #{s}"
    end

  end
end
