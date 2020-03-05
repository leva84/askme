module UsersHelper
  # Этот метод возвращает ссылку на аватарку пользователя, если она у него есть.
  # Или ссылку на дефолтную аватарку, которую положим в app/assets/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def declension(number, enot, enota, enotov)
    indicator1 = number % 10
    indicator2 = number % 100

    if indicator2.between?(11, 14)
      enotov
    else
      case indicator1
      when 1
        enot
      when 2..4
        enota
      when 5..9, 0
        enotov
      end
    end
  end

  def index_tags
    tags = []
    @users.map do |user|
      user.questions.map do |question|
        question.tags.map do |tag|
          tags << tag if !tags.include?(tag)
        end
      end
    end

    tags
  end
end
