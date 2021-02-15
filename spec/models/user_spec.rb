require 'rails_helper'

RSpec.describe 'ユーザーモデル機能', type: :model do
  describe 'バリデーション' do
    context 'nameが空の場合' do
      it 'バリデーションが通らない' do
        user = User.new(name: '', email: 'testuser@example.com', password: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'nameが50文字を超えていた場合' do
      it 'バリデーションが通らない' do
        user = User.new(name: 'a' * 51, email: 'testuser@example.com', password: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'emailが空の場合' do
      it 'バリデーションが通らない' do
        user = User.new(name: 'testuser', email: '', password: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'emailがフォーマット通りでない場合' do
      it 'バリデーションが通らない' do
        user = User.new(name: 'testuser', email: 'testuser.com', password: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'passwordが空の場合' do
      it 'バリデーションが通らない' do
        user = User.new(name: 'testuser', email: 'testuser@example.com', password: '')
        expect(user).not_to be_valid
      end
    end

    context 'passwordが6文字未満の場合' do
      it 'バリデーションが通らない' do
        user = User.new(name: 'testuser', email: 'testuser@example.com', password: 'pass')
        expect(user).not_to be_valid
      end
    end

    context 'name・email・passwordが正しく入力されている場合' do
      it 'バリデーションが通る' do
        user = User.new(name: 'testuser', email: 'testuser@example.com', password: 'password')
        expect(user).to be_valid
      end
    end
  end
end
