require 'test_helper'

class StonesControllerTest < ActionController::TestCase

  def setup
    login_user(@player = players(:one))
    @game = games(:one)
  end

  def test_creation
    @game.update_column(:placing_player_id, @player.id)
    @game.players << @player
    @game.players << players(:two)
    @game.white_player_id = @player.id

    @game.save
    xhr :post, :create, {
      :id => @game.id, 
      :stone => {
        :x_position => 1,
        :y_position => 2
      }
    }
    assert_response :success
    assert assigns(:stone)
    assert_equal @player, assigns(:stone).player
    assert_equal @game, assigns(:stone).game
    assert_equal true, assigns(:stone).is_white
    assert_equal 1, assigns(:stone).x_position
    assert_equal 2, assigns(:stone).y_position
  end

  def test_creation_with_one_player
    flunk
  end

  def test_creation_failure_with_bad_game
    @game.white_player_id = @player.id
    @game.save
    xhr :post, :create, {:id => 'crap id'}
    assert_response :redirect
    assert_redirected_to player_path(@player)
    assert_equal 'Something went wrong with that game!', flash.now[:error]
  end

end
