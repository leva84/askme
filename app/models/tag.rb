class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings, dependent: :destroy

  before_save :normalaize_tag_name

  private

  def normalaize_tag_name
    self.name.downcase!
  end
end
