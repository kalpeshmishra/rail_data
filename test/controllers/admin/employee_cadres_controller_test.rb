require 'test_helper'

class Admin::EmployeeCadresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_employee_cadres_index_url
    assert_response :success
  end

end
