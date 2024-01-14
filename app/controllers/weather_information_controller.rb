class WeatherInformationController < ApplicationController
	def index
	end

	def data
		open_weather_service = OpenWeatherService.new(lat: params[:location_latitude], lng: params[:location_longitude])
		weather_response = open_weather_service.weather

		head :ok
	end
end
