module Ver1
  class Root < Grape::API
    # http://localhost:3000/api/
    version'v1', using: :path
    format :json
    mount Ver1::Poker
    # api/ver1/rootを認識させて使えるようにする
  end
end