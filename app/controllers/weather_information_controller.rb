class WeatherInformationController < ApplicationController
	def index
	end

	def data
		respond_to do |format|
			if params[:latitude] && params[:longitude]
				@weather_info = OpenWeatherService.call(params[:latitude], params[:longitude])

				format.turbo_stream
			else
				format.html { redirect_to root_path, notice: 'Please input a valid location' }
			end
		end
	end
end
