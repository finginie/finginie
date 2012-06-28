class BlogController < ApplicationController
  def show
    render :text => Net::HTTP.get(URI("#{ENV['BLOG_URI']}/#{params[:path]}")).force_encoding("UTF-8"), :layout => true
  end
end
