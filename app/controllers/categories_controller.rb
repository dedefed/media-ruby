class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate(page: params[:page], per_page:5)
    render json: @categories, status: :ok
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(param_category)
    if @category.save
      render json: @category, status: :created
    else
      render json: { errors: @category.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def edit

  end

  def show

  end

  def update
    if @category.update(user_params)
      render json: @category, status: :ok
    else
      render json: { errors: @category.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private
  def param_category
    params.permit(:name, :parent_id);
  end
end
