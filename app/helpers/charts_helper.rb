module ChartsHelper
  def calculate_totals(scope, start_date, end_date, category_association, category_column)
    data = scope.where(date: start_date..end_date)
                .joins(category_association)
                .group("#{category_column}.name")
                .sum(:amount)

    no_category_sum = scope.where(date: start_date..end_date).where(category_association => nil).sum(:amount)
    total_sum = data.values.sum + no_category_sum
    [total_sum, data, no_category_sum]
  end

  def create_chart_image(data, no_category_sum, filename)
    g = Gruff::Pie.new
    g.theme = Gruff::Themes::PASTEL

    data.each do |category_name, amount|
      g.data(category_name, amount)
    end

    no_category_sum.positive? && g.data(t('charts.no_category'), no_category_sum)

    file_path = Rails.root.join('public', 'charts', filename)
    g.write(file_path.to_s)
    "charts/#{filename}"
  rescue StandardError => e
    Rails.logger.error "Failed to create chart image: #{e.message}"
    nil
  end
end