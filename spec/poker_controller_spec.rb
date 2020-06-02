require "rails_helper"

RSpec.describe HomeController, type: :controller do

    describe "#check" do
      before do
        post :check, params: { 'content':hand }
      end
      #共通項(エラーがでたらrenderをshared_examplesで定義)
      shared_examples"topに戻される"do
      it { is_expected.to render_template :top }
      end

      context "バリデーション "do

        #５枚以上の入力が確認された時のエラー
        context "５枚以上入力された場合"do
          let(:hand){"S1 S2 S3 S4 S5 S6"}
          it "エラーを返す"do
          expect(assigns(:errors)).to eq "5つのカード指定文字を半角スペース区切りで入力してください"
          end
          it_behaves_like"topに戻される"
        end

        context "重複が確認された場合"
        let(:hand){"S1 S1 S2 S3 S4"}
        it "エラーを返す"do
          expect(assigns(:errors)).to eq "カードが重複しています"
        end
        it_behaves_like"topに戻される"

      context "数字が不正の場合"do
        let(:hand){"S1 S2 K3 S4 S5"}
        it "エラーを返す"do
          expect(assigns(:errors)).to eq ["3番目のKは不正です! 正しい文字を入力してください"]
        end
        it_behaves_like"topに戻される"
      end
      end


      context"役判定が行なえた場合"do
        context "ストレートフラッシュ"do
          let(:hand){"S1 S2 S3 S4 S5"}
          it "役を返す"do
            expect(assigns(:result)).to eq "straight_flush"
          end
          it_behaves_like"topに戻される"
        end

        context "ストレート"do
          let(:hand){"S1 H2 S3 H4 S5"}
          it "役を返す"do
          expect(assigns(:result)).to eq "straight"
          end
          it_behaves_like"topに戻される"
        end

        context "フォーオブアカインド"do
          let(:hand){"C10 S10 H10 D10 S2"}
          it "役を返す"do
            expect(assigns(:result)).to eq "four of a kind"
          end
          it_behaves_like"topに戻される"
        end

        context "フルハウス"do
          let(:hand){"C10 D10 H10 S5 D5"}
          it "役を返す"do
            expect(assigns(:result)).to eq "full house"
          end
          it_behaves_like"topに戻される"
        end

        context "フラッシュ"do
          let(:hand){"C10 C1 C7 C9 C4"}
          it "役を返す"do
            expect(assigns(:result)).to eq "flush"
          end
          it_behaves_like"topに戻される"
        end

        context "スリーオブカインド"do
          let(:hand){"C10 S10 H10 C4 D2"}
          it "役を返す"do
            expect(assigns(:result)).to eq "three of a kind"
          end
          it_behaves_like"topに戻される"
        end

        context "ツーペア"do
          let(:hand){"C10 S10 H1 C1 D2"}
          it "役を返す"do
            expect(assigns(:result)).to eq "two pair"
          end
          it_behaves_like"topに戻される"
        end

        context "ワンペア"do
          let(:hand){"C10 S10 H9 C11 D2"}
          it "役を返す"do
            expect(assigns(:result)).to eq "one pair"
          end
          it_behaves_like"topに戻される"
        end

        end
  end
end




