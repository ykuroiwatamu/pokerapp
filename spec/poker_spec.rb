require 'rails_helper'
RSpec.describe Hands, type: :model do

  describe "pokerロジック" do
    let(:hand) {{ params:@hand } }
    #valid(hand)のテストコード
    describe "valid" do
      subject {valid(@hand)}
      context "空か５枚以上の場合" do
        context "空の場合" do
          let(:hand){" "}
          it { is_expected.to eq "文字を入力してください"}
        end
        context "５枚以上が入力された場合"
          let(:hand){"S1 S2 S3 S4 S5 S6"}
        it { is_expected.to eq "カードは５枚です"}
      end
    #valid_duplication(@hand)のテストコード
      describe "valid_duplication" do
        subject {valid_duplication(@hand)}
        context "カードが重複した場合" do
          let(:hand){"S1 S1 S2 S3 S4 "}
          it { is_expected.to eq "同じカードはダメ"}
        end





      end
    end
  end
  end
