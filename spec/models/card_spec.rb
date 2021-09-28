require 'rails_helper'

RSpec.describe 'Cardモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # factoriesで作成したダミーデータを使用します。
    let!(:card) { build(:card) }

    subject { test_card.valid? }
    let(:test_card) { card }

    context 'customer_idカラム' do
      it '空欄でないこと' do
        test_card.customer_id = ''
        is_expected.to eq false;
      end
    end
    
    context 'card_idカラム' do
      it '空欄でないこと' do
        test_card.card_id = ''
        is_expected.to eq false;
      end
    end
  end
end