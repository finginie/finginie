class DescriptiveList < SimpleNavigation::Renderer::List
  def tag_for(item)
    description = item.html_options.delete(:desc)
    description ? super + content_tag('p', description) : super
  end
end
