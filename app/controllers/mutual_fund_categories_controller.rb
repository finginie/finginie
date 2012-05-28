class MutualFundCategoriesController < InheritedResources::Base
  actions :show

  def resource
    @search = Scheme.new
    @nav_category_detail = NetAssetValueCategory.where(scheme_class_code: params[:id]).first
    @schemes = Scheme.where(class_code: params[:id]).order_by([[:prev_year_percent, :desc]])
    @schemes = @schemes.page(params[:page]).per(10)
    SchemeDecorator.decorate(@schemes)
  end
end
