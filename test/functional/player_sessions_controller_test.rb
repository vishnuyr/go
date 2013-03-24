require 'test_helper'

class PlayerSessionsControllerTest < ActionController::TestCase

  def test_get_new
    get :new
    assert_response :success
    assert_template :new
  end

  def test_creation
    player = players(:one)
    post :create, :session => {
      :username => player.username,
      :password => 'passpass'
    }
    assert_response :redirect
    assert_redirected_to player_path(player)
    assert assigns(:player)
    assert_equal players(:one), assigns(:current_user)
  end

  def test_creation_failure
    post :create, :session => {
      :username => 'not a user',
      :password => 'not the password'
    }
    assert_response :success
    assert_equal 'Invalid credentials', flash.now[:error]
    assert !assigns(:player)
  end

  def test_destroy
    login_user(players(:one))
    delete :destroy
    assert_response :redirect
    assert_redirected_to '/'
    assert_nil assigns(:current_user)
  end

end
