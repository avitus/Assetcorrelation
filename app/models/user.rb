class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :portfolios
  has_many :positions, :through => :portfolios

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  def custom_news_csdl

    # Example of Twitter stream CSDL
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # 
    # tag "tweet" { interaction.type == "twitter" }
    #
    # return {
    #   interaction.type == "twitter"
    #   and interaction.content any "investing, stock market, portfolio diversification, portfolio theory, asset correlation, index funds, hedge funds, exchange-traded funds, IRR, quantitative investing, value stocks, growth stocks, asset class, real estate, bond market, howard marks, warren buffet, stock market indicator"
    #   and
    #     (
    #       salience.content.topics any "investing, business" or
    #       salience.title.topics any "investing, business"
    #     )
    #   and klout.amplification > 7
    #   and klout.score > 40
    #   and klout.topics any "investing, stock market, finance, money, berkshire, business, markets, economics, debt, trading"
    # }


    general_news_string = 'stream "61392d9974b126060243b7ff9edd6579" '
    interaction_string  = 'interaction.type != "twitter" AND interaction.content any "'
    twitter_string      = '    interaction.type == "twitter" 
                           AND klout.amplification > 7 
                           AND klout.score > 40 
                           AND klout.topics any "investing, stock market, finance, money, berkshire, business, markets, economics, debt, trading"
                           AND (salience.content.topics any "investing, business" OR salience.title.topics any "investing, business")
                           AND interaction.content any "'
    links_string        = 'links.title any "'
    csdl_string         = ''

    holdings = self.positions.includes(:security)
    tickers  = holdings.map { |h| h.security.ticker }.uniq!  # get array of all tickers a user has in her portfolios

    tickers.each do |t|
        interaction_string << '$' + t + ', ' 
        twitter_string     << '$' + t + ', ' 
        links_string       << '$' + t + ', '  # trailing comma doesn't seem to cause a problem
    end

    # close quotes
    interaction_string << '"'
    twitter_string     << '"'
    links_string       << '"'

    csdl_string << 'return { language.tag == "en" 
                             AND (' + general_news_string + ' OR ' + interaction_string + ' OR ' + twitter_string + ' OR ' + links_string + ') 
                           }' 

    return csdl_string

  end

end
