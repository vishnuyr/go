class GamesController < ApplicationController

  before_filter :build_game, :only => [:new, :create]
  before_filter :load_game, :only => [:show]

  def new
  end

  def create
    @game.save!
    redirect_to game_path(@game)
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Game creation failed. Please correct highlighted fields'
    render :action => :new
  end

  def show
  end

protected

  def build_game
    @game = current_user.games.build(params[:game])
  end

  def load_game
    @game = Game.find(params[:id])
  end

end
