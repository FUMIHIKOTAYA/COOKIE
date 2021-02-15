require 'rails_helper'

RSpec.describe 'Orderモデル機能', type: :model do
  describe 'バリデーション' do
    before do
      @post1 = FactoryBot.create(:post)
    end
    context 'recommend_dishが50文字を超えていた場合' do
      it 'バリデーションが通らない' do
        order = Order.new(recommend_dish: 'a' * 51, reason: 'test_reason', post: @post1)
        expect(order).not_to be_valid
      end
    end

    context 'reasonの記載はあるがrecommend_dishの記載がない場合' do
      it 'バリデーションが通らない' do
        order = Order.new(recommend_dish: '', reason: 'test_reason', post: @post1)
        expect(order).not_to be_valid
      end
    end

    context 'recommend_dishとreasonが正しく入力されている場合' do
      it 'バリデーションが通る' do
        order = Order.new(recommend_dish: 'test_dish', reason: 'test_reason', post: @post1)
        expect(order).to be_valid
      end
    end
  end
end
