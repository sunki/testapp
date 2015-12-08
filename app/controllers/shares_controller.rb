class SharesController < ApplicationController

  def index
    yclient = YahooFinance::Client.new
    @symbols = yclient.symbols_by_market('us', 'nyse').sort

    @share = Share.new
    @shares = Share.all

    @start_date = 2.years.ago

    @quotes = @shares.inject(Hash.new{ |h,k| h[k] = {} }) do |res, share|
      symbol = share.symbol
      quotes = yclient.historical_quotes(symbol, start_date: @start_date, end_date: Time.now)

      quotes.each do |quote|
        res[quote.trade_date][symbol] = quote.close.to_d
        res
      end
      res
    end
  end

  def create
    @share = Share.create(params[:share].permit(:symbol))
    redirect_to(action: :index)
  end

  def destroy
    @share = Share.destroy(params[:share_id])
    redirect_to(action: :index)
  end
end
