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

	def discount(price, sale_off)
		price.to_i*(100-sale_off.to_i)*10
	end

	def show_price(price)
		num = price.to_i
    n=0
    while num/1000 > 1 do
      n+=1
      num=num/1000
    end
    while n > 0
      price.insert(price.length - n*3, ".")
      n-=1
    end
    price
	end
end
