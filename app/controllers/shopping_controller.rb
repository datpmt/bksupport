class ShoppingController < ActionController::Base
  include Pagy::Backend
  layout 'application'
  def index
    @pagy, @products = pagy(Product.all.order(id: :asc), items: 9, link_extra: 'data-remote="true"')
    if params[:search]
      @pagy, @products = pagy(Search.new(Product.all).search(params[:search]), items: 9, link_extra: 'data-remote="true"')
    elsif params[:sort]
      @pagy, @products = pagy(Sort.new(Product.all).sort(params[:sort]), items: 9, link_extra: 'data-remote="true"')
      @class_sort = params[:sort]
      respond_to do |format|
        format.js
      end
    elsif params[:sort_contra]
      @pagy, @products = pagy(Sort.new(Product.all).sort_contra(params[:sort_contra]), items: 9, link_extra: 'data-remote="true"')
      @class_sort_contra = params[:sort_contra]
      respond_to do |format|
        format.js
      end
    end
  end
end
