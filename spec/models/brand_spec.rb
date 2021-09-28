require 'rails_helper'

RSpec.describe 'Brandモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # factoriesで作成したダミーデータを使用します。
    let!(:brand) { build(:brand) }

    subject { test_brand.valid? }
    let(:test_brand) { brand }

    context 'nameカラム' do
      it '空欄でないこと' do
        test_brand.name = ''
        is_expected.to eq false;
      end
    end
  end
end