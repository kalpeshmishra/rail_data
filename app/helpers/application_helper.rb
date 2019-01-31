module ApplicationHelper
	def is_admin
		role = current_user.user_role rescue nil
		flag = role.present? ? role.is_admin : false
	end
	def is_subadmin
		role = current_user.user_role rescue nil
		flag = role.present? ? role.is_admin : false
	end

	def is_viewable
		role = current_user.user_role rescue nil
		flag = role.present? ? role.is_viewable : false
	end
	def is_rake_load_access
		role = current_user.user_role rescue nil
		flag = role.present? ? role.rake_load_access : false
	end

	def is_one_rake_load_access
		role = current_user.user_role rescue nil
		flag = role.present? ? role.one_rake_unload_access : false
	end

	def is_one_rake_load_access
		role = current_user.user_role rescue nil
		flag = role.present? ? role.one_rake_unload_access : false
	end

	def two_rake_load_access
		role = current_user.user_role rescue nil
		flag = role.present? ? role.two_rake_load_access : false
	end

	def other_load_access
		role = current_user.user_role rescue nil
		flag = role.present? ? role.other_load_access : false
	end

	def rake_unload_access
		role = current_user.user_role rescue nil
		flag = role.present? ? role.one_rake_unload_access : false
	end

	def rake_unload_access
		role = current_user.user_role rescue nil
		flag = role.present? ? role.one_rake_unload_access : false
	end

  # def is_one_rake_load_applicable
  #   current_user.user_role.one_rake_load_access
  # end

end
