class HomeController < ApplicationController
  ## app/services/hands.rbの呼び出している
  include Hands
  def top
    @content = params[:content]
  end

  def check
    @hand = params[:content]
    @errors=[]

    unless judge_Half_width_space(@hand)
      #b
      @errors << "5つのカード指定文字を半角スペース区切りで入力してください"
    end

    unless judge_duplication(@hand)
      @errors << "カードが重複しています"
      end
    error_messages=[]

    unless judge_matching(@hand, error_messages)
      @errors << error_messages
    end

    unless @errors.empty?
      #binding.pry
      render action:"top" and return
    end

    ## 札の判定
    #binding.pry
    @result=judge(@hand)
    #binding.pry
    render action:"top"
  end
end







