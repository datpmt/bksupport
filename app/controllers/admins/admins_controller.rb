class Admins::AdminsController < Admins::BaseController
  before_action :set_admin, only: [:edit, :update, :destroy]
  def index
    @pagy, @admins = pagy(Administrator.all.order(id: :asc), items: 10, link_extra: 'data-remote="true"')
    if params[:search]
      @pagy, @admins = pagy(Search.new(Administrator.all).search(params[:search]), items: 10, link_extra: 'data-remote="true"')
    elsif params[:sort]
      @pagy, @admins = pagy(Sort.new(Administrator.all).sort(params[:sort]), items: 10, link_extra: 'data-remote="true"')
      @class_sort = params[:sort]
      respond_to do |format|
        format.html { redirect_to admins_admins_path }
        format.js
      end
    elsif params[:sort_contra]
      @pagy, @admins = pagy(Sort.new(Administrator.all).sort_contra(params[:sort_contra]), items: 10, link_extra: 'data-remote="true"')
      @class_sort_contra = params[:sort_contra]
      respond_to do |format|
        format.html { redirect_to admins_admins_path }
        format.js
      end
    end
  end

  def new
    @admin = Administrator.new

  end

  def create
    @admin = Administrator.new(admin_params)
    if @admin.save
      flash[:success] = "Admin created successful!"
      redirect_to admins_admins_path
    else
      flash[:error] = "Admin created failed!"
      render :new
    end
  end

  def edit
  end

  def update
    if @admin.update(admin_params)
      flash[:success] = "Admin updated successful!"
      redirect_to admins_admins_path
    else
      flash[:error] = "Admin updated failed!"
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admins_admins_path
    end
  end

  private

  def admin_params
    params.require(:administrator).permit(:email, :status, :password)
  end

  def admin_params_update
    params.require(:administrator).permit(:email, :status)
  end

  def set_admin
    @admin = Administrator.find(params[:id])
  end
end