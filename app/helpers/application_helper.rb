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

  def current_page_url
    host + request.path
  end

  def host
    'http://' + request.host_with_port
  end

  def facebook_share_url(hsh)
    ENV['FACEBOOK_SHARE_DIALOG_URL'] + fb_share_query_params(hsh)
  end

  def public_financial_profile_fb_hsh
    {
      :link => public_financial_profile_url(current_user),
      :name => t('facebook_share.public_portfolio.name', :user_slug => current_user.slug_name),
      :description => t('facebook_share.public_portfolio.description'),
      :redirect_uri => facebook_callback_url(current_page_url, PointTracker::ShareFinancialProfileOnFbStep)
    }
  end

  def quiz_details_fb_hsh(score, ids)
    {
      :link => new_response_url(:question_ids => ids.join('-')) ,
      :name => t('facebook_share.learning_tool.quiz_name'),
      :description => t('facebook_share.learning_tool.quiz_description', :score => score, :questions => Response::QUIZ_LIMIT),
      :redirect_uri => facebook_callback_url(responses_url, PointTracker::ShareQuizDetailsOnFbStep)
    }
  end

  private
  def facebook_callback_url(return_url, step)
    social_network_facebook_callback_url(:return_to => return_url, :step => step)
  end

  def fb_share_query_params(hsh)
    {
      :app_id => ENV['FACEBOOK_KEY'],
      :picture => host + '/assets/logo.png'
    }.merge(hsh).to_query
  end
end
