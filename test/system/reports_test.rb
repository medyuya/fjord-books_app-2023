# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  def setup
    @user = FactoryBot.create(:user)
    login_as(@user.email, @user.password)
  end

  test 'create a new report with proper inputs' do
    assert_current_path '/books'

    visit new_report_url
    fill_in 'report[title]', with: 'チェリー本を読んだ'
    fill_in 'report[content]', with: '分かりやすく書かれていました。'
    click_on '登録する'

    assert_current_path '/reports/1'
    assert_selector 'p#notice', text: '日報が作成されました。'
  end

  test 'create a new report with empty inputs' do
    assert_current_path '/books'

    visit new_report_url
    fill_in 'report[title]', with: ''
    fill_in 'report[content]', with: ''
    click_on '登録する'

    assert_current_path '/reports/new'
    assert_selector 'li', text: 'タイトルを入力してください'
    assert_selector 'li', text: '内容を入力してください'
  end

  test 'update a report with proper inputs' do
    report = FactoryBot.create(:report, user_id: @user.id)

    visit edit_report_url report
    fill_in 'report[title]', with: 'ブルーベリー本を読んだ'
    fill_in 'report[content]', with: '少し難しく感じました。'
    click_on '更新する'

    assert_current_path "/reports/#{report.id}"
    assert_selector 'p#notice', text: '日報が更新されました。'
  end

  test 'update a report with empty inputs' do
    report = FactoryBot.create(:report, user_id: @user.id)

    visit edit_report_url report
    fill_in 'report[title]', with: ''
    fill_in 'report[content]', with: ''
    click_on '更新する'

    assert_current_path "/reports/#{report.id}/edit"
    assert_selector 'li', text: 'タイトルを入力してください'
    assert_selector 'li', text: '内容を入力してください'
  end

  test 'delete a report' do
    report = FactoryBot.create(:report, user_id: @user.id)

    visit report_url report
    click_on 'この日報を削除'

    assert_current_path '/reports'
    assert_selector 'p#notice', text: '日報が削除されました。'
  end
end
