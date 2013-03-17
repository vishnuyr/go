require 'test_helper'

class StonesControllerTest < ActionController::TestCase

  def setup
    login_user(@player = players(:one))
    @game = games(:one)
  end

  def test_get_index
    get :index, :id => @game
    assert_response :success
  end

  def test_creation
    @game.white_player_id = @player.id
    @game.save
    xhr :post, :create, {:id => @game.id}
    assert_response :success
    assert assigns(:stone)
    assert_equal @player, assigns(:stone).player
    assert_equal @game, assigns(:stone).game
    assert_equal true, assigns(:stone).is_white
  end


end
