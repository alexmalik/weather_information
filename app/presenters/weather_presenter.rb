class WeatherPresenter
	def initialize(weather)
		@weather = weather
	end

	def conditions
		"#{primary_condition} - #{condition_description}"
	end

	def temperature
		# add a converter
		"#{weather['main']['temp']} ℉"
	end

	def feels_like
		"#{weather['main']['feels_like']} ℉"
	end

	def min_temp
		"#{weather['main']['temp_min']} ℉"
	end

	def max_temp
		"#{weather['main']['temp_max']} ℉"
	end

	def pressure
		"#{weather['main']['pressure']} hPa"
	end

	def humidity
		"#{weather['main']['humidity']}%"
	end

	def visibility
		# convert to kilometers automatically
		"#{weather['visibility']} m"
	end

	def wind
		"#{weather['wind']['speed']} mph"
	end

	def sunrise
		# change timezone to the location we are searching in order to accurately represent the sunrise at the location being searched
		convert_time(weather['sys']['sunrise'])
	end

	def sunset
		# change timezone to the location we are searching in order to accurately represent the sunrise at the location being searched
		convert_time(weather['sys']['sunset'])
	end

	private

	attr_reader :weather

	def convert_time(time)
		Time.at(time).strftime('%H:%M')
	end

	def primary_condition
		weather['weather'][0]['main']
	end

	def condition_description
		weather['weather'][0]['description'].titleize
	end
end