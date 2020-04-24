class HomeController < ApplicationController
  ## app/services/hands.rbの呼び出している
  include Hands
  def top
    @content = params[:content]
 end
  def create
    #binding.pry
    @hand = params[:content]

    #binding.pry
    unless valid(@hand)
      @errors = "カードは５枚です"
      render action:"top" and return
    end

    unless valid_duplication(@hand)
      @errors="同じカードは不正です"
      render action:"top" and return
    end

    error_messages = []
    ## [TODO]名前変えておいて
    ## valid_matchingに引っかかると、返り血がfalseとなり、引数として渡したerror_messagesにエラーが格納される
    unless valid_matching(@hand, error_messages)
      @errors = error_messages
      render action:"top" and return
    end

    ## 札の判定
    @result=judge(@hand)
    render action:"top" and return
  end
end





