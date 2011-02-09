module Richrc
  class CLI < Thor
    include Thor::Actions
    desc 'config', 'generate .richrc config file in current path'
    def config
      default_config = File.expand_path(File.join(__FILE__, "../../../config/default.rb"))
      create_file(".richrc", File.read(default_config))
    end
  end
end
