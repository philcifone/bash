#!/bin/bash

#latitude="39.949539"
#longitude="-75.307373"
weather_api="https://api.weather.gov/gridpoints/PHI/45,75/forecast"

# Make an API request to get the weather forecast
weather_data=$(curl -s "$weather_api")

# Check if the request was successful
if [ $? -eq 0 ]; then
    # Parse and display relevant weather information using jq
    echo "Weather Forecast for Your Location:"
    echo "---------------------------------------------------------------------------------------------------------------"

    for i in {0..13}; do       # Change this number for amount of days in forecast
    location=$(echo "$weather_data" | jq -r ".properties.periods[$i].name")
    temperature=$(echo "$weather_data" | jq -r ".properties.periods[$i].temperature")°F
    conditions=$(echo "$weather_data" | jq -r ".properties.periods[$i].shortForecast")
    humidity=$(echo "$weather_data" | jq -r ".properties.periods[$i].relativeHumidity.value")%
    wind=$(echo "$weather_data" | jq -r ".properties.periods[$i].windSpeed")
    forecast=$(echo "$weather_data" | jq -r ".properties.periods[$i].detailedForecast")
    precipitation=$(echo "$weather_data" | jq -r ".properties.periods[$i].probabilityOfPrecipitation.value")
    
    # Check if precipitation is null, and replace it with "0"
    if [ "$precipitation" = "null" ]; then
        precipitation="0"
    fi

    echo "Location: $location in Drexel Hill, PA"
    echo "Temperature: $temperature"
    echo "Conditions: $conditions"
    echo "Humidity: $humidity"
    echo "Wind: $wind"
    echo "Chance of Precipitation: $precipitation%"
    echo "Detailed Forecast: $forecast"
    echo "---------------------------------------------------------------------------------------------------------------"
    done
else
    echo "Failed to fetch weather data. Check your internet connection or the API URL."
fi