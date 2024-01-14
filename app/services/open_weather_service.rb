require 'open-uri'

class OpenWeatherService
	attr_accessor :lat, :lng

	def initialize(lat:, lng:)
		@lat = lat
		@lng = lng
	end

	def weather
		JSON.parse(URI.open(uri).read)
	end

	private

	def api_key
		Rails.application.credentials.open_weather_key
	end

	def uri
		"https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lng}&appid=#{api_key}"
	end
end
