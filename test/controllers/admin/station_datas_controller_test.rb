require 'test_helper'

class Admin::StationDatasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_station_datas_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_station_datas_new_url
    assert_response :success
  end

end
