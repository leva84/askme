class Question < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/

  has_many :taggings
  has_many :tags, through: :taggings

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :text, length: {maximum: 255}

  before_save :search_tags

  private

  def update_tags
    tag_names = question.find_tags
    tag_names.each do |tag_name|
      next if question.tags.find_by_name(tag_name)
      question.tags << Tag.new(name: tag_name)
    end
  end

  def find_tags
    # вовзращает массив строк (имена тэгов)
  end


  def search_tags
    text.scan(HASHTAG_REGEXP).map! do |tag|
      self.tags << Tag.new(name: tag.strip)
    end

    if answer != nil
      answer.scan(HASHTAG_REGEXP).map! do |tag|
        self.tags << Tag.new(name: tag.strip)
      end
    end
  end
end
