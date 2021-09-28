require 'rails_helper'

RSpec.describe 'Categoryモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # factoriesで作成したダミーデータを使用します。
    let!(:category) { build(:category) }

    subject { test_category.valid? }
    let(:test_category) { category }

    context 'nameカラム' do
      it '空欄でないこと' do
        test_category.name = ''
        is_expected.to eq false;
      end
    end
  end
end