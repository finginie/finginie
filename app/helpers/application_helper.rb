module ApplicationHelper
  def table_content_with_red_or_green_class(value)
    if value
      ( value.to_f < 0 ) ? content_tag(:td, number_to_indian_currency(value), :class => "red") : content_tag(:td, number_to_indian_currency(value), :class => "green")
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
end
