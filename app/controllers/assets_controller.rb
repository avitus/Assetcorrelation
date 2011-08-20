class AssetsController < ApplicationController
  # GET /assets
  # GET /assets.json
  def index
    @assets = Asset.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assets }
    end
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
    @asset = Asset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /assets/new
  # GET /assets/new.json
  def new
    @asset = Asset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = Asset.find(params[:id])
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, notice: 'Asset was successfully created.' }
        format.json { render json: @asset, status: :created, location: @asset }
      else
        format.html { render action: "new" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.json
  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to assets_url }
      format.json { head :ok }
    end
  end
  
  def valid_asset
  	query = params[:query]
  	asset = Asset.find_by_ticker( query.upcase )
  		
  	unless asset
  		# Check with Yahoo
  		Rails.logger.info("=== Querying Yahoo for asset: #{query}")
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
		      # Create new asset in DB
		      asset = Asset.create( :name => quote[ticker].name, :ticker => quote[ticker].symbol )
		    else
		    	asset = nil
		    end 	
		  else
				asset = nil
		  end		    
		    		
  	end
  		
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: asset }
    end  		
  		
  end
  
  
end
