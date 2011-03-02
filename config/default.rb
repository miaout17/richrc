before(:setup_bundler) do
  # You can load extra gems here.

  require 'irb'

  begin
    gem 'wirble'
    require 'wirble'
    Wirble.init
    Wirble.colorize
    puts "Wirble Loaded"
  rescue LoadError
  end

  begin
    gem 'hirb'
    require 'hirb'
    Hirb.enable
    puts "Hirb Loaded"
  rescue LoadError
  end

  begin
    gem 'hirb-unicode'
    require 'hirb/unicode'
    puts "Hirb-unicode loaded"
  rescue LoadError
  end

end

after(:load_application) do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

