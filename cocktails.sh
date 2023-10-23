#!/bin/bash
#
# Cocktail Recipe Lookup by Phil Cifone
#         
# phil@philcifone.com
#
#
# Fetches data from the https://www.thecocktaildb.com API -- Thank you!
#
#
#

# user input for spirit selection & API variable
echo "What spirit would you like cocktail recipes for?"

read spirit

spirit_formatted=$(echo "$spirit" | tr ' ' '+')

spiritAPI="https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=$spirit_formatted"

# Use `curl` to fetch cocktail list
cocktail_list=$(curl -s "$spiritAPI")

# Check if the API request was successful
if [ "$(jq -r '.drinks[0].strDrink' <<< "$cocktail_list")" == "" ]; then
    echo "Failed to fetch cocktail recipes for '$spirit'. Please try again later."
    exit 1
fi

echo "Cocktails: "

# Extract and display cocktail names
for i in {0..1000}; do
    cocktail_name=$(jq -r ".drinks[$i].strDrink" <<< "$cocktail_list")
    
    # Check if the cocktail_name is null, and exit the loop
    if [ "$cocktail_name" == "null" ]; then
        break
    fi
    
    echo "$cocktail_name"
done

echo "Which recipe would you like to see?"

read drink_id

# Replace spaces with plus symbols in user input
drink_id_formatted=$(echo "$drink_id" | tr ' ' '+')

cocktail_API="https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$drink_id_formatted"

# Use `curl` to fetch cocktail list
cocktail_data=$(curl -s "$cocktail_API")

# Check if the API request was successful
if [ "$(jq -r '.drinks[0].strDrink' <<< "$cocktail_data")" == "null" ]; then
    echo "Failed to fetch cocktail recipes for '$spirit'. Please try again later."
    exit 1
fi

# Extract the cocktail name and instructions
cocktail_name=$(jq -r '.drinks[0].strDrink' <<< "$cocktail_data")
cocktail_glass=$(jq -r '.drinks[0].strGlass' <<< "$cocktail_data")
cocktail_instructions=$(jq -r '.drinks[0].strInstructions' <<< "$cocktail_data")

# Display the formatted output
echo "Cocktail: $cocktail_name"
echo "Suggested Glassware: $cocktail_glass"
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

