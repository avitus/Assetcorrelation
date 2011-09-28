# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP ADMIN USER LOGIN'
user = User.find_or_create_by_email(:email => 'andy@scalevp.com', :name => 'Andy Vitus',  :password => 'please', :password_confirmation => 'please', :admin => true)
puts 'New user created: ' << user.name

puts 'ADDING ASSETS'

[ ["TIP", "iShares Barclays TIPS Bond Fund"],
  ["GLD", "SPDR Gold Shares"],
  ["AGG", "iShares Barclays Aggregate Bond"],
  ["USO", "United States Oil"],
  ["GSG", "iShares S&P GSCI Commodity-Indexed Trust"],
  ["VNQ", "Vanguard REIT Index ETF"],
  ["RWX", "SPDR Dow Jones Intl Real Estate"],
  ["EEM", "iShares MSCI Emerging Markets Index"],
  ["EFA", "iShares MSCI EAFE Index"],
  ["VB",  "Vanguard Small Cap ETF"],
  ["VO",  "Vanguard Mid-Cap ETF"],
  ["VV",  "Vanguard Large Cap ETF"],
  ["TLT", "iShares Barclays 20+ Year Treasury Bond"],
  ["EMB", "iShares JPMorgan USD Emerging Markets Bond"] ].each do |a|
    Asset.find_or_create_by_ticker(:ticker => a[0], :name => a[1])
    end


