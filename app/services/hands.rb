module Hands
  STRENGTH = {
      "straight_flush" => 0,
      "straight" => 1,
      "four of a kind" => 2,
      "full house" => 3,
      "flush" => 4,
      "three of a kind" => 5,
      "two pair" => 6,
      "one pair" => 7,
      "high card" => 8
  }.freeze

  def valid(hand)
    if hand.split(" ").length!=5
      return false
    end
    true
  end
  #　重複確認のvalid
  def valid_duplication(hand)
    unless hand.split(' ').uniq.size ==5
      return false
    end
    return true
  end
  # スートと数字を下で分けて正しい値か確認するvalid
  def valid_matching(hand, error_messages)
    suits, numbers =division_num(hand)
    suits.each_with_index do|s,i|
      suit2=s.match(/[S.C.D.H]/)
      unless suit2
        error_messages << "#{i}番目の#{s}は不正です! 正しい文字を入力してください"
      end
    end

    numbers.each_with_index do|n,i|
      #数字を指定(match)
      numbers2=n.match(/[1-9]|[10-12]/)
      unless numbers2
        error_messages << "#{i}番目の#{n}は不正です! 正しい数字を入力してください"
      end
    end

    if error_messages.present?
      false
    else
      true
    end
  end

  def judge(hand)
    # こいつの返り値が札の判定(ex:"straight")
    suits,numbers = division_num(hand)
    if straight(numbers) && judge_flush(suits)
      result="straight_flush"
      return result
    end

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
  def judge_straight_and_flush(numbers,suits)
    if straight(numbers) && judge_flush(suits)
      true
    else
      false
    end
  end

  def straight(numbers)
    max =numbers.max.to_i
    min =numbers.min.to_i
    if max - min == 4 ||numbers.uniq.count == 1
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


  def division_num(hand)
    suits=[]
    numbers=[]
    hand.split(" ").each do |c|
      suit=c.gsub(/\d/,"")
      suits << suit
      number= c.gsub(/[A-Z]/, "")
      numbers << number
    end
    #binding.pry
    return suits,numbers
  end

  #----------------------------------api　役強さ
  #cardとhandを集約（api用）

  #役の強さに真偽値を返すメソッド
  def judge_strength(results)

      results.each do |result|
        result_num = STRENGTH[result[:hand]]
        strength_num=9
        if strength_num > result_num
           strength_num = result_num
        end
        if strength_num == result_num
          #binding.pry
          result[:best] = true
        else
          result[:best] = false
        end
        #num=result_num
      end
  end

  def api_judge(hand, a_poker_hand, results)
    hands_result = {}
    hands_result[:card]=hand
    hands_result[:hand]=a_poker_hand
    results<<hands_result

    return
  end

  def error_hand(errors,hand,messages)
    messages.each do |message|
      #binding.pry
    hands_error={}
    hands_error[:card]=hand
    hands_error[:msg]=message
    errors<<hands_error
      #binding.pry
    end
  end

end

