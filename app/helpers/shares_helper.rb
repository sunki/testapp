module SharesHelper

  def quotes_chart_data(titles, data, from, to = nil)
    to ||= Time.now
    prev_quotes = nil

    quotes = (Date.new(from.year, from.month, from.day) .. Date.new(to.year, to.month, to.day) - 1.day).inject([]) do |res, date|
      date = date.strftime('%Y-%m-%d')
      cur_quotes = titles.map{ |t| data[date][t] }

      prev_quotes = cur_quotes if cur_quotes.any?
      next res unless prev_quotes

      res << [date] + prev_quotes
    end
    [['Date'] + titles] + quotes
  end

end
