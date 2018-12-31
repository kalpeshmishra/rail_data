module ApplicationHelper


  def is_one_rake_load_applicable
    current_user.user_role.one_rake_load_access
  end

end
