module HistoricsHelper
  def get_historic_cost_price(historic_id)
    ActionController::Base.helpers.number_with_precision(Historic.find(historic_id).cost_price, precision: 2, separator: '.')
  end
end
