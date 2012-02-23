class LevelTaggedList < SimpleNavigation::Renderer::List
  def render(item_container)
    item_container.dom_class = [ item_container.dom_class, "level_#{item_container.level}"].flatten.compact
    super(item_container)
  end
end
