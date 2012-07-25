module ChartHelper
  def gchart(options={})
    if options[:data] && !options[:data].empty?
      elements = GoogleChart.new(:data => options.delete(:data), :header => options.delete(:header)).elements
      haml_tag(:div, {:data => { :elements => elements}.merge(options), :class => 'chart', :id => options[:title].parameterize})
    else
      haml_tag :div do
         haml_tag :span, I18n.t('.data_not_available')
      end
    end
  end
end
