module Richrc
  class << self
    def wirble!
      require "irb"
      begin
        gem 'wirble'
        require 'wirble'
        Wirble.init
        Wirble.colorize
        puts "Wirble is loaded"
      rescue LoadError
        puts "Wirble is not loaded!!(Did you install wirble gem?)"
      end
    end

    def hirb!
      begin
        gem 'hirb'
        require 'hirb'
        Hirb.enable
        puts "Hirb is loaded"
      rescue LoadError
        puts "Hirb is not loaded!!(Did you install hirb gem?)"
      end
    end
  end
end

