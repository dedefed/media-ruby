class UsersController < ApplicationController
  before_action :get_user, only: [:edit, :update, :show]
  before_action :authorize_request, except: :create

  def index
    @users = User.paginate(page: params[:page], per_page:5)
    render json: @users, status: :ok
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # store all emails in lowercase to avoid duplicates and case-sensitive login errors:
    @user.email.downcase!

    if @user.save
      # If user saves in the db successfully:
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end


  def edit
    render json: @user, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :accepted
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private
  def get_user
    @user = User.find(params[:id])
  end
  def user_params
    params.permit(:firstname, :lastname, :email, :username, :password, :password_confirmation)
  end
end
