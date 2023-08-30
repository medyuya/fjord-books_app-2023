# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @user = FactoryBot.create(:user)
  end

  test "editable? returns true" do
    report = FactoryBot.create(:report, user_id: @user.id)
    assert report.editable?(@user)
  end

  test "editable? returns false" do
    other_user = FactoryBot.create(:other_user)
    report = FactoryBot.create(:report, user_id: other_user.id)
    assert_not report.editable?(@user)
  end

  test "created_on returns true" do
    report = FactoryBot.create(:report, user_id: @user.id, created_at: 'Wed, 30 Aug 2023 21:20:50 JST +09:00')
    assert_equal 'Wed, 30 Aug 2023', report.created_on
  end
end
