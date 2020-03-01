class Question < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/

  serialize :hashtags, Array

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :text, length: {maximum: 255}

  def all_tags_question
    self.map(&:hashtags).join(', ')
  end

  def search_hashtag
    self.hashtags << self.text.scan(HASHTAG_REGEXP).map! { |tag| tag.strip }
    self.hashtags << self.answer.scan(HASHTAG_REGEXP).map! { |tag| tag.strip }
  end
end
