class GamesController < ApplicationController

  before_filter :build_game, :only => [:new, :create]
  before_filter :load_game, :only => [:show, :join]
  before_filter :build_groups, :only => [:show]

  def index
    @games = Game.all
  end

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

  def join
    if @game.players.count < 2
      @game.players << current_user
      @game.white_player_id = current_user.id if !@game.white_player_id 
      @game.save
      redirect_to game_path(@game)
    else
      flash[:notice] = 'that game is full'
      redirect_to games_path
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

  def build_groups
    # groups = Group.group_stones(@game.board_size, @game.stones)
  end

end
