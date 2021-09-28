require 'rails_helper'

RSpec.describe 'Itemモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # factoriesで作成したダミーデータを使用します。
    let(:user) { FactoryBot.create(:user) }
    let(:color){FactoryBot.create(:color)}
    let(:category){FactoryBot.create(:category)}
    let(:brand){FactoryBot.create(:brand)}
    let!(:item) { build(:item, user_id: user.id, color_id: color.id, category_id: category.id, brand_id: brand.id) }
    # let!(:item) {  FactoryBot.create(:item)}

    subject { test_item.valid? }
    let(:test_item) { item }


    context 'nameカラム' do
      it '空欄でないこと' do
        test_item.name = ''
        is_expected.to eq false;
      end
    end

    context 'priceカラム' do
      it '空欄でないこと' do
        test_item.price = ''
        is_expected.to eq false;
      end
    end

    context 'item_image_idカラム' do
      it '空欄でないこと' do
        test_item.item_image_id = ''
        is_expected.to eq false;
      end
    end

    context 'item_statusカラム' do
      it '空欄でないこと' do
        test_item.item_status = ''
        is_expected.to eq false;
      end
    end

    context 'sizeカラム' do
      it '空欄でないこと' do
        test_item.size = ''
        is_expected.to eq false;
      end
    end

     context 'user_idカラム' do
      it '空欄でないこと' do
        test_item.user_id = ''
        is_expected.to eq false;
      end
    end
    
    context 'color_idカラム' do
      it '空欄でないこと' do
        test_item.color_id = ''
        is_expected.to eq false;
      end
    end
    
    context 'category_idカラム' do
      it '空欄でないこと' do
        test_item.category_id = ''
        is_expected.to eq false;
      end
    end
    
    context 'purchase_dateカラム' do
      it '空欄でないこと' do
        test_item.purchase_date = ''
        is_expected.to eq false;
      end
    end
    
    context 'wear_countカラム' do
      it '空欄でないこと' do
        test_item.wear_count = ''
        is_expected.to eq false;
      end
    end

  end
end