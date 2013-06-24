class SecuritiesController < ApplicationController

  before_filter :authenticate_user!, :except => :valid_security

  # GET /assets
  # GET /assets.json
  def index
    @securities = Security.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @securities }
    end
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
    @security = Security.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @security }
    end
  end

  # GET /assets/new
  # GET /assets/new.json
  def new
    @security = Security.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @security }
    end
  end

  # GET /assets/1/edit
  def edit
    @security = Security.find(params[:id])
  end

  # POST /assets
  # POST /assets.json
  def create
    @security = Security.new(params[:security])

    respond_to do |format|
      if @security.save
        format.html { redirect_to @security, notice: 'Security was successfully created.' }
        format.json { render json: @security, status: :created, location: @security }
      else
        format.html { render action: "new" }
        format.json { render json: @security.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.json
  def update
    @security = Security.find(params[:id])

    respond_to do |format|
      if @security.update_attributes(params[:security])
        format.html { redirect_to @security, notice: 'Security was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @security.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @security = Security.find(params[:id])
    @security.destroy

    respond_to do |format|
      format.html { redirect_to securities_url }
      format.json { head :ok }
    end
  end

  # ----------------------------------------------------------------------------------------------------------
  # Check whether ticker represents valid security
  # ----------------------------------------------------------------------------------------------------------
  def valid_security
  	query = params[:query]

  	if valid_ticker?(query)

    	asset = Security.find_by_ticker( query.upcase )

    	unless asset
    		# Check with Yahoo
    		Rails.logger.info("=== Querying Yahoo for security: #{query}")
    		ticker = query.upcase
  		  quote_type  = YahooFinance::StandardQuote
  		  quote       = YahooFinance::get_quotes( quote_type, ticker )
  		  # A valid return will result in quote[ticker].nil? and quote[ticker].blank? being false.
  		  # However, even if the ticker does not exist, the call to YahooFinance will result in a
  		  # valid quote but the date field will be "N/A"
  		  # 10/15/2008 -- Some money market funds return a valid date field but have no trading history

  		  if quote[ticker]
  		    # Check for 5 days of history and a valid date field
  		    has_history = YahooFinance::get_historical_quotes_days(ticker, 7).size > 0
  		    if (quote[ticker].date != "N/A") && has_history
  		      if Security.exists?( :name => quote[ticker].name)
  		        # Create asset with unique name
  		        uniq_name = quote[ticker].name + " DUPLICATE-NAME" + " " + Time.now.to_s
              asset = Security.create( :name => uniq_name, :ticker => quote[ticker].symbol )
  		      else
              # Create new asset in DB
              asset = Security.create( :name => quote[ticker].name, :ticker => quote[ticker].symbol )
  		      end
  		    else
  		    	asset = nil # no proper price history
  		    end
  		  else
  				asset = nil  # no quote returned by Yahoo
  		  end

    	end

    else
      asset = nil  # not a valid ticker
    end


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: asset }
    end

  end


end
