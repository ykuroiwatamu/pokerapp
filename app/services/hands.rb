module Hands
  STRENGTH = {
      "straight" => 1,
      "four of a kind" => 2,
      "full house" => 3,
      "flush" => 4,
      "straight" => 5,
      "three of a kind" => 6,
      "two pair" => 7,
      "one pair" => 8,
      "high card" => 9
  }.freeze
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
  def valid_matching(cards,errors)
    suits, numbers =division_num(cards)
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

  def judge(numbers, suits, result)
    # こいつの返り値が札の判定(ex:"straight")
    if straight(numbers)
      result="straight"
      return result
    else
      if judge_flush(suits)
        result="flush"
        return result
      else
        if a_poker_hand=same_judge(numbers)
          result=a_poker_hand
          return result
        end
      end
    end
  end

  def straight(numbers)
    #binding.pry
    max =numbers.max.to_i
    min =numbers.min.to_i
    if max - min == 4 ||numbers.uniq.count == 0
      true
    else
      false
    end
  end
  #suits = [H,H,S,S C]
  def judge_flush(suits)
    if suits.uniq.size == 1
      true
    else
      false
    end
  end
  def same_judge(numbers)
    same_numbers = numbers.group_by{|r|r}.values.map(&:size).sort.reverse
    #binding.pry
  case same_numbers
  when [2, 2, 1]
    a_poker_hand="two pair"
  when [2,1,1,1]
    a_poker_hand="one pair"
  when [3,1,1]
    a_poker_hand="three of a kind"
  when [3,2]
    a_poker_hand="full house"
  when [4,1]
    a_poker_hand="four of a kind"
  else
    a_poker_hand="high card"
  end
    return a_poker_hand
  end
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

  #----------------------------------api　役強さ

  def rank
    strength={}.freeze
  end
  #cardとhandを集約（api用）

  #役の強さに真偽値を返すメソッド
  def judge_strength(results,result)

      results.each do |result|
        result_num = STRENGTH[result[:hand]]
        strength_num=9
        #binding.pry
        if strength_num > result_num
           strength_num = result_num
          #binding.pry
        end
        if strength_num == result_num
          result[:best] = true
        else
          result[:best] = false
          # binding.pry
        end
        return result[:best]
      end
  end

  def api_judge(hand, a_poker_hand, results)
    hands_result = {}
    hands_result[:card]=hand
    hands_result[:hand]=a_poker_hand
    results<<hands_result

    return
  end

end
