class PriceQuotesController < ApplicationController
  # GET /price_quotes
  # GET /price_quotes.json
  def index
    @price_quotes = PriceQuote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @price_quotes }
    end
  end

  # GET /price_quotes/1
  # GET /price_quotes/1.json
  def show
    @price_quote = PriceQuote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @price_quote }
    end
  end

  # GET /price_quotes/new
  # GET /price_quotes/new.json
  def new
    @price_quote = PriceQuote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @price_quote }
    end
  end

  # GET /price_quotes/1/edit
  def edit
    @price_quote = PriceQuote.find(params[:id])
  end

  # POST /price_quotes
  # POST /price_quotes.json
  def create
    @price_quote = PriceQuote.new(params[:price_quote])

    respond_to do |format|
      if @price_quote.save
        format.html { redirect_to @price_quote, notice: 'Price quote was successfully created.' }
        format.json { render json: @price_quote, status: :created, location: @price_quote }
      else
        format.html { render action: "new" }
        format.json { render json: @price_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /price_quotes/1
  # PUT /price_quotes/1.json
  def update
    @price_quote = PriceQuote.find(params[:id])

    respond_to do |format|
      if @price_quote.update_attributes(params[:price_quote])
        format.html { redirect_to @price_quote, notice: 'Price quote was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @price_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /price_quotes/1
  # DELETE /price_quotes/1.json
  def destroy
    @price_quote = PriceQuote.find(params[:id])
    @price_quote.destroy

    respond_to do |format|
      format.html { redirect_to price_quotes_url }
      format.json { head :ok }
    end
  end
end
