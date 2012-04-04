module ApplicationHelper
  def table_content_with_red_or_green_class(value)
    if value
      ( value.to_f < 0 ) ? content_tag(:td, number_to_indian_currency(value), :class => "red") : content_tag(:td, number_to_indian_currency(value), :class => "green")
    end
  end

end
