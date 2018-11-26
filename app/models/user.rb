class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,:confirmable, :lockable, :timeoutable,:recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # belongs_to :division
  # belongs_to :area
  has_one :user_roles

  after_create :set_default_user_roles



  def set_default_user_roles
    user = self.id
    user_role = UserRole.create(:user_id => self.id, is_viewable: true, is_admin: true, is_superadmin: false, is_subadmin: false, rake_load_access: false, one_rake_load_access: false, two_rake_load_access: false, other_load_access: false, rake_unload_access: false, one_rake_unload_access: false, aecs_unload_access: false, gets_unload_access: false, unusual_occurrence_report_access: false)
    
  end
end
