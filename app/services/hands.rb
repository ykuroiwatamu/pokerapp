module Hands
  # 要素数をしていいするvalid
  def valid(hand,errors)
    cards = hand.split(" ")
     if cards.length!=5
       @errors="カードは５枚です"
     end
    return cards
  end
  #　重複確認のvalid
  def valid_duplication(cards,errors)
       unless cards.uniq.size ==5
       @errors="同じカードはだめ"
       end
  end
       # スートと数字を下で分けて正しい値か確認するvalid
  def valid_match(cards,errors)
    suits, numbers =division_num(cards)
    #binding.pry
    #binding.pry
    # suits=[]
    #  cards.each do |c|
    #      y = c.split(//)
    #    #スート
    #    suits << y[0]
    #    #アルファベットを指定(match)
       suits.each_with_index do|s,i|
         suit2=s.match(/[S.C.D.H]/)
         unless suit2
           @errors="#{i}番目の#{s}は不正です! 正しい文字を入力してください"
         end
       end
       #   #binding.pry
       # numbers << y[1]
       # #数字
       numbers.each_with_index do|n,i|
       #数字を指定(match)
         numbers2=n.match(/[1-9]|[10-12]/)
         unless numbers2
           #binding.pry
           @errors="#{i}番目の#{n}は不正です! 正しい数字を入力してください"
           #binding.pry
       end
       end
    return suits, numbers
     end

  def straight(numbers)
      #binding.pry
    max =numbers.max.to_i
    min =numbers.min.to_i
    if max - min == 4 ||numbers.uniq.count == 0
      @result="straight"
    else
      false
    end
  end
  #suits = [H,H,S,S C]
  def judge_flush(suits)
    if suits.uniq.size == 1
      @result="flush"
    else
      false
    end
  end
  # binding.pry
  def same_judge(numbers)
    same_numbers = numbers.group_by{|r|r}.values.map(&:size).sort.reverse
    #binding.pry
  case same_numbers
  when [2, 2, 1]
    @result="ツーペア"
  when [2,1,1,1]
    @result="ワンペア"
  when [3,1,1]
    @result="スリー・オブ・ア・カインド"
  when [3,2]
    @result="フルハウス"
  when [4,1]
    @result="フォー・オブ・ア・カインド"
  else
    @result="ハイカード"
  end
  end


    #　配列となった札をスートだけの配列に変換するメソッド
  # def convert_to_suit(hand)
  #   hand.map{ |hand| hand.gsub(/\d/, "")}
  # end
  #
  # # 配列となった札を数字だけの配列に変換するメソッド
  # def convert_to_num(hand)
  #   hand.map{ |hand| hand.gsub(/[ASDH]/, "")}
  # end
  def division_num(cards)
    suits=[]
    numbers=[]
    cards.each do |c|
      y = c.split(//)
      #スート
       suits << y[0]
       numbers << y[1]
    end
    return suits, numbers
  end
end
