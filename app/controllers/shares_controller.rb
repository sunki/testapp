class SharesController < ApplicationController

  def index
    yclient = YahooFinance::Client.new
    @symbols = yclient.symbols_by_market('us', 'nyse').sort
    # FIXME: Some symbols breaks Yahoo API calls
    @symbols = @symbols.reject{ |s| s =~ /\^/ }

    @share = Share.new
    @shares = current_user.shares.all

    @start_date = 2.years.ago

    @quotes = @shares.inject(Hash.new{ |h,k| h[k] = {} }) do |res, share|
      symbol = share.symbol
      quotes = yclient.historical_quotes(symbol, start_date: @start_date, end_date: Time.now)

      quotes.each do |quote|
        res[quote.trade_date][symbol] = quote.close.to_d
      end
      res
    end
  end

  def create
    @share = current_user.shares.create(params[:share].permit(:symbol))
    redirect_to(action: :index)
  end

  def destroy
    @share = current_user.shares.destroy(params[:share_id])
    redirect_to(action: :index)
  end
end
