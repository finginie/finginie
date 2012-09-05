module ApplicationHelper
  def social_network_link(icon, url, &block)
    content = link_to url, { 'data-toggle' => 'modal' } do
      image_tag icon
    end
    content += capture(&block) if block_given?

    content
  end

  def airbrake_javascript_notifier
    host = Airbrake.configuration.host.dup
    port = Airbrake.configuration.port
    host << ":#{port}" unless [80, 443].include?(port)

    javascript_tag %Q[
      window.AirbrakeKey =  '#{Airbrake.configuration.js_api_key}';
      window.AirbrakeHost = '#{host}';
      window.controller_name = '#{params[:controller]}';
      window.action_name = '#{params[:action]}';
    ]
  end

  def rg_colorize(content, value = content.to_f)
    content_tag :span, content, :class => (value < 0 ? :red : :green)
  end

  def row_for(translate_label, field, objects)
    haml_tag :tr do
      haml_tag(:td, t("#{translate_label}.#{field}"))
      objects.each do |object|
        haml_tag(:td, object.send(field))
      end
    end
  end

  def link_to_with_data_role(name, path, *args)
    data_role = {:data => {:role => path.parameterize}}
    if args.first
      args.first[:data] ? args : args << {:data => {:role => path.parameterize}}
    else
      args << data_role
    end
    link_to(name, path, *args)
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
      link_to_with_data_role name, path
    end
  end

  def url_with_complete_path(relative_url)
    host + relative_url
  end

  def current_page_url
    host + request.path
  end

  def host
    'http://' + request.host_with_port
  end

end
