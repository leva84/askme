class UsersController < ApplicationController
  include UsersHelper

  before_action :load_user, except: [:index, :create, :new]
  # Порядок before_action очень важен! Они выполняются сверху вниз
  # Проверяем, имеет ли юзер доступ к экшену, делаем это для всех действий, кроме
  # :index, :new, :create, :show — к ним есть доступ у всех, даже у анонимных юзеров.
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    # Если юзер залогинен, отправляем его на главную с сообщением
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    # Иначе, создаем болванку нового пользователя.
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new(user_params)
    favorite_color_default(@user)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    # пытаемся обновить юзера
    if @user.update(user_params)
      # Если получилось, отправляем пользователя на его страницу с сообщением
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      # Если не получилось, как и в create, рисуем страницу редактирования
      # пользователя со списком ошибок
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build
    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
    @author = author
    @user_color = @user.favorite_color
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Пользователь удален!'
  end

  private

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :favorite_color)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authorize_user
    reject_user unless @user == current_user
  end

  def author
    current_user.id if current_user.present?
  end
end
