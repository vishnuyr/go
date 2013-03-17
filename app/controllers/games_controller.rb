class GamesController < ApplicationController

  before_filter :build_game, :only => [:new, :create]

  def new
  end

  def create
    @game.save!
    redirect_to game_path(@game)
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Game creation failed. Please correct highlighted fields'
    render :action => :new
  end

protected

  def build_game
    @game = current_user.games.build(params[:game])
  end

end
