#!/bin/bash

#latitude="39.949539"
#longitude="-75.307373"
weather_api="https://api.weather.gov/gridpoints/PHI/45,75/forecast"

# Make an API request to get the weather forecast
weather_data=$(curl -s "$weather_api")

# Check if the request was successful
if [ $? -eq 0 ]; then
    # Parse and display relevant weather information using jq
    echo "Weather Forecast for Your Location Today:"
    echo "-------------------------------------"
    echo "Location: $(echo "$weather_data" | jq -r '.properties.periods[0].name') in Drexel Hill, PA"
    echo "Temperature: $(echo "$weather_data" | jq -r '.properties.periods[0].temperature')°F"
    echo "Conditions: $(echo "$weather_data" | jq -r '.properties.periods[0].shortForecast')"
    echo "Humidity: $(echo "$weather_data" | jq -r '.properties.periods[0].relativeHumidity.value')%"
    echo "Wind: $(echo "$weather_data" | jq -r '.properties.periods[0].windSpeed')"
    echo "-------------------------------------"
    echo "Location: $(echo "$weather_data" | jq -r '.properties.periods[1].name') in Drexel Hill, PA"
    echo "Temperature: $(echo "$weather_data" | jq -r '.properties.periods[1].temperature')°F"
    echo "Conditions: $(echo "$weather_data" | jq -r '.properties.periods[1].shortForecast')"
    echo "Humidity: $(echo "$weather_data" | jq -r '.properties.periods[1].relativeHumidity.value')%"
    echo "Wind: $(echo "$weather_data" | jq -r '.properties.periods[1].windSpeed')"
else
    echo "Failed to fetch weather data. Check your internet connection or the API URL."
fi
