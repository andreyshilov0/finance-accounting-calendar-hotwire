class PaymentCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :build_payment_category, only: %i[new create]
  before_action :set_payment_category, only: %i[edit update destroy]

  def index
    @payment_categories = current_user.payment_categories
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    render turbo_stream: turbo_stream.replace('settings_container', partial: 'settings/payments_category/new')
  end

  def create
    @payment_category.assign_attributes(payment_category_params)
    if @payment_category.save
      render turbo_stream: [
        turbo_stream.replace('settings_container', partial: 'settings/payments_category/list'),
        turbo_stream.after('settings_container', partial: 'settings/payments_category/new')
      ]
    else
      render turbo_stream: turbo_stream.replace('settings_container', partial: 'settings/payments_category/new')
    end
  end

  def edit
    render turbo_stream: turbo_stream.replace('settings_container', partial: 'settings/payments_category/edit')
  end

  def update
    if @payment_category.update(payment_category_params)
      render turbo_stream: [
        turbo_stream.replace('settings_container', partial: 'settings/payments_category/list'),
        turbo_stream.after('settings_container', partial: 'settings/payments_category/new')
      ]
    else
      render turbo_stream: turbo_stream.replace('settings_container', partial: 'settings/payments_category/edit')
    end
  end

  def destroy
    @payment_category.destroy
    render turbo_stream: turbo_stream.replace('settings_container', partial: 'settings/payments_category/list')
  end

  private

  def build_payment_category
    @payment_category = current_user.payment_categories.build
  end

  def set_payment_category
    @payment_category = current_user.payment_categories.find(params[:id])
  end

  def payment_category_params
    params.require(:payment_category).permit(:name)
  end
end
