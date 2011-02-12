module Richrc
  class CLI < Thor

    include Thor::Actions

    desc 'customize', 'generate .richrc config file in current path'
    def customize
      default_config = File.expand_path(File.join(__FILE__, "../../../config/default.rb"))
      create_file(".richrc", File.read(default_config))
    end

  end
end
