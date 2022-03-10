class Admins::Auths::PasswordsController < Devise::PasswordsController
	layout 'admin'
	protected
	def after_resetting_password_path_for(resource)
		admins_admins_path
	end
end
