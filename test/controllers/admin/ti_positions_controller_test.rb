require 'test_helper'

class Admin::TiPositionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_ti_positions_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_ti_positions_new_url
    assert_response :success
  end

end
