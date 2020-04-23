require "rails_helper"
RSpec.describe Hands, type: :controller do
  describe "post #create" do
  before do
  post :create, params: { content: hand }
  end
  shared_examples"topに戻される"
  it { is_expected.to render_template :top }

  include_examples"topに戻される"

  context "バリデーション "do

    #文字が入力されなかった場合のエラー
    context "空白"do
      let(:hand){""}
      it "エラーを返す"
      expect(@errors).to eq "文字を入力してください"
      it_behaves_like"topに戻される"

    #５枚以上の入力が確認された時のエラー
    context "５枚以上入力された場合"do
      let(:hand){"S1 S2 S3 S4 S5 S6"}
      expect(@errors).to eq "カードは５枚です"
      it_behaves_like"topに戻される"
    end

    context "重複が確認された場合"
      let(:hand){"S1 S1 S2 S3 S4"}
      expect(@errors).to eq "同じカードは不正です"
      it_behaves_like"topに戻される"
    end
    context "スートが不正の場合"do
      let(:hand){"S1 S2 S3 K2 S5"}
      expect(@errors).to eq "４番目のカードは不正です"
      it_behaves_like"topに戻される"
    end
    context "数字が不正の場合"do
      let(:hand){"S18 S2 S3 S4 S5"}
      expect(@errors).to eq "１番目のカードは不正です"
      it_behaves_like"topに戻される"
    end

    end

  end
  end