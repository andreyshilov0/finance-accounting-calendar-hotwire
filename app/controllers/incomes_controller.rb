class IncomesController < ApplicationController
  def index
    @incomes = Income.all
  end
end
