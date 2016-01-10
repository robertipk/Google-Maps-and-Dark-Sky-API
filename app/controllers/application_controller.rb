require 'forecast_io'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def getWeather(latitude, longitude)
  	ForecastIO.api_key = 'dc105edc628388d692f7af6a159918d7'
    forecast = ForecastIO.forecast(latitude,longitude)
  end
end
