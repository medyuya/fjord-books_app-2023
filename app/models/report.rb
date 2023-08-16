# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :active_relationships, class_name: 'MentionedRelationship',
                                  foreign_key: 'mentioning_id',
                                  dependent: :destroy,
                                  inverse_of: :mentioning
  has_many :passive_relationships, class_name: 'MentionedRelationship',
                                   foreign_key: 'mentioned_id',
                                   dependent: :destroy,
                                   inverse_of: :mentioned
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
    transaction_successful = false

    ActiveRecord::Base.transaction do
      raise ActiveRecord::Rollback unless save && linked_reports_save

      transaction_successful = true
    end

    transaction_successful
  end

  def link_detect_and_update(report_params)
    transaction_successful = false

    ActiveRecord::Base.transaction do
      raise ActiveRecord::Rollback unless update(report_params) && linked_reports_update

      transaction_successful = true
    end

    transaction_successful
  end

  def linked_reports_save
    extracted_report_ids = extract_report_ids(content)

    extracted_report_ids.all? do |report_id|
      active_relationships.build(mentioned_id: report_id).save
    end
  end

  def linked_reports_update
    extracted_report_ids = extract_report_ids(content)

    old_report_ids = mentioning_reports.ids - extracted_report_ids
    new_report_ids = extracted_report_ids - mentioning_reports.ids

    has_reports_destroyed = old_report_ids.all? do |report_id|
      active_relationships.find_by(mentioned_id: report_id).destroy
    end

    has_reports_saved = new_report_ids.all? do |report_id|
      active_relationships.build(mentioned_id: report_id).save
    end

    has_reports_destroyed && has_reports_saved
  end

  private

  def extract_report_ids(text)
    text.scan(%r{http://localhost:3000/reports/(\d+)\b}).flatten.map(&:to_i)
  end
end
