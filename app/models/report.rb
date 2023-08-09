# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :active_relationships, class_name: 'MentionedRelationship',
                                  foreign_key: 'mentioning_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'MentionedRelationship',
                                   foreign_key: 'mentioned_id',
                                   dependent: :destroy
  has_many :mentioning_reports, through: :active_relationships, source: :mentioned
  has_many :mentioned_reports, through: :passive_relationships, source: :mentioning
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
    extracted_report_ids = urls.map { |url| url.sub('http://localhost:3000/reports/', '').to_i }

    extracted_report_ids.each do |report_id|
      mentioned_relationships = self.active_relationships.build(mentioned_id: report_id)
      return false unless mentioned_relationships.save
    end

    true
  end
end
