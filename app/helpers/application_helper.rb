module ApplicationHelper
  include Pagy::Frontend
  def svg(name)
	  file_path = "#{Rails.root}/app/assets/images/#{name}.svg"
	  return File.read(file_path).html_safe if File.exists?(file_path)
	  '(not found)'
	end

	def fallback_svg(name)
	  file_path = "#{Rails.root}/app/assets/images/#{name}.svg"
	  return File.read(file_path).html_safe if File.exists?(file_path)
	  fallback_path = "#{Rails.root}/app/assets/images/png/#{name}.png"
	  return image_tag("png/#{name}.png") if File.exists?(fallback_path)
	  '(not found)'
	end

  def show_svg(file_path)
    file_path = "#{Rails.root}/public/#{file_path}"
    return File.read(file_path).html_safe if File.exists?(file_path)
    '(not found)'
  end

	def bg_active_color(name)
		request.original_url.include?(name) ? "bg-color-active" : "bg-base"
	end

	def discount(product)
		price		 = product.price
		sale_off = product.sale_off
		price.to_i*(100-sale_off.to_i)/100
	end

end
