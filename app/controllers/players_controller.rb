class PlayersController < ApplicationController

  skip_before_filter :require_login, :only => [:new, :create]
  before_filter :build_player, :only => [:new, :create]
  before_filter :load_player, :only => [:show, :edit, :update, :destroy]

  def show
  end

  def new
  end

  def create
    @player.save!
    auto_login(@player)
    redirect_to player_path(@player)
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Registration failed. Please correct highlighted fields'
    render :action => :new
  end

  def edit
  end


protected

  def build_player
    @player = Player.new(params[:player])
  end

  def load_player
    @player = current_user
  end

end
