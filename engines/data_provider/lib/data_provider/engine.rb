module DataProvider
  class Engine < ::Rails::Engine
    config.autoload_paths << File.expand_path("../..", __FILE__)
    isolate_namespace DataProvider
  end
end
