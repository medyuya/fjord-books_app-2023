# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @user = FactoryBot.create(:user)
  end

  test 'editable? returns true' do
    report = FactoryBot.create(:report, user: @user)
    assert report.editable?(@user)
  end

  test 'editable? returns false' do
    other_user = FactoryBot.create(:user)
    report = FactoryBot.create(:report, user: other_user)
    assert_not report.editable?(@user)
  end

  test 'created_on returns true' do
    travel_to Time.zone.local(2023, 8, 30) do
      report = FactoryBot.create(:report, user: @user)
      assert_equal Date.new(2023, 8, 30), report.created_on
    end
  end
end
