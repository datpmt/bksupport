class Admins::PhotosController <  Admins::BaseController
  def destroy
    @photo = Photo.find(params[:id])
    product = @photo.product
    @photo.destroy
    respond_to do |format|
      format.html {redirect_to edit_admins_product_path(product), notice: 'Photo was successfully destroyed!'}
    end
  end
end
