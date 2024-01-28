require 'open-uri'

class OpenWeatherService < ApplicationService
	attr_accessor :lat, :lng

	def initialize(lat, lng)
		@lat = lat
		@lng = lng
	end

	def call
		parse weather_info
	end

	private

	def api_key
		Rails.application.credentials.open_weather_key
	end

	def uri
		"https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lng}&appid=#{api_key}&units=imperial"
	end

	def parse(response)
		JSON.parse(response)
	end

	def weather_info
		URI.open(uri).read
	end
end
