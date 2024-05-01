# frozen_string_literal: true

module LoginSupport
  def login_as(user)
    visit new_user_session_path
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: user.password
    click_on 'ログイン'

    expect(page).to have_text 'ログインしました。'
  end
end
