# frozen_string_literal: true

class UsersController < ApplicationController
  ITEMS_PER_PAGE = 3

  def index
    @users = User.page(params[:page]).per(ITEMS_PER_PAGE)
  end

  def show
    @user = User.find(params[:id])
  end
end
