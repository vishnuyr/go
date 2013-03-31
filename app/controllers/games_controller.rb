class GamesController < ApplicationController

  before_filter :build_game, :only => [:new, :create]
  before_filter :load_game, :only => [:show, :join, :pass]

  def index
    @games = Game.all
  end

  def new
  end

  def create
    if params[:color] == 'white'
      @game.white_player_id = current_user.id
    end
    @game.placing_player_id = @game.white_player_id
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
    @groups = Group.all(@game.board_size, @game.stones)
  end

  def join
    if @game.players.count < 2
      @game.players << current_user
      if !@game.white_player_id
        @game.white_player_id = current_user.id 
        @game.placing_player_id = current_user.id
      end
      @game.save
      redirect_to game_path(@game)
    else
      flash[:notice] = 'that game is full'
      redirect_to games_path
    end
  end

  def pass
    if !(@game.placing_player_id == current_user.id)
      render :nothing => true
    else
      @game.placing_player_id = @game.players.select { |p| p.id != current_user.id }.first.id
      @game.save
    end
  end

protected

  def build_game
    @game = Game.new(params[:game])
    @game.players << current_user
  end

  def load_game
    @game = Game.find(params[:id])
  end

end
