class ApplicationController < ActionController::Base

  helper_method :current_user, :reject_user, :declension

  private
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

  def reject_user
    redirect_to root_path, alert: 'Вам сюда низя!'
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
