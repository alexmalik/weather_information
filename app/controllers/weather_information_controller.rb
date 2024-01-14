class WeatherInformationController < ApplicationController
	def index
	end

	def data
		open_weather_key = Rails.application.credentials.open_weather_key
		uri = "https://api.openweathermap.org/data/2.5/weather?lat=#{params[:location_latitude]}&lon=#{params[:location_longitude]}&appid=#{open_weather_key}"

		head :ok
	end
end
