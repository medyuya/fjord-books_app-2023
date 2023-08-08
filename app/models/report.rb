# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def link_detect_and_save
    urls = self.content.scan(/http:\/\/localhost:3000\/reports\/\d+\b/)
    extracted_report_ids = urls.map { |url| url.sub("http://localhost:3000/reports/", "").to_i }
    false
  end
end
