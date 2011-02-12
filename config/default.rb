before(:setup_bundler) do
  # You can load extra gems here.

  require 'irb'

  begin
    gem 'wirble'
    require 'wirble'
    Wirble.init
    Wirble.colorize
  rescue LoadError
    puts "Failed to load wirble"
  end

  begin
    gem 'hirb'
    require 'hirb'
    Hirb.enable
  rescue LoadError
    puts "Failed to load hirb"
  end

end

after(:load_application) do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

