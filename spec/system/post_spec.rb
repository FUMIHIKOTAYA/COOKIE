require 'rails_helper'
RSpec.describe 'Post管理機能', type: :system do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:post2) { create(:post2, user: user) }

  def logged_in
    visit login_path
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password'
    click_button 'ログイン'
  end

  describe '新規作成機能' do
    context 'postを新規作成した場合' do
      it '作成したpostが表示される' do
        logged_in
        visit new_post_path
        fill_in '飲食店名', with: 'name_sample'
        select '蕎麦・うどん', from: '料理ジャンル'
        click_on '登録'
        expect(page).to have_content '記事を登録しました。'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのpost一覧が表示される' do
        logged_in
        visit posts_path
        expect(page).to have_content 'test_name'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のpost詳細画面に遷移した場合' do
      it '該当postの内容が表示される' do
        logged_in
        visit post_path(post.id)
        expect(page).to have_content '焼肉・ホルモン'
      end
    end
    context '任意のpost詳細画面に遷移した場合' do
      it '該当postの内容が表示される' do
        logged_in
        visit post_path(post2.id)
        expect(page).to have_content 'test2_dish'
      end
    end
  end

  describe '検索機能' do
    before do
      logged_in
      visit posts_path
    end
    context '飲食店名であいまい検索をした場合' do
      it "検索キーワードを含む飲食店名が絞り込まれる" do
        fill_in :q_restaurant_name_cont, with: "2"
        click_on '検索'
        expect(page).to have_content 'test2_name'
      end
    end
    context '料理ジャンル検索をした場合' do
      it "料理ジャンルに完全一致する飲食店が絞り込まれる" do
        select 'カフェ・スイーツ', from: '料理ジャンル'
        click_on '検索'
        expect(page).to have_content 'test2_name'
      end
    end
    context 'いつもオーダーする一品であいまい検索をした場合' do
      it "検索キーワードを含む飲食店が絞り込まれる" do
        fill_in :q_orders_recommend_dish_cont, with: "test2"
        click_on '検索'
        expect(page).to have_content 'test2_name'
      end
    end
  end
end
