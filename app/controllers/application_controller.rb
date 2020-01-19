class ApplicationController < ActionController::Base
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
end
