module Hands
  #役の強さを数字で表している
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
  #半角スペースで５枚かのvalid
  def judge_Half_width_space(hand)
     if hand.split(" ").length!=5
       return false
     end
    true
  end
  #重複確認のvalid
  def judge_duplication(hand)
    #binding.pry
    unless hand.split(" ").count == hand.split(" ").uniq.count
      return false
    end
    true
  end
  # スートと数字を下で分けて正しい値か確認するvalid
  def judge_matching(hand, error_messages)
    suits, numbers =division_num(hand)
    #binding.pry
    suits.each.with_index(1) do|s,i|
      suit=s.match(/[S.C.D.H]/)
      unless suit
        error_messages << "#{i}番目の#{s}は不正です! 正しい文字を入力してください"
      end
    end

    numbers.each.with_index(1) do|n,i|
      #数字を指定(match)
      number=n.match(/\A([1][0-3]|[1-9])\z/)
      #binding.pry
      unless number
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
    suits,numbers = division_num(hand)
    #straight flush,straight,flushは判定が類似しているうため条件分岐で処理
    if straight(numbers) && judge_flush(suits)
      return "straight_flush"
    elsif straight(numbers)
      return "straight"
    elsif judge_flush(suits)
      return "flush"
    end
    #それ以外の役についいてはsame_judgeメソッドで処理
    if a_poker_hand = same_judge(numbers)
      return a_poker_hand
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
      "two pair"
    when [2,1,1,1]
      "one pair"
    when [3,1,1]
      "three of a kind"
    when [3,2]
      "full house"
    when [4,1]
      "four of a kind"
    else
      "high card"
    end
  end

  #スートと数字を分けルためにdivision_numメソッドを作成
  def division_num(hand)
    suits = hand.split(" ").inject([]) {|suits, hand| suits << hand.gsub(/\d/,"")}
    numbers = hand.split(" ").inject([]) {|numbers, hand| numbers << hand.gsub(/[a-zA-Z]/, "")}
    #binding.pry
    return suits,numbers
  end

  #----------------------------------api　役強さ

  #役の強さに真偽値を返すメソッド
  def judge_strength(results)
    strength_num=9

      results.each do |result|
        result[:rank]= STRENGTH[result[:hand]]
        if strength_num > result[:rank]
           strength_num = result[:rank]
        end
        end
        results.each do|result|
        if strength_num == result[:rank]
          result[:best] = true
        else
          result[:best] = false
        end
      end
  end

  #役結果
  def api_judge(hand, a_poker_hand, results)
    hands_result = {}
    hands_result[:card]=hand
    hands_result[:hand]=a_poker_hand
    results<<hands_result

    return
  end
  #エラー文
  def error_hand(errors,hand,messages)
    messages.each do |message|
    hands_error={}
    hands_error[:card]=hand
    hands_error[:msg]=message
    errors<<hands_error
    end
  end
end


