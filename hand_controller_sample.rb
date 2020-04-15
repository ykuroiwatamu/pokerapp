class HandsController < ApplicationController
  include CommonHands
  def index
  end
  def check
    @cards = params[:hand]
    # 最初の検証
    unless number_of_sheets_validate(@cards)
      flash.now[:alert] = ‘5つのカード指定文字を半角スペース区切りで入力してください。（例：“S1 H3 D9 C13 S11”）’
      render action: :index and return
    end
    # 2回目の検証
    error_messages = {}
    unless suit_and_num_validate(@cards, error_messages)
      assignment_to_flash(error_messages)
      # flash.now[:alert]に配列入れる
      flash.now[:alert] = “半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。”
      render :index and return
    end
    # 最後の検証
    unless unique_card_validate(@cards)
      flash.now[:alert] = “カードが重複しています。”
      render :index and return
    end
    # 札の判定
    @judgement = judge_hands(@cards)
    render :index and return
  end
end