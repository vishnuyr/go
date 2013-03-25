class StonesController < ApplicationController

  before_filter :load_game, :only => [:create]
  before_filter :build_stone, :only => [:create]
  before_filter :load_groups, :only => [:create]

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
    # need this because of a bug in haml:
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

  def load_groups
    @groups = Group.all(@game.board_size, @game.stones)
  end

end