class ListingsController < ApplicationController
  
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  # :authenticate_user! - Check if user is logged in
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_user, only: [:edit, :destroy, :update]
  # GET /listings
  # GET /listings.json
  def index
    puts "Current user: #{current_user.blank?}"
    @listings = Listing.all
  end

  # GET /listings/1
  # GET /listings/1.json
  def show

  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end
    # Check if current logged in user is same as one who create listing
    def check_user
      unless current_user == @listing.user
        redirect_to root_url, alert: 'Sorry, that listing belongs to someone else'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :description, :price, :image)
    end
end
