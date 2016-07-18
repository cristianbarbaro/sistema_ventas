class StocksController < ApplicationController
    def index
        @stocks = Stock.paginate(:page => params[:page]).order("current_amount - minimum_amount")
    end
end
