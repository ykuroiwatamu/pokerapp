class HomeController < ApplicationController
  ## app/services/hands.rbの呼び出している
  include Hands
  def top
    @content = params[:content]
 end
  def create
    hand = params[:content]
    cards=[]
    @errors ={}
    @result ={}
    result=[]

    cards=valid(hand,@errors)
    valid(hand,@errors)
    if @errors!={}
      render action:"top" and return
    end
    if valid_duplication(cards,@errors)
      render action:"top" and return
    end
    suits, numbers = valid_matching(cards,@errors)
    if @errors!={}
      render action:"top" and return
    end
      @result=judge(numbers, suits, result)
      render action:"top" and return
     @content = params[:content]
    render action:"top"
  end
end





