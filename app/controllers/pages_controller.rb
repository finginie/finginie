class PagesController < HighVoltage::PagesController
  before_filter :featured_content

  private
  def featured_content
    if params[:id] == 'stock-recommendations' && !current_user
      redirect_to page_path('guest-stocks-picks')
    elsif params[:id] == 'guest-stocks-picks' && current_user
      redirect_to page_path('stock-recommendations')
    end
  end
end
