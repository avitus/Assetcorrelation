# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP ADMIN USER LOGIN'

user = User.find_or_create_by(email: 'avitus@gmail.com') do |user|
  user.name                   = 'Andy Vitus'
  user.password               = 'please'
  user.password_confirmation  = 'please'
  user.admin                  = true
end

puts 'New user created: ' << user.name

puts 'CREATING SUBSCRIPTION PLANS'

Plan.create!(:name => "Basic", :price => 9.99, :description => "Entry level plan")

puts 'ADDING ASSETS'

[ ["TIP",   "iShares Barclays TIPS Bond Fund"],
  ["GLD",   "SPDR Gold Shares"],
  ["AGG",   "iShares Barclays Aggregate Bond"],
  ["USO",   "United States Oil"],
  ["GSG",   "iShares S&P GSCI Commodity-Indexed Trust"],
  ["VNQ",   "Vanguard REIT Index ETF"],
  ["RWX",   "SPDR Dow Jones Intl Real Estate"],
  ["EEM",   "iShares MSCI Emerging Markets Index"],
  ["EFA",   "iShares MSCI EAFE Index"],
  ["VB",    "Vanguard Small Cap ETF"],
  ["VO",    "Vanguard Mid-Cap ETF"],
  ["VV",    "Vanguard Large Cap ETF"],
  ["TLT",   "iShares Barclays 20+ Year Treasury Bond"],
  ["EMB",   "iShares JPMorgan USD Emerging Markets Bond"],
  ["^GSPC", "S&P 500 Index"],
  ["EZA",   "iShares MSCI South Africa Index"],
  ["EWQ",   "iShares MSCI France Index Fund"],
  ["EWG",   "iShares MSCI Germany Index Fund"],
  ["EWC",   "iShares MSCI Canada Index Fund"],
  ["EWD",   "iShares MSCI Sweden Index"],
  ["EWU",   "iShares MSCI United Kingdom Index"],
  ["EWA",   "iShares MSCI Australia Index"],
  ["EWJ",   "iShares MSCI Japan Index Fund"],
  ["EWY",   "iShares MSCI South Korea Index"],
  ["EWT",   "iShares MSCI Taiwan Index Fund"],
  ["EWZ",   "iShares MSCI Brazil Index Fund"],
  ["ECH",   "iShares MSCI Chile Investable Mkt Idx"],
  ["EWW",   "iShares MSCI Mexico Investable Mkt Idx"],
  ["EIS",   "iShares MSCI Israel Cap Invest Mkt Index"],
  ["TUR",   "iShares MSCI Turkey Invest Mkt Index"],
  ["SPY",   "SPDR S&P 500"],
  ["XLY",   "Consumer Discret Select Sector SPDR"],
  ["XLP",   "Consumer Staples Select Sector SPDR"],
  ["XLE",   "Energy Select Sector SPDR"],
  ["XLF",   "Financial Select Sector SPDR"],
  ["XLV",   "Health Care Select Sector SPDR"],
  ["XLI",   "Industrial Select Sector SPDR"],
  ["XLB",   "Materials Select Sector SPDR"],
  ["XLK",   "Technology Select Sector SPDR"],
  ["XLU",   "Utilities Select Sector SPDR"],
  ["SHV",   "iShares Barclays Short Treasury Bond"],
  ["SHY",   "iShares Barclays 1-3 Year Treasury Bond"],
  ["IEI",   "iShares Barclays 3-7 Year Treasury Bond"],
  ["IEF",   "iShares Barclays 7-10 Year Treasury"],
  ["TLH",   "iShares Barclays 10-20 Year Treasury Bd"],
  ["LQD",   "iShares iBoxx $ Invest Grade Corp Bond"],
  ["HYG",   "iShares iBoxx $ HY Corp Bond Fund"],
  ["MUB",   "iShares S&P National AMT-Free Muni Bd"],
  ["MBB",   "iShares Barclays MBS Bond"] ].each do |a|
    Security.find_or_create_by(ticker: a[0]) do |ticker|
     ticker.name = a[1]
    end
  end




