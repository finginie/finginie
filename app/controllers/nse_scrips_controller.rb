class NseScripsController < InheritedResources::Base
  actions :index, :show
  defaults :resource_class => DataProvider::NseScrip
end
