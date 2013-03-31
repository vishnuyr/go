class CommentsController < ApplicationController

  before_filter :load_game, :only => [:create]
  before_filter :build_comment, :only => [:create]

  def create
    @comment.save!
  end

  protected
  
  def load_game
    @game = Game.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.now[:error] = 'Something went wrong with that game!'
    redirect_to player_path(current_user)
  end

  def build_comment
    @comment = @game.comments.new(params[:comment])
    @comment.player = current_user
  end

end
