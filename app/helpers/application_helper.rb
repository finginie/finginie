module ApplicationHelper
  def table_content_with_red_or_green_class(value)
    if value
      ( value.to_f < 0 ) ? content_tag(:span, number_to_indian_currency(value), :class => "red") : content_tag(:span, number_to_indian_currency(value), :class => "green")
    end
  end

  def row_for(translate_label, field, objects)
    haml_tag :tr do
      haml_tag(:td, t("#{translate_label}.#{field}"))
      objects.each do |object|
        haml_tag(:td, object.send(field))
      end
    end
  end

  def current_page_path
   request.url
  end

  def red_or_green_class(value, tag)
    value.to_f < 0 ? haml_tag("#{tag}.red", value) : haml_tag("#{tag}.green", value)
  end

  def auto_page_seo_content(translation,default=nil)
    controller_params = params[:controller].gsub('/','.') + '.'
    action_params = params[:action] + '.'
    id_params  = params[:id] ? (params[:id].gsub('/', '.') + '.') : ''
    I18n.t  (controller_params + action_params +id_params + translation).to_sym,
            :default => [
              (controller_params + action_params + translation).to_sym,
              (controller_params + translation ).to_sym,
              (translation).to_sym
            ],
            :name => default
  end

  def navigation_link(name, path)
    class_name = current_page?(path) ? 'active' : ''
    content_tag(:li, :class => class_name) do
      link_to name, path
    end
  end

end
