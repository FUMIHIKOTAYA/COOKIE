require 'rails_helper'
RSpec.describe 'User管理機能', type: :system, xhr: true do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user2) }

  describe 'ユーザー登録' do
    context 'サインアップができる' do
      it 'サインアップ後ログインしマイページを表示する' do
        visit new_user_path
        fill_in '名前', with: 'test_name'
        fill_in 'メールアドレス', with: 'test_name@example.com'
        fill_in 'パスワード', with: 'password'
        click_button '新規登録'
        expect(page).to have_content 'ユーザーを登録し、ログインしました。'
      end
    end
  end

  describe 'セッション機能' do
    context 'ログインした場合' do
      it '登録済みのユーザー名が表示されること' do
        visit new_session_path
        fill_in 'Email', with: 'user1@example.com'
        fill_in 'Password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'user1'
      end
    end
    before do
      visit new_session_path
      fill_in 'Email', with: 'user2@example.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
    end
    context 'ユーザーがログインしている場合' do
      it '自分の詳細画面(マイページ)にアクセスできること' do
        visit user_path(user2)
        expect(page).to have_selector 'h2', text: 'user2さんのページ'
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'ログアウトができること' do
        click_link "ログアウト"
        expect(page).to have_content 'ログアウトしました。'
      end
    end
  end

  describe 'アクセス制限' do
    context 'ユーザーがログインしていない場合' do
      it '投稿画面にアクセスしようとしたらログイン画面を表示する' do
        visit posts_path
        expect(page).to have_content 'ログインして始められます。'
      end
    end
  end

  describe 'フォロー機能' do
    before do
      visit new_session_path
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
    end
    context 'user1がログインしている' do
      it 'user2をフォローする', js: true do
        visit user_path(user2)
        click_on 'フォロー'
        click_on 'マイページ'
        click_on 'フォロー・フォロワー一覧'
        expect(page).to have_content 'user2'
        end
      it 'user2をフォロー解除する' do
        visit user_path(user2)
        click_on 'フォロー'
        click_on 'マイページ'
        visit user_path(user2)
        click_on 'フォロー解除'
        click_on 'マイページ'
        click_on 'フォロー・フォロワー一覧'
        expect(page).to have_no_content 'user2'
      end
    end
  end

  describe 'メッセージ機能' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'user1@example.com'
        fill_in 'Password', with: 'password'
        click_button 'ログイン'
      end
      context 'user1がログインしている' do
        it 'user2へメッセージを送る', js: true do
          visit user_path(user2)
          click_on 'フォロー'
          visit user_path(user)
          click_on 'フォロー・フォロワー一覧'
          click_on 'メッセージ'
          fill_in 'message_body', with: 'Hello'
          click_on '送信'
          expect(page).to have_content '未読'
        end
        it 'メッセージが確認されたら既読になる' do
          visit user_path(user2)
          click_on 'フォロー'
          visit user_path(user)
          click_on 'フォロー・フォロワー一覧'
          click_on 'メッセージ'
          fill_in 'message_body', with: 'Hello'
          click_on '送信'
          click_link 'ログアウト'
          visit new_session_path
          fill_in 'Email', with: 'user2@example.com'
          fill_in 'Password', with: 'password'
          click_button 'ログイン'
          visit user_path(user2)
          click_on 'フォロー・フォロワー一覧'
          click_on 'メッセージ'
          click_link 'ログアウト'
          visit new_session_path
          fill_in 'Email', with: 'user1@example.com'
          fill_in 'Password', with: 'password'
          click_button 'ログイン'
          click_on 'マイページ'
          click_on 'フォロー・フォロワー一覧'
          click_on 'メッセージ'
          expect(page).to have_content '既読'
      end
    end
  end
end
