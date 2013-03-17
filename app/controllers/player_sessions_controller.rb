class PlayerSessionsController < ApplicationController

  skip_before_filter :require_login, :except => [:destroy]
  
  def new
    render
  end
  
  def create
    if login(params.dig(:session, :email), params.dig(:session, :password), true)
      redirect_to root_path
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
