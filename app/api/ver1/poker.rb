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
      hand = params[:content]
    end
  end
end
