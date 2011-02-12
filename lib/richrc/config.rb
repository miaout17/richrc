module Richrc

  class ConfigLoader

    def initialize(rails_loader)
      @rails_loader = rails_loader
    end

    def load(path)
      instance_eval(File.read(path))
    end

    def method_missing(method, *args, &block)
      if %w{before after}.include?(method.to_s)
        @rails_loader.add_callback(method.to_sym, args.first, block)
      else
        super
      end
    end

  end

end
