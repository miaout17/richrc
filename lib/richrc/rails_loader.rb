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

    def find_app_path
      last_dir = Dir.pwd
      until in_app_path?
        Dir.chdir("..")
        return nil if Dir.pwd==last_dir
        last_dir = Dir.pwd
      end
      Dir.pwd
    rescue SystemCallError # Recure from chdir failure
      nil
    end

    def in_app_path?
      File.exists?(SCRIPT_RAILS)
    end

    def try_load_gem(options)
       gem_name = options[:name]
      begin
        gem gem_name
        require options[:require] if options[:require]
        options[:on_success].call if options[:on_success]
        puts "#{gem_name} loaded successfully"
      rescue LoadError
        puts "Failed to load gem #{gem_name}, is it installed?"
      end
    end

    def start_console!
      load_config

      require 'irb'
      @config.gems.each { |g| try_load_gem(g) }

      require File.expand_path(File.join(app_path, "config/boot"))
      require 'rails/commands/console'
      require File.expand_path(File.join(app_path, "config/application"))

      Rails.application.require_environment!
      Rails::Console.start(Rails.application)
    end

    def load_config
      default_config_path = File.expand_path(File.join(__FILE__, "../../../config/default.rb"))
      @config = ConfigLoader.load(default_config_path)
    end

  end
end
