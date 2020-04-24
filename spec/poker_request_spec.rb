require "rails_helper"

RSpec.describe Ver1::Poker, :type =>:request do
  before do
    post :":/api/v1/poker/check"
  end
  let(:params) {{'hand':hand}}
  let(:header) {{'Content-Type':content_type}}
  describe "成功した場合"
  let(:content_type){"application/json"}
  let(:hand){[
          "H1 H13 H12 H11 H10",
          "H9 C9 S9 H2 C2",
          "C13 D12 C11 H8 H7"
      ]
  }
  it "json形式でcards入力も正しい場合"do
    expect(assigns(:results[0])).to eq ["H1 H13 H12 H11 H10", "flush", "true"]


    end

  end