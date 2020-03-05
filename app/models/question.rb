class Question < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, dependent: :destroy

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :text, length: {maximum: 255}

  before_create :search_tags
  before_update :search_tags

  private

  def search_tags
    text.scan(HASHTAG_REGEXP).map! do |tag|
      tag.downcase!
      tags << Tag.find_or_create_by(name: tag.strip)
    end

    if answer != nil
      answer.scan(HASHTAG_REGEXP).map! do |tag|
        tag.downcase!
        tags << Tag.find_or_create_by(name: tag.strip)
      end
    end
  end
end
