class ApplicationController < ActionController::Base

	def after_sign_out_path_for(resource)
		new_user_session_path
	end

	def after_sign_in_path_for(resource)
		case resource
		when Author
			new_shop_path
		when User
			root_path
		end
	end
end
