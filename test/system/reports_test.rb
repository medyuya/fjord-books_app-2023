# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  def setup
    @user = FactoryBot.create(:user)
    login_as(@user.email, @user.password)
  end

  test 'elements on report index page' do
    travel_to Time.zone.local(2023, 8, 30) do
      report = FactoryBot.create(:report, user_id: @user.id)

      visit reports_url
      assert_text '日報の一覧'
      within 'div.index-item' do
        within "div#report_#{report.id}" do
          assert_text report.title
          assert_text report.content
          assert_link report.user.name
          assert_text '2023/08/30'
        end
        assert_link 'この日報を表示'
      end
      assert_link '日報の新規作成'
    end
  end

  test 'elements on report show page' do
    travel_to Time.zone.local(2023, 8, 30) do
      report = FactoryBot.create(:report, user_id: @user.id)

      visit report_url report
      assert_text '日報の詳細'
      within "div#report_#{report.id}" do
        assert_text report.title
        assert_text report.content
        assert_link report.user.name
        assert_text '2023/08/30'
      end
      assert_link 'この日報を編集'
      assert_link '日報の一覧に戻る'
      assert_selector 'button', text: 'この日報を削除'
    end
  end

  test 'create a new report with proper inputs' do
    visit new_report_url
    fill_in 'タイトル', with: 'チェリー本を読んだ'
    fill_in '内容', with: '分かりやすく書かれていました。'
    click_on '登録する'

    assert_text '日報が作成されました。'

    within "div.show-item" do
      assert_text 'チェリー本を読んだ'
      assert_text '分かりやすく書かれていました。'
    end
  end

  test 'create a new report with empty inputs' do
    visit new_report_url
    fill_in 'タイトル', with: ''
    fill_in '内容', with: ''
    click_on '登録する'

    assert_text 'タイトルを入力してください'
    assert_text '内容を入力してください'
  end

  test 'update a report with proper inputs' do
    report = FactoryBot.create(:report, user_id: @user.id)

    visit edit_report_url report
    fill_in 'タイトル', with: 'ブルーベリー本を読んだ'
    fill_in '内容', with: '少し難しく感じました。'
    click_on '更新する'

    assert_text '日報が更新されました。'

    within "div.show-item" do
      assert_text 'ブルーベリー本を読んだ'
      assert_text '少し難しく感じました。'
    end
  end

  test 'update a report with empty inputs' do
    report = FactoryBot.create(:report, user_id: @user.id)

    visit edit_report_url report
    fill_in 'タイトル', with: ''
    fill_in '内容', with: ''
    click_on '更新する'

    assert_text 'タイトルを入力してください'
    assert_text '内容を入力してください'
  end

  test 'delete a report' do
    report = FactoryBot.create(:report, user_id: @user.id)

    visit report_url report
    click_on 'この日報を削除'

    assert_text '日報が削除されました。'
  end
end
