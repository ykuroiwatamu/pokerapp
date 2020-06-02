module Ver1
  class Poker < Grape::API
    helpers do
      include Hands
      def params_error!
        error!({"error":[{"msg":"不正なリクエストです。"}]}, 400, { 'Content-Type' => 'application/json' })
      end
    end

    #リクエスト指定のバリデーション
    content_type :json, 'application/json'
    format :json
    #cardsを配列で受け取れるように指定
    params do
      requires :cards, type: Array
    end
    rescue_from :all do |e|
      params_error!
    end

    #役判定のロジック
    post 'poker/check' do

      hands = params[:cards]
      results=[]
      errors =[]
      #binding.pry
      hands.each do |hand|
        messages=[]
        error_messages = []
        unless params[:cards].present?
          params_error!
        end

        unless judge_Half_width_space(hand)

          messages<<"5つのカード指定文字を半角スペース区切りで入力してください"
          error_hand(errors,hand,messages)
          next
        end

        unless judge_duplication(hand)
          messages<<"カードが重複しています"
          error_hand(errors,hand,messages)
          next
        end
        unless judge_matching(hand,error_messages)
          messages=error_messages
          error_hand(errors,hand,messages)
          next
        end
        a_poker_hand=judge(hand)
        api_judge(hand, a_poker_hand, results)
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









