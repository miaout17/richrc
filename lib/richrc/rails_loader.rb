module Richrc
  class RailsLoader

    SCRIPT_RAILS = File.join('script', 'rails')

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

    def start_console!
      require File.expand_path(File.join(app_path, "config/boot"))
      require 'rails/commands/console'
      require File.expand_path(File.join(app_path, "config/application"))

      Rails.application.require_environment!
      Rails::Console.start(Rails.application)
    end

  end
end
