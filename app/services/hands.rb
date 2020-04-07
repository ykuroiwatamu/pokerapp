module Hands
  # 判定できる値かをvalidで確認
   def valid(cards,suits,numbers,errors)
     #binding.pry
     if cards.length!=5
       #binding.pry
       @errors="era-"
     else
       cards.each do |c|

         #binding.pry
         y = c.split(//)
         #binding.pry
       # suits.push c[0]
       # numbers.push c[1]
       suits << y[0]

       suits.each_with_index do|s,i|
         suit2=s.match(/[S.C.D.H]/)
         #binding.pry
         unless suit2
           @errors="#{i}番目の#{s}は不正です"
           #binding.pry
         end
       end
       numbers << y[1]
       numbers.each_with_index do|n,i|
         numbers2=n.match(/[1-9]|[10-12]/)
         unless numbers2
           @errors="#{i}番目の#{n}は不正です"
         end
       end
     end
     end



     #errors[invalid_〜] =　"〜が不正です"

     #errors << "エラー２"

     # suits.each_with_index do |s,i|
     #   #　不完全
     #   suits2=s.count("A-Z")
     #   if suits2>5
     #     error="エラーです"
     #
     #   else
     #     s.match(/[S.C.D.H]/)
     #     unless suits2
     #       #error=""
     #     end
     #   end
     # end
     # numbers.each do |n|
     #   binding.pry
     #   #numbers2=n.to_i
     #   #"#{numbers3=numbers2.count(/[1-12]/)
     #   #"#{if numbers3>5
     #     #eroor=
     #   #else
     #   numbers2=n.match(/[1-12]/)
     #     unless numbers2
     #       error="dst"
     #     end
     #   end
     end
end

   #errors=error
  #   #要素を５に指定かつ重複禁止

  #     if card.count == 5
  #     end
  #     if card.group_by(&:itself) ==  0
  #     end
  #     card.each do|c|
  #       c.match(/[S.C.D.H][1-12]/)
  #       return false
  #   # 大文字半角指定と数字を１〜１2までに指定nex
  #     end
  #   end
  def straight_flush (card)
    #result =["High_Cards","One_Pair", "Two_Pair",
    #"Three_of_a_Kind", "Straight", "Flush", "Fullhouse", "Four_of_a_Kind", "Straight_Flush"]　　
    # 取得した配列を高順に並べてmapメソッドで連番か判別
    card.each do |c|
      if c.match(/[S.S.S.S.S][D.D.D.D.D][C.C.C.C.C][J.J.J.J.J]/)
        binding.pry
        #連番
        c.sort.reverse.map { |n|n*1  }
        # スートが全て同じか正規表現で判別

        yaku.each do |c|
          #   yaku.match(/[S.S.S.S.S]/) || (/[D.D.D.D.D]/) || (/[C.C.C.C.C]/) || (/[J.J.J.J.J]/)
          # end
            c.match(/[S.S.S.S.S]/) || (/[D.D.D.D.D]/) || (/[C.C.C.C.C]/) || (/[J.J.J.J.J]/)
          puts "ストレートフラッシュ"
        end
      end
    end
  end
  def straight(numbers)
      #binding.pry
    max =numbers.max.to_i
    min =numbers.min.to_i
    if max - min == 4 ||numbers.uniq.count == 0
    puts "true"
    else
      puts "false"
    end
  end
  #suits = [H,H,S,S C]
  def judge_flush(suits)
    if suits.uniq.size == 1
      puts "true"
    else
      puts "false"
    end
  end
  # binding.pry
  def same_judge(numbers)
    same_numbers = numbers.group_by{|r|r}.values.map(&:size).sort.reverse
  end

  # case same_judge
  # when [2, 2, 1]
  #
  #
  #
  # end

  #　配列となった札をスートだけの配列に変換するメソッド
  def convert_to_suit(hand)
    hand.map{ |hand| hand.gsub(/\d/, "")}
  end

  # 配列となった札を数字だけの配列に変換するメソッド
  def convert_to_num(hand)
    hand.map{ |hand| hand.gsub(/[ASDH]/, "")}
  end