require 'rails_helper'

RSpec.describe WeatherPresenter do
	subject(:weather_presenter) { described_class.new(parsed_json) }

	let(:weather_json) { File.open('spec/fixtures/open_weather_response_body.json').read }
	let(:parsed_json) { JSON.parse(weather_json) }

	it 'returns weather conditions' do
		expect(weather_presenter.conditions).to eq 'Rain - Light Rain'
	end

	it 'returns temperature information' do
		expect(weather_presenter.temperature).to eq '37.53 ℉'
	end

	it "returns 'feels like' temperature" do
		expect(weather_presenter.feels_like).to eq '28.31 ℉'
	end

	it 'returns minimum temperature' do
		expect(weather_presenter.min_temp).to eq '33.62 ℉'
	end

	it 'returns maximum temperature' do
		expect(weather_presenter.max_temp).to eq '40.08 ℉'
	end

	it 'returns atmospheric pressure on sea level' do
		expect(weather_presenter.pressure).to eq '1011 hPa'
	end

	it 'returns humidity' do
		expect(weather_presenter.humidity).to eq '94%'
	end

	it 'returns visibility' do
		expect(weather_presenter.visibility).to eq '10000 m'
	end

	it 'returns wind speed' do
		expect(weather_presenter.wind).to eq '16.11 mph'
	end

	it 'returns time of sunrise' do
		expect(weather_presenter.sunrise).to eq '05:34'
	end

	it 'returns time of sunset' do
		expect(weather_presenter.sunset).to eq '15:21'
	end
end