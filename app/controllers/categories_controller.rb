class CategoriesController < ApplicationController
  before_action :get_category, only: [:edit, :update, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page:20)
    render json: @categories, status: :ok
  end

  def new
    @category = Category.new

  end

  def create
    @category = Category.new(name: params[:name].downcase)

    if @category.save
      add_parents
      render json: @category, status: :created
    else
      render json: { errors: @category.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def edit

  end

  def show
    render json: @category.children, status: :ok
  end

  def update
    if @category.update(name: params[:name])
      update_parents
      render json: @category, status: :ok
    else
      render json: { errors: @category.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private
  def add_parents
    if params[:parents].present?
      params[:parents].split(',').each do |parent_id|
        @parent_category = Category.find(parent_id)
        @category_parent = CategoryParent.new(parent_id: @parent_category.id, child_id: @category.id)
        if @category_parent.save == false
          ActiveRecord::Rollback
          render json: { errors: @category_parent.errors.full_messages }
        end
      end
    end

  end
  def remove_parents
    @category_parents = CategoryParent.where(child_id: @category.id)
    @category_parents.each do |category_parent|
      CategoryParent.destroy(category_parent.id)
    end
  end
  def update_parents
    remove_parents
    add_parents
  end

  def get_category
    @category = Category.find(params[:id])
  end
  def param_category
    params.permit(:name, :parent_id);
  end
  def param_category_parent
    params.permit(:child_id, :parent_id)
  end
end
