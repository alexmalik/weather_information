class WeatherInformationController < ApplicationController
	def index
	end

	def data
		weather = OpenWeatherService.call(params[:location_latitude], params[:location_longitude])

		head :ok
	end
end
