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

      }, :color => 'white'
    end
    game = Game.last
    assert_response :redirect
    assert_redirected_to game_path(game)
    assert_equal game, @player.games.last
    assert_equal @player.id, game.white_player_id
  end

  def test_get_show
    @game.players << @player
    @game.white_player_id = @player.id
    @game.save
    get :show, :id => @game
    assert_response :success
    assert assigns(:white_player)
  end

  def test_join
    assert_equal 0, @game.players.count
    assert_difference '@game.players.count' do
      post :join, {:id => @game}
      assert_equal @player, @game.players.last
    end
  end

  def test_join_failure
    player1 = Player.create({
      :username => 'player one',
      :email => 'player@one.com'
    })
    player2 = Player.create({
      :username => 'player two',
      :email => 'player@two.com'
    })
    @game.players << player1
    @game.players << player2
    @game.save
    assert_no_difference '@game.players.count' do
      post :join, {:id => @game}
      assert_equal player2, @game.players.last
      assert_equal 'that game is full', flash[:notice]
      assert_response :redirect
      assert_redirected_to games_path
    end
  end

end
