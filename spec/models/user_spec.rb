require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # factoriesで作成したダミーデータを使用します。
    let!(:user) { build(:user) }

    subject { test_user.valid? }
    let(:test_user) { user }

    context 'last_nameカラム' do
      it '空欄でないこと' do
        test_user.last_name = ''
        is_expected.to eq false;
      end
    end
    
    context 'first_nameカラム' do
      it '空欄でないこと' do
        test_user.first_name = ''
        is_expected.to eq false;
      end
    end
    
    context 'first_name_kanaカラム' do
      it '空欄でないこと' do
        test_user.first_name_kana = ''
        is_expected.to eq false;
      end
    end
    
    context 'last_name_kanaカラム' do
      it '空欄でないこと' do
        test_user.last_name_kana = ''
        is_expected.to eq false;
      end
    end
    
    context 'nicknameカラム' do
      it '空欄でないこと' do
        test_user.nickname = ''
        is_expected.to eq false;
      end
    end
    
    context 'postal_codeカラム' do
      it '空欄でないこと' do
        test_user.postal_code = ''
        is_expected.to eq false;
      end
    end
    
    context 'addressカラム' do
      it '空欄でないこと' do
        test_user.address = ''
        is_expected.to eq false;
      end
    end
    
    context 'phone_numberカラム' do
      it '空欄でないこと' do
        test_user.phone_number = ''
        is_expected.to eq false;
      end
    end
    
    context 'is_deletedカラム' do
      it '空欄でないこと' do
        test_user.is_deleted = ''
        is_expected.to eq false;
      end
    end
  end
end