class User < ActiveRecord::Base
	geocoded_by :address
	after_validation :geocode

	def self.get_weather
		ForecastIO.api_key = 'dc105edc628388d692f7af6a159918d7'
        forecast = ForecastIO.forecast(latitude, longitude)
        current_weather = forecast[:currently].summary
        temperature = forecast[:currently].temperature
        timezone = forecast[:timezone]
        offset = forecast[:offset]
        time = Time.at(forecast[:currently].time)
        save
    end
end
