require 'rails_helper'
RSpec.describe 'Post管理機能', type: :system do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:post2) { create(:post2, user: user) }

  describe '新規作成機能' do
    before do
      visit new_session_path
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
    end
    context 'postを新規作成した場合' do
      it '作成したpostが表示される' do
        visit new_post_path
        fill_in '飲食店名', with: 'name_sample'
        select '蕎麦・うどん', from: '料理ジャンル'
        click_on '登録'
        expect(page).to have_content '記事を登録しました。'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      visit new_session_path
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのpost一覧が表示される' do
        visit posts_path
        expect(page).to have_content 'test_name'
      end
    end
  end

  describe '詳細表示機能' do
    before do
      visit new_session_path
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
    end
    context '任意のpost詳細画面に遷移した場合' do
      it '該当postの内容が表示される' do
        visit post_path(post.id)
        expect(page).to have_content '焼肉・ホルモン'
      end
    end
  end

  describe '詳細表示機能' do
    before do
      visit new_session_path
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
    end
    context '任意のpost詳細画面に遷移した場合' do
      it '該当postの内容が表示される' do
        visit post_path(post2.id)
        expect(page).to have_content 'test2_dish'
      end
    end
  end
end
