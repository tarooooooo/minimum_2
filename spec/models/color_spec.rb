require 'rails_helper'

RSpec.describe 'Colorモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # factoriesで作成したダミーデータを使用します。
    let!(:color) { build(:color) }

    subject { test_color.valid? }
    let(:test_color) { color }

    context 'nameカラム' do
      it '空欄でないこと' do
        test_color.name = ''
        is_expected.to eq false;
      end
    end
  end
end