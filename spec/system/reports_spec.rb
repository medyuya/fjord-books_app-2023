require 'rails_helper'

RSpec.describe 'Report CRUD', type: :system do
  before do
    @user = FactoryBot.create(:user, name: 'ケン')
    login_as(@user)
  end

  describe 'Report Index' do
    it 'displays elements on report index page' do
      travel_to Time.zone.local(2023, 8, 30) do
        @report = FactoryBot.create(:report, user: @user, title: 'キウイ本を読んだ', content: 'ちょうど良い難易度でした')
      end

      visit reports_path
      expect(page).to have_content('日報の一覧')

      within "div#report_#{@report.id}" do
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
    it 'displays elements on report show page' do
      travel_to Time.zone.local(2023, 8, 30) do
        @report = FactoryBot.create(:report, user: @user, title: 'キウイ本を読んだ', content: 'ちょうど良い難易度でした')
      end

      visit report_path(@report)
      expect(page).to have_content('日報の詳細')

      within "div#report_#{@report.id}" do
        expect(page).to have_content('キウイ本を読んだ')
        expect(page).to have_content('ちょうど良い難易度でした')
        expect(page).to have_link('ケン')
        expect(page).to have_content('2023/08/30')
      end

      expect(page).to have_link('この日報を編集')
      expect(page).to have_link('日報の一覧に戻る')
      expect(page).to have_selector('button', text: 'この日報を削除')
    end
  end

  describe 'Create Report' do
    context 'when a new report with proper inputs is created' do
      it 'creates a new report successfully' do
        visit new_report_path

        fill_in 'タイトル', with: 'チェリー本を読んだ'
        fill_in '内容', with: '分かりやすく書かれていました。'
        click_on '登録する'

        expect(page).to have_content('日報が作成されました。')
        expect(page).to have_content('チェリー本を読んだ')
        expect(page).to have_content('分かりやすく書かれていました。')
      end
    end

    context 'when a new report with empty inputs is created' do
      it 'shows validation errors and does not create a report' do
        visit new_report_path

        fill_in 'タイトル', with: ''
        fill_in '内容', with: ''
        click_on '登録する'

        expect(page).to have_content('タイトルを入力してください')
        expect(page).to have_content('内容を入力してください')
      end
    end
  end

  describe 'Update Report' do
    let!(:report) { create(:report, user: @user, title: 'キウイ本を読んだ', content: 'ちょうど良い難易度でした') }

    context 'when a new report with proper inputs is updated' do
      it 'updates a new report successfully' do
        visit edit_report_path(report)

        fill_in 'タイトル', with: 'ブルーベリー本を読んだ'
        fill_in '内容', with: '難しかった'
        click_on '更新する'

        expect(page).to have_content('日報が更新されました。')
        expect(page).to have_content('ブルーベリー本を読んだ')
        expect(page).to have_content('難しかった')
      end
    end

    context 'when a new report with empty inputs is updated' do
      it 'shows validation errors and does not update a report' do
        visit edit_report_path(report)

        fill_in 'タイトル', with: ''
        fill_in '内容', with: ''
        click_on '更新する'

        expect(page).to have_content('タイトルを入力してください')
        expect(page).to have_content('内容を入力してください')
      end
    end
  end

  describe 'Delete Report' do

  end
end
