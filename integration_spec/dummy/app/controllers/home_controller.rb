class HomeController < ApplicationController
  def index
    @from_the_ivars = 'Hello from the controller ivars'
  end

  def show
    @loop_it = params[:id].to_i
  end
end
