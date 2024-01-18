class ChartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_date_range
  include ChartsHelper

  def index
    @total_income, income_data, income_no_category_sum = calculate_totals(
      current_user.incomes,
      @start_date,
      @end_date,
      :income_category,
      'income_categories'
    )
    @total_payment, payment_data, payment_no_category_sum = calculate_totals(
      current_user.payments,
      @start_date,
      @end_date,
      :payment_category,
      'payment_categories'
    )

    @income_chart_filename = create_chart_image(income_data, income_no_category_sum, 'income_chart.jpg')
    @payment_chart_filename = create_chart_image(payment_data, payment_no_category_sum, 'payment_chart.jpg')

    @monthly_result = @total_income - @total_payment
    @monthly_status = determine_monthly_status(@monthly_result)
  end

  private

  def set_date_range
    year = params.dig(:search, 'month(1i)').to_i.positive? ? params[:search]['month(1i)'].to_i : Date.today.year
    month = params.dig(:search, 'month(2i)').to_i.positive? ? params[:search]['month(2i)'].to_i : Date.today.month

    @start_date = Date.new(year, month).beginning_of_month
    @end_date = @start_date.end_of_month
  end

  def determine_monthly_status(monthly_result)
    monthly_result >= 0 ? t('charts.result_profit') : t('charts.result_loss')
  end
end