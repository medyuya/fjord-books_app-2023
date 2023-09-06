# frozen_string_literal: true

module LoginSupport
  def login_as(user_email, user_password)
    visit new_user_session_url
    fill_in 'user[email]', with: user_email
    fill_in 'user[password]', with: user_password
    click_on 'ログイン'

    assert_current_path books_path
    assert_text 'ログインしました。'
  end
end
