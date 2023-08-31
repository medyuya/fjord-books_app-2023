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
end
