module Richrc
  class ConfigLoader

    def self.load(path)
      self.new.tap do |loader|
        loader.instance_eval(File.read(path))
      end.config
    end
    
    attr_reader :config

    def initialize
      @config = Config.new
    end

    def gem(name, options={}, &block)
      #TODO: gem version
      options = options.merge(:name => name)
      options = options.merge(:on_success => block) if block
      config.gems << options
    end

    def environment(&block)
      config.on_environment_loaded = block
    end

  end

  class Config
    attr_accessor :gems, :on_environment_loaded
    def initialize
      @gems = []
    end
  end

end
