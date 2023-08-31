# frozen_string_literal: true

require 'test_helper'
 require_relative './support/system_test_methods/login_support.rb'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :safari, screen_size: [1400, 1400]
  include LoginSupport
end
