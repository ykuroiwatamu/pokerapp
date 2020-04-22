module Ver1
  class Poker < Grape::API
    helpers do
      include Hands
      #binding.pry
    end

    #リクエスト指定のバリデーション
    content_type :json, 'application/json'
    format :json
    #cardsを配列で受け取れるように指定
    params do
      requires :cards, type: Array
    end
    #役判定のロジック
    post 'poker/check' do

      hands = params[:cards]
      results=[]
      errors =[]
      hands.each do |hand|
        messages={}
        error_messages = []
        unless valid(hand)
          messages="カードは５枚です"
          error_hand(errors,hand,messages)
          next
        end

        unless valid_duplication(hand)
          messages="同じカードはだめ"
          error_hand(errors,hand,messages)
          next
        end
        unless valid_matching(hand,error_messages)
          messages=error_messages
          error_hand(errors,hand,messages)
          next
        end
        a_poker_hand=judge(hand)
        api_judge(hand, a_poker_hand,results)
        end
        judge_strength(results)
      #binding.pry
      if results.present? && errors.present?
       {
          "result":results,
      "error":errors
      }

       elsif results.present?
        {
            "result":results
        }
      elsif errors.present?
        {
            "error":errors
        }
      end
  end
    end
end









