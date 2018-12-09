class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_out_path_for(resource)
		new_user_session_path
	end

	def after_sign_in_path_for(resource)
		case resource
		when Author
			author_path(current_author.id)
		when User
			root_path
		end
	end

	protected

		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :introduce, :profile_image])
		end
end
