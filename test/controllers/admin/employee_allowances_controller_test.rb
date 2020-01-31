require 'test_helper'

class Admin::EmployeeAllowancesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_employee_allowances_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_employee_allowances_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_employee_allowances_create_url
    assert_response :success
  end

end
