class StonesController < ApplicationController

  before_filter :load_game, :only => [:create]
  before_filter :build_stone, :only => [:create]

  def create
    @stone.save!
    @groups = Group.all(@game.board_size, @game.stones, @stone)
  end

protected
  
  def load_game
    @game = Game.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.now[:error] = 'Something went wrong with that game!'
    redirect_to player_path(current_user)
  end

  def build_stone
    # need this line because of a bug in haml:
    # http://stackoverflow.com/questions/15468161/dynamic-table-with-data-attributes
    # remove after haml upgrade
    params[:stone][:y_position] = params[:stone][:x_position] if !params[:stone][:y_position]

    if @game.stones.any? { |s| s.x_position == params[:stone][:x_position].to_i && s.y_position == params[:stone][:y_position].to_i }
      @groups = Group.all(@game.board_size, @game.stones)
      render
    else
      @stone = Stone.new(params[:stone])
      @stone.game = @game
      @game.stones << @stone
      @stone.player = current_user
      @stone.is_white = @game.white_player_id == current_user.id
    end
  end

end