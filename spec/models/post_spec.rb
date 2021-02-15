require 'rails_helper'

RSpec.describe 'Postモデル機能', type: :model do
  describe 'バリデーション' do
    before do
      @user1 = FactoryBot.create(:user)
    end
    context 'restaurant_nameが空の場合' do
      it 'バリデーションが通らない' do
        post = Post.new(restaurant_name: '', food_genre: 1, note: 'test_content', user: @user1)
        expect(post).not_to be_valid
      end
    end

    context 'restaurant_nameが50文字を超えていた場合' do
      it 'バリデーションが通らない' do
        post = Post.new(restaurant_name: 'a' * 51, food_genre: 1, note: 'test_content', user: @user1)
        expect(post).not_to be_valid
      end
    end

    context 'food_genreが空の場合' do
      it 'バリデーションが通らない' do
        post = Post.new(restaurant_name: 'test_name', food_genre: '', note: 'test_content', user: @user1)
        expect(post).not_to be_valid
      end
    end

    context 'restaurant_nameとfood_genreが正しく入力されている場合' do
      it 'バリデーションが通る' do
        post = Post.new(restaurant_name: 'test_name', food_genre: 1, note: 'test_content', user: @user1)
        expect(post).to be_valid
      end
    end
  end
end
