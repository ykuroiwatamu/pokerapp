class HomeController < ApplicationController
  ## app/services/hands.rbの呼び出している
  include Hands
  def top
    @content = params[:content]
 end
  def create
    hand = params[:content]
    #binding.pry
    #unless cards.length==5
    cards=[]
    @errors ={}
    @result ={}
    #binding.pry
    cards=valid(hand,@errors)
    valid(hand,@errors)
    if @errors!={}
      render action:"top" and return
    end
    if valid_duplication(cards,@errors)
      render action:"top" and return
    end
    suits, numbers = valid_match(cards,@errors)
    if @errors!={}
      render action:"top" and return
    end
    #binding.pry
    #binding.pry
    if straight(numbers)
      render action:"top" and return
      end

    if judge_flush(suits)
      render action:"top" and return
    end
    #binding.pry
    same_judge(numbers)
    @content = params[:content]
    render action:"top"

    #edirect_to :action => 'top', :content => params[:content] and return

  end
  end





