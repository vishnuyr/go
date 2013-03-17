class GamesController < ApplicationController

  before_filter :build_game, :only => [:new, :create]
  before_filter :load_game, :only => [:show]

  def new
  end

  def create
    if params[:color] == 'white'
      @game.white_player_id = current_user.id
    end
    @game.save!
    redirect_to game_path(@game)
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Game creation failed. Please correct highlighted fields'
    render :action => :new
  end

  def show
    if @game.white_player_id
      @white_player = @game.players.select {|p| p.id == @game.white_player_id}.first
    end
  end

protected

  def build_game
    @game = Game.new
    @game.players << current_user
  end

  def load_game
    @game = Game.find(params[:id])
  end

end
