class PlayerSessionsController < ApplicationController

  skip_before_filter :require_login, :except => [:destroy]

  def new
    render
  end

  def create
    if @player = login(params[:session][:username], params[:session][:password])
      redirect_to player_path(@player)
    else
      flash.now[:error] = 'Invalid credentials'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

end
