class HomeController < ApplicationController
  ## app/services/hands.rbの呼び出している
  include Hands
  def top
    @content = params[:content]
 end
  def create
    hand = params[:content]
    cards = hand.split(" ")
    #unless cards.length==5
      error=""
      #else
    suits = []
    numbers =[]
    @errors ={}
    #binding.pry
    valid(cards,suits,numbers,@errors)
    #straight(numbers)
    judge_flush(suits)
    #counter(numbers)

    # handモジュールのvalidationメソッドを呼び出している
    # hand.each do|h|
    #   validation ()
    #
    # end

    redirect_to :action => 'top', :content => params[:content] and return

  end
end





