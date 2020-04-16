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
        result=[]
        cards=valid(hand,errors)
        valid_duplication(cards,errors)
        suits, numbers = valid_matching(cards,errors)
        a_poker_hand=judge(numbers, suits, result)
        #binding.pry
        api_judge(hand, a_poker_hand,results)
        judge_strength(results, result)
        end
      #binding.pry
        {
            "result": results
        }
      end
  end
end








