require 'date'
require 'csv'
require 'pry'
require 'bigdecimal/util'

raw_csv = IO.read('BTC_USD_2013-10-01_2021-07-21-CoinDesk.csv')
csv = CSV.parse(raw_csv, headers: true)
price_data = {}
csv.each do |row|
  date = Date.parse(row['date'] || row['Date'])
  value = row['24h High (USD)'].to_d
  key = date.strftime("%Y-%m-01")
  price_data[key] ||= value
  if value > price_data[key]
    price_data[key] = value
  end
end

new_raw_csv = CSV.generate do |new_csv|
  new_csv << ['date', 'Month High (USD)']
  price_data.each do |date,value|
    new_csv << [date, value]
  end
end

IO.write('bitcoin-monthly-high-price.csv', new_raw_csv)
