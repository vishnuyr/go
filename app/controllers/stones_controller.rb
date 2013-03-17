class StonesController < ApplicationController

  before_filter :load_game, :only => [:create, :index]
  before_filter :build_stone, :only => [:create]

  def index
  end

  def create
    @stone.save!
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Stone placement failed. Try again'
  end

protected
  
  def load_game
    @game = Game.find(params[:id])
  end

  def build_stone
    @stone = Stone.new(params[:stone])
    @stone.game = @game
    @stone.player = current_user
    @stone.is_white = @game.white_player_id == current_user.id
  end

end
