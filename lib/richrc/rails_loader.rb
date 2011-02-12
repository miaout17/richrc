module Richrc
  class RailsLoader
    SCRIPT_RAILS = File.join('script', 'rails')

    def initialize
      @callbacks = Hash.new []
    end

    def run
      if app_path
        start_console
      else
        puts "You are not in rails app path!"
      end
    end

    def app_path
      @app_path ||= find_app_path
    end

    def add_callback(timing, kind, task)
      key = [timing, kind]
      @callbacks[key] = [] unless @callbacks.has_key?(key)
      @callbacks[key] << task
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

    def run_callbacks(kind)
      @callbacks[[:before, kind]].each { |blk| Object.new.instance_eval(&blk) }
      yield
      @callbacks[[:after, kind]].each { |blk| Object.new.instance_eval(&blk) }
    end

    def start_console
      puts "Loading RichRC environment"
      load_config

      run_callbacks(:setup_bundler) do
        require File.expand_path(File.join(app_path, "config/boot"))
      end

      run_callbacks(:load_application) do
        require 'rails/commands/console'
        require File.expand_path(File.join(app_path, "config/application"))
        Rails.application.require_environment!
      end

      Rails::Console.start(Rails.application)
    end

    def load_config
      current_config = File.expand_path(File.join(".", ".richrc"))
      home_config = File.expand_path(File.join(ENV["HOME"], ".richrc"))
      default_config = File.expand_path(File.join(__FILE__, "../../../config/default.rb"))

      [current_config, home_config, default_config].each do |path|
        if File.exists?(path)
          ConfigLoader.new(self).load(path)
          if path==default_config
            puts "RichRC: Loading default config file"
          else
            puts "RichRC: Loading config: #{path}"
          end
          break
        end
      end
    end

  end
end
