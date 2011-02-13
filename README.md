# RichRC

RichRC (Rich Rails Console) is a customization tool for Rails 3 console.

There are some useful gems which extends function of IRB and makes IRB more convenient. For example, [hirb](https://github.com/cldwalker/hirb) and [wirble](http://pablotron.org/software/wirble/) are excellent gems which makes data more readable. In rails 2, we can simply require gems in IRB.

However, In Rails 3, it's needed to add gems into `Gemfile` before using them. Sometimes it doesn't make sense to add IRB-extension gems into `Gemfile`. Maybe not all developers want hirb and wirble, and it's quite annoying to edit files whenever cloning a project.

Inspired from [xdite's article](http://blog.xdite.net/?p=1839), the extra gems cloud be loaded before `Bundler.setup` is invoked. RichRC mimics the bootstrap process of rails console, run extra code before or after specified event (such as `bundler.setup`).

## Installation

    $ gem install richrc hirb wirble

P.S. RichRC loads hirb and wirble by default, but RichRC doesn't have dependency to these gems. If you don't want them, read **Customization** section.

## Quick Start

Though RichRC provides customization, you can simply start with default configuration:

    $ cd railsapp
    $ richrc # instead of `rails console`

This will automatically:

* Enables `wirble` gem
* Enables `hirb` gem
* Makes ActiveRecord log outputted in console

P.S. The original rails console is not affected. If problems occured with RichRC, you can fallback to `rails console`.

## Customization

When running `richrc`, it try to load configuration file in following sequence:

* `.richrc` in current directory
* `.richrc` in user's home directory
* The default configuration file in richrc gem

Run `richrc customize` to copy default configuration file to `.richrc` into your current directory:

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

If you want to load any extra gems, write in `before(:setup_bundler)` section. After that, the gem loading process is controlled by bundler. If you want to do any setting to rails, Write in `after(:load_application)` section, which ensures rails and application environment is loaded.

## Notice

Loading a gem which conflict with gems (and their dependencies) in `Gemfile` will cause problem.

## Issue Report

Fell free to report issues in Github's issue tracker. If it's an error report, I strongly recommand to write your `Gemfile` and `.richrc` in your issue.

## License

See MIT-LICENSE file for details.

