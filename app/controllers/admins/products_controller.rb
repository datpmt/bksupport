class Admins::ProductsController < Admins::BaseController
  before_action :set_product, only: [:edit, :update, :destroy]
  def index
    @pagy, @products = pagy(Product.all.order(id: :asc), items: 10, link_extra: 'data-remote="true"')
    if params[:search]
      @pagy, @products = pagy(Search.new(Product.all).search(params[:search]), items: 10, link_extra: 'data-remote="true"')
    elsif params[:sort]
      @pagy, @products = pagy(Sort.new(Product.all).sort(params[:sort]), items: 10, link_extra: 'data-remote="true"')
      @class_sort = params[:sort]
      respond_to do |format|
        format.html { redirect_to admins_products_path }
        format.js
      end
    elsif params[:sort_contra]
      @pagy, @products = pagy(Sort.new(Product.all).sort_contra(params[:sort_contra]), items: 10, link_extra: 'data-remote="true"')
      @class_sort_contra = params[:sort_contra]
      respond_to do |format|
        format.html { redirect_to admins_products_path }
        format.js
      end
    end
  end

  def new
    @product = Product.new
    @photo = @product.photos.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      if params[:photos].nil?
        flash[:error] = "Images can't be blank!"
        render :new
      else
        params[:photos]['photo'].each do |a|
          @photo = @product.photos.create!(:photo => a)
        end
        flash[:success] = 'Product created successful!'
        redirect_to admins_products_path
      end
    else
      flash[:error] = 'Product created failed!'
      render :new
    end
  end

  def edit
    @photos = @product.photos.all
  end

  def update
    if @product.update(product_params)
      if params[:photos].nil? && @product.photos.all.empty?
        flash[:error] = "Images can't be blank!"
        render :edit
      else
        if !params[:photos].nil?
          params[:photos]['photo'].each do |a|
            @photo = @product.photos.create!(:photo => a)
          end
        end
        flash[:success] = 'Product updated successful!'
        redirect_to admins_products_path
      end
    else
      flash[:error] = 'Product updated failed!'
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:sucess] = 'Product destroyed successful!'
      redirect_to admins_products_path
    else
      flash[:error] = 'Product destroyed failed!'
      redirect_to admins_products_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :quantity, :short_des, :sale_off, :description, :city_id, photos_attributes: [:id, :product_id, :photo])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end