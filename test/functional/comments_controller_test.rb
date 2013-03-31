require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  def setup
    @game = games(:one)
    login_user(@player = players(:one))
  end

  def test_creation
    assert_difference 'Comment.count' do
      xhr :post, :create, {
        :id => @game.id, 
        :comment => {
          :content => 'a comment'
        }
      }
    end
    assert_equal 'a comment', @game.comments.last.content
  end

  def test_creation_failure_to_load_game
    assert_no_difference 'Comment.count' do
      xhr :post, :create, {
        :id => 'not an id', 
        :comment => {
          :content => 'a comment',
          :player_id => @player.id
        }
      }
    end
    assert_response :redirect
    assert_redirected_to player_path(@player)
    assert_equal 'Something went wrong with that game!', flash.now[:error]
  end

end
