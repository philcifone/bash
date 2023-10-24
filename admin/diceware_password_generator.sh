#!/bin/bash

# Check if the word list file exists
WORD_LIST="/lib/eff_large_wordlist.txt"

if [ ! -f "$WORD_LIST" ]; then
    echo "Error: Diceware word list file not found."
    exit 1
fi

# Number of words in the password
NUM_WORDS=5

# Function to roll a single dice (generate a random number between 1 and 6)
roll_dice() {
  echo $((1 + $RANDOM % 6))
}

# Function to generate a random word from the word list
get_random_word() {
  local word_list_file="$1"
  local line_number=$(($(roll_dice) * 1000 + $(roll_dice) * 100 + $(roll_dice) * 10 + $(roll_dice)))
  local word=$(sed -n "${line_number}p" "$word_list_file" | awk '{print $2}')
  echo "$word"
}

# Generate the Diceware password
diceware_password=""

for ((i = 1; i <= NUM_WORDS; i++)); do
    word=$(get_random_word "$WORD_LIST")
    diceware_password="${diceware_password}${word} "
done

# Remove trailing space
diceware_password=${diceware_password% }

echo "Diceware Password: $diceware_password"

