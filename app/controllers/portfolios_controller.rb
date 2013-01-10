class PortfoliosController < ApplicationController

  require "net/http"
  require "uri"
  require "json"

  before_filter :authenticate_user!


  # GET /portfolios
  # GET /portfolios.json
  def index

    @tab = "account"
    @sub = "ports"

    @portfolios = current_user.portfolios

    # csdl_code   = current_user.custom_news_csdl
    # url         = 'http://api.datasift.com/compile?csdl=' + csdl_code + '&username=avitus&api_key=eb70061f6698584b4b79ca7d1d5ace4b'
    # uri         = URI.parse(URI.escape(url))
    # json_resp   = JSON.parse(Net::HTTP.get(uri))

    # @stream_hash = json_resp["hash"]
    # Rails.logger.debug("Datasift CSDL code: #{csdl_code}")
    # Rails.logger.debug("Stream hash is #{@stream_hash}")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @portfolios }
    end
  end

  # GET /portfolios/1
  # GET /portfolios/1.json
  def show
    @portfolio = Portfolio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @portfolio }
    end
  end

  # GET /portfolios/new
  # GET /portfolios/new.json
  def new

    if current_user.portfolios.length >= 2
      flash[:notice] = "You can only have two portfolios at this time."
      redirect_to portfolios_path
    else
      @portfolio = Portfolio.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @portfolio }
      end
    end

  end

  # GET /portfolios/1/edit
  def edit
    @portfolio = Portfolio.find(params[:id])
  end

  # POST /portfolios
  # POST /portfolios.json
  def create
    @portfolio 					= Portfolio.new(params[:portfolio])
    @portfolio.user_id	= current_user.id

    respond_to do |format|
      if @portfolio.save
        format.html { redirect_to @portfolio, notice: 'Portfolio was successfully created.' }
        format.json { render json: @portfolio, status: :created, location: @portfolio }
      else
        format.html { render action: "new" }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /portfolios/1
  # PUT /portfolios/1.json
  def update
    @portfolio = Portfolio.find(params[:id])

    respond_to do |format|
      if @portfolio.update_attributes(params[:portfolio])
        format.html { redirect_to @portfolio, notice: 'Portfolio was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfolios/1
  # DELETE /portfolios/1.json
  def destroy
    @portfolio = Portfolio.find(params[:id])
    @portfolio.destroy

    respond_to do |format|
      format.html { redirect_to portfolios_url }
      format.json { head :ok }
    end
  end

end
