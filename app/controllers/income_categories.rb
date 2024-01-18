class IncomeCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :build_income_category, only: %i[new create]
  before_action :set_income_category, only: %i[edit update destroy]

  def index
    @income_categories = current_user.income_categories
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    render turbo_stream: turbo_stream.replace('settings_container', partial: 'settings/incomes_category/new')
  end

  def create
    @income_category.assign_attributes(income_category_params)
    if @income_category.save
      render turbo_stream: [
        turbo_stream.replace('settings_container', partial: 'settings/incomes_category/list'),
        turbo_stream.after('settings_container', partial: 'settings/incomes_category/new')
      ]
    else
      render turbo_stream: turbo_stream.replace('settings_container', partial: 'settings/incomes_category/new')
    end
  end

  def edit
    render turbo_stream: turbo_stream.replace('settings_container', partial: 'settings/incomes_category/edit')
  end

  def update
    if @income_category.update(income_category_params)
      render turbo_stream: [
        turbo_stream.replace('settings_container', partial: 'settings/incomes_category/list'),
        turbo_stream.after('settings_container', partial: 'settings/incomes_category/new')
      ]
    else
      render turbo_stream: turbo_stream.replace('settings_container', partial: 'settings/incomes_category/edit')
    end
  end

  def destroy
    @income_category.destroy
    render turbo_stream: turbo_stream.replace('settings_container', partial: 'settings/incomes_category/list')
  end

  private

  def build_income_category
    @income_category = current_user.income_categories.build
  end

  def set_income_category
    @income_category = current_user.income_categories.find(params[:id])
  end

  def income_category_params
    params.require(:income_category).permit(:name)
  end
end
