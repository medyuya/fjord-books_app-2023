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
    extracted_report_ids = extract_report_ids(self.content)

    extracted_report_ids.all? do |report_id|
      mentioned_relationships = self.active_relationships.build(mentioned_id: report_id)
      mentioned_relationships.save
    end
  end

  def link_detect_and_update
    extracted_report_ids = extract_report_ids(self.content)

    old_report_ids = self.mentioning_reports.ids - extracted_report_ids
    new_report_ids = extracted_report_ids - self.mentioning_reports.ids

    old_report_ids.all? do |report_id|
      delete_mentions = MentionedRelationship.find_by(mentioning_id: self.id, mentioned_id: report_id)
      delete_mentions.destroy
    end

    new_report_ids.all? do |report_id|
      mentioned_relationships = self.active_relationships.build(mentioned_id: report_id)
      mentioned_relationships.save
    end
  end

  private

  def extract_report_ids(text)
    urls = text.scan(/http:\/\/localhost:3000\/reports\/\d+\b/)
    extracted_report_ids = urls.map { |url| url.sub('http://localhost:3000/reports/', '').to_i }
  end
end
