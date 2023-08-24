# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 50 }
end
