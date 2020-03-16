class Question < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, dependent: :destroy

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :text, length: {maximum: 255}
  validates :text, presence: true

  after_commit :search_tags, on: %i[create update]

  private

  def search_tags
    # удалить старые связи с хэштэгами
    tags.clear

    "#{text} #{answer}".downcase.scan(HASHTAG_REGEXP).uniq.map do |tag|
      tags << Tag.find_or_create_by(name: tag)
    end
  end
end
