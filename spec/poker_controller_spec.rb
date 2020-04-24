require "rails_helper"

RSpec.describe HomeController, type: :controller do

    describe "#create" do
      before do
        post :create, params: { 'content':hand }
      end
      #共通項(エラーがでたらrenderをshared_examplesで定義)
      shared_examples"topに戻される"do
      it { is_expected.to render_template :top }
      end

      context "バリデーション "do
        @errors ="４番目のカードは不正です"

        #文字が入力されなかった場合のエラー
        # context "空白"do
        #   #binding.pry
        #   let(:hand){""}
        #   it "エラーを返す"do
        #     expect(@errors[0]).to eq "文字を入力してください"
        #   end
        #   it_behaves_like'topに戻される'
        #
        # end

        #５枚以上の入力が確認された時のエラー
        context "５枚以上入力された場合"do
          let(:hand){"S1 S2 S3 S4 S5 S6"}
          it "エラーを返す"do
          expect(assigns(:errors)).to eq "カードは５枚です"
          end
          it_behaves_like"topに戻される"
        end

        context "重複が確認された場合"
        let(:hand){"S1 S1 S2 S3 S4"}
        it "エラーを返す"do
          expect(assigns(:errors)).to eq "同じカードは不正です"
        end
        it_behaves_like"topに戻される"
      # context "スートが不正の場合"do
      #   let(:hand){"S1 S2 S3 K2 S5"}
      #   it "エラーを返す"do
      #     expect(assigns(:errors)).to eq "４番目のカードは不正です"
      #   end
      #   it_behaves_like"topに戻される"
      # end
      #不正個所を指定してエラーを返す
      context "数字が不正の場合"do
        let(:hand){"S1 S2 K3 S4 S5"}
        it "エラーを返す"do
          expect(assigns(:errors)).to eq ["2番目のKは不正です! 正しい文字を入力してください"]
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

        # context "ワンペア"do
        #   let(:hand){"C10 S1 H9 C4 D7"}
        #   it "役を返す"do
        #     expect(assigns(:result)).to eq "one pair"
        #   end
        #   it_behaves_like"topに戻される"
        # end
        end
  end
end




