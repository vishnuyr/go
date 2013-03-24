require 'test_helper'

class PlayersControllerTest < ActionController::TestCase

  def test_get_new
    get :new
    assert_response :success
    assert assigns(:player)
    assert_template :new
  end

  def test_creation
    assert_difference 'Player.count' do
      post :create, :player => {
        :username => 'test user',
        :email => 'test@example.com'
      }
      assert_response :redirect
      assert assigns(:player)
      assert_redirected_to player_path(assigns(:player))
    end
  end

end
