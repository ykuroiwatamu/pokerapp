require "rails_helper"

describe Ver1::Poker, :type => :request do
  before do
    post '/api/v1/poker/check', :params => params.to_json, :headers => {'Content-Type': 'application/json'}
  end
  let(:params) {{"cards":cards}}
  # ＃正常系
  context "成功した場合"do
    it "リクエストが成功した場合"do
      expect(response.status).to eq 201
      expect(response).to be_success
    end

    let(:cards) { [
        "H1 H2 H3 H4 H5",
        "H9 C9 S9 H2 C2",
        "C13 D12 C11 H8 H7"
    ] }
      it '役を返す' do
        respond = JSON.parse(response.body)
        # expect(response.status).to eq 201
        # expect(response).to be_success
        expect(respond["result"][0]["card"]).to eq("H1 H2 H3 H4 H5")
        expect(respond["result"][0]["hand"]).to eq("straight_flush")
        expect(respond["result"][0]["best"]).to be true
        expect(respond["result"][1]["card"]).to eq("H9 C9 S9 H2 C2")
        expect(respond["result"][1]["hand"]).to eq("full house")
        expect(respond["result"][1]["best"]).to be false
        expect(respond["result"][2]["card"]).to eq("C13 D12 C11 H8 H7")
        expect(respond["result"][2]["hand"]).to eq("high card")
        expect(respond["result"][2]["best"]).to be false

      end
  end
  context "異常系" do
    context "失敗した場合" do
  let(:cards) {[
        "C10 D10 K10 S10 D5",
        "H9 C22 S9 H2 C2",
        "C13 D12 C11 C11 H7"
    ]}
  it 'エラーを返す' do
    respond = JSON.parse(response.body)
    expect(response.status).to eq 201
    expect(response).to be_success
    expect(respond["error"][0]["card"]).to eq("C10 D10 K10 S10 D5")
    expect(respond["error"][0]["msg"]).to eq("3番目のKは不正です! 正しい文字を入力してください")
    #binding.pry
    expect(respond["error"][1]["card"]).to eq("H9 C22 S9 H2 C2")
    expect(respond["error"][1]["msg"]).to eq("2番目の22は不正です! 正しい数字を入力してください")
    expect(respond["error"][2]["card"]).to eq("C13 D12 C11 C11 H7")
    expect(respond["error"][2]["msg"]).to eq("カードが重複しています")
  end
    end


  context "失敗が一つある場合"do
     let(:cards) {[
      "C10 D10 K10 S10 D5",
      "H9 C9 S9 H2 C2",
      "C13 D12 C11 H8 H7"
      ]}
       it 'エラーを返す' do
      respond = JSON.parse(response.body)
        expect(response.status).to eq 201
        expect(response).to be_success
        #binding.pry
        expect(respond["result"][0]["card"]).to eq("H9 C9 S9 H2 C2")
        expect(respond["result"][0]["hand"]).to eq("full house")
        expect(respond["result"][0]["best"]).to be true
        expect(respond["result"][1]["card"]).to eq("C13 D12 C11 H8 H7")
        expect(respond["result"][1]["hand"]).to eq("high card")
        expect(respond["result"][1]["best"]).to be false
        expect(respond["error"][0]["card"]).to eq("C10 D10 K10 S10 D5")
        expect(respond["error"][0]["msg"]).to eq("3番目のKは不正です! 正しい文字を入力してください")
       end
  end
  context "paramsが空の場合" do

     let(:cards){{}}
      it 'エラーを返す' do
        respond = JSON.parse(response.body)
        binding.pry
        expect(respond["error"][0]["msg"]).to eq ("不正なリクエストです。")
      end
  end

    context "cardsの中身が空の場合"do

      let(:cards){[""]}
      it 'エラーを返す' do
        respond = JSON.parse(response.body)
        binding.pry
        expect(respond["error"][0]["msg"]).to eq ("5つのカード指定文字を半角スペース区切りで入力してください")
      end
    end
  end
end



