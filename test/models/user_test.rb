# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name_or_email returns the name' do
    user = FactoryBot.create(:user, name: 'ken')
    assert_equal 'ken', user.name_or_email
  end

  test 'name_or_email returns the email' do
    user = FactoryBot.create(:user)
    assert_equal 'ken@example.com', user.name_or_email
  end
end
