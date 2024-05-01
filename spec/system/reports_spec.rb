require 'rails_helper'

RSpec.describe 'Reports' do
  let(:user) { create(:user, name: 'ケン') }

  before do
    login_as(user)
  end

  describe 'Report Index' do
    let!(:report) { create(:report, user: user, title: 'キウイ本を読んだ', content: 'ちょうど良い難易度でした', created_at: Time.zone.local(2023, 8, 30)) }

    it 'displays elements on report index page' do
      visit reports_path

      expect(page).to have_content('日報の一覧')
      within 'div#report_1' do
        expect(page).to have_content('キウイ本を読んだ')
        expect(page).to have_content('ちょうど良い難易度でした')
        expect(page).to have_link('ケン')
        expect(page).to have_content('2023/08/30')
      end
      expect(page).to have_link('この日報を表示')
      expect(page).to have_link('日報の新規作成')
    end
  end

  describe 'Report Show' do
    let!(:report) { create(:report, user: user, title: 'キウイ本を読んだ', content: 'ちょうど良い難易度でした', created_at: Time.zone.local(2023, 8, 30)) }

    it 'displays elements on report show page' do
      visit report_path report

      expect(page).to have_content('日報の詳細')
      within 'div#report_1' do
        expect(page).to have_content('キウイ本を読んだ')
        expect(page).to have_content('ちょうど良い難易度でした')
        expect(page).to have_link('ケン')
        expect(page).to have_content('2023/08/30')
      end
      expect(page).to have_link('この日報を編集')
      expect(page).to have_link('日報の一覧に戻る')
      expect(page).to have_button('この日報を削除')
    end
  end

  describe 'Create Report' do
    before do
      visit new_report_path
    end

    context 'with valid inputs' do
      it 'creates the new report successfully' do
        fill_in 'タイトル', with: 'チェリー本を読んだ'
        fill_in '内容', with: '分かりやすく書かれていました。'
        click_on '登録する'

        expect(page).to have_content('日報が作成されました。')
        expect(page).to have_content('チェリー本を読んだ')
        expect(page).to have_content('分かりやすく書かれていました。')
      end
    end

    context 'with invalid inputs' do
      it 'shows validation errors and prevents report creation' do
        fill_in 'タイトル', with: ''
        fill_in '内容', with: ''
        click_on '登録する'

        expect(page).to have_content('タイトルを入力してください')
        expect(page).to have_content('内容を入力してください')
      end
    end
  end

  describe 'Update Report' do
    let!(:report) { create(:report, user: user, title: 'キウイ本を読んだ', content: 'ちょうど良い難易度でした') }

    before do
      visit edit_report_path report
    end

    context 'with valid changes' do
      it 'updates the report successfully' do
        fill_in 'タイトル', with: 'ブルーベリー本を読んだ'
        fill_in '内容', with: '難しかった'
        click_on '更新する'

        expect(page).to have_content('日報が更新されました。')
        expect(page).to have_content('ブルーベリー本を読んだ')
        expect(page).to have_content('難しかった')
      end
    end

    context 'with invalid changes' do
      it 'shows validation errors and prevents report update' do
        fill_in 'タイトル', with: ''
        fill_in '内容', with: ''
        click_on '更新する'

        expect(page).to have_content('タイトルを入力してください')
        expect(page).to have_content('内容を入力してください')
      end
    end
  end

  describe 'Delete Report' do
    let!(:report) { create(:report, user: user, title: 'キウイ本を読んだ', content: 'ちょうど良い難易度でした') }

    it 'deletes a report successfully' do
      visit reports_path

      expect(page).to have_content('キウイ本を読んだ')
      visit report_path report

      click_on 'この日報を削除'

      expect(page).to have_content('日報が削除されました。')
      expect(page).to have_no_content('キウイ本を読んだ')
    end
  end
end
