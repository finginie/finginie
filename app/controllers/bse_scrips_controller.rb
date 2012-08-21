class BseScripsController < InheritedResources::Base
  actions :index, :show
  defaults :resource_class => DataProvider::BseScrip
end
