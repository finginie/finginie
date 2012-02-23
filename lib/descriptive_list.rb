class DescriptiveList < LevelTaggedList
  def tag_for(item)
    description = item.html_options.delete(:desc)
    description ? super + content_tag('p', description) : super
  end
end
