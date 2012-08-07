module SocialNetworkHelper
  def facebook_recommendation(content, options = {})
    content_tag :div do
      html_content = content_tag(:h1, content.html_safe, options)
      html_content += facebook_recommendation_tag
    end
  end

  def facebook_recommendation_tag
    tag :div, :class => 'fb-like show-grid', :data => { :action => "recommend", :font => "lucida grande",
                                              :href => current_page_url,
                                              :layout => "button_count", :send => "false",
                                              :'show-faces' => "true", :width => "450" }
  end
end
