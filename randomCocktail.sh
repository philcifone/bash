#!/bin/bash

# Define the API URL
API_URL="https://www.thecocktaildb.com/api/json/v1/1/random.php"

# Use `curl` to fetch a random cocktail data
cocktail_data=$(curl -s "$API_URL")

# Check if the API request was successful
if [ "$(jq -r '.drinks[0]' <<< "$cocktail_data")" == "null" ]; then
    echo "Failed to fetch a random cocktail. Please try again later."
    exit 1
fi

# Extract the cocktail name and instructions
cocktail_name=$(jq -r '.drinks[0].strDrink' <<< "$cocktail_data")
cocktail_instructions=$(jq -r '.drinks[0].strInstructions' <<< "$cocktail_data")

# Display the formatted output
echo "Random Cocktail: $cocktail_name"
echo "Ingredients: "

# Iterate through ingredients and measures
for i in {1..15}; do
    ingredient_key="strIngredient$i"
    measure_key="strMeasure$i"

    ingredient=$(jq -r ".drinks[0].$ingredient_key" <<< "$cocktail_data")
    measure=$(jq -r ".drinks[0].$measure_key" <<< "$cocktail_data")

    if [ "$ingredient" != "null" ] && [ "$measure" != "null" ]; then
        echo "$measure $ingredient"
    fi
done

echo "Instructions: $cocktail_instructions"

