require 'forecast_io'
require 'HTTParty'
require 'date'


class UsersController < ApplicationController
  include HTTParty
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.address
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    response = retrieve_NASA_image(@user)  
    @user.URL = response["url"]
    @user.Phototime = response["date"]
    @user.Cloudindex = response["cloud_score"]

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        forecast = getWeather(@user.latitude,@user.longitude)
        update_weather(@user, forecast)
        
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
      forecast = getWeather(@user.latitude,@user.longitude)
      update_weather(@user, forecast)
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:latitude, :longitude, :name, :address, :title)
    end

    def update_weather(user,forecast)
        user.current_weather = forecast[:currently].summary
        user.temperature = forecast[:currently].temperature
        user.timezone = forecast[:timezone]
        user.offset = forecast[:offset]
        user.time = Time.at(forecast[:currently].time)
        user.save
    end

    def retrieve_NASA_image(user)
      query = "https://api.nasa.gov/planetary/earth/imagery?lon=" + user.longitude.to_s + "&lat=" + user.latitude.to_s + "&date=2015-07-01&cloud_score=True&api_key=DEMO_KEY"
      response = HTTParty.get(query) 
    end
end
