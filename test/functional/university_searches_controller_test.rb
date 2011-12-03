require 'test_helper'

class UniversitySearchesControllerTest < ActionController::TestCase
  setup do
    @university_search = university_searches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:university_searches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create university_search" do
    assert_difference('UniversitySearch.count') do
      post :create, university_search: @university_search.attributes
    end

    assert_redirected_to university_search_path(assigns(:university_search))
  end

  test "should show university_search" do
    get :show, id: @university_search.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @university_search.to_param
    assert_response :success
  end

  test "should update university_search" do
    put :update, id: @university_search.to_param, university_search: @university_search.attributes
    assert_redirected_to university_search_path(assigns(:university_search))
  end

  test "should destroy university_search" do
    assert_difference('UniversitySearch.count', -1) do
      delete :destroy, id: @university_search.to_param
    end

    assert_redirected_to university_searches_path
  end
end
