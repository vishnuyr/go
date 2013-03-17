require 'test_helper'

class GamesControllerTest < ActionController::TestCase

  def setup
    login_user(@player = players(:one))
    @game = games(:one)
  end

  def test_get_new
    get :new
    assert_response :success
  end

  def test_creation
  end

end
