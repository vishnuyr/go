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
    assert_difference 'Game.count' do
      post :create, :game => {
        :board_size => 9
      }
    end
    game = Game.last
    assert_response :redirect
    assert_redirected_to game_path(game)
    assert_equal game, @player.games[0]
    assert_equal '', game.reload.players
  end


end
