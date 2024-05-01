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

  describe 'Update Report' do
    context 'when name is present' do
      it '' do
      end
    end
  end

  describe 'Delete Report' do

  end
end
