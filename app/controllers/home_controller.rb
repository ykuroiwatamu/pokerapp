class HomeController < ApplicationController
  def top
    @content = params[:content]
  end

  def create
    redirect_to :action => 'top', :content => params[:content]
  end
end