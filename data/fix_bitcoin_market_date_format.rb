require 'date'
require 'csv'
require 'pry'
require 'bigdecimal/util'

raw_csv = IO.read('bitcoin-market-price-2009-2013.csv')
csv = CSV.parse(raw_csv, headers: true)
new_raw_csv = CSV.generate do |new_csv|
  new_csv << ['date', '24 High (USD)']
  csv.each do |row|
    new_csv << [
        Date.parse(row['date']).strftime('%Y-%m-%d'),
        row['24 High (USD)']
      ]
  end
end

IO.write('bitcoin-market-price-2009-2013-formatted.csv', new_raw_csv)
