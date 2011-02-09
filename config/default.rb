# This is equivalent to
# gem 'wirble'
# require 'wirble'
# The code block will be executed only if gem is loaded successfully
gem 'wirble', :require => 'wirble' do
  Wirble.init
  Wirble.colorize
end

gem 'hirb', :require => 'hirb' do
  Hirb.enable
end

# This code block would be execuded after rails environment is loaded
environment do
  # ActiveRecord::Base.logger = Logger.new(STDOUT)
end

