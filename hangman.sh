#!/bin/bash

# Hangman game in Bash

# Define a list of words for the game
WORDS=("computer" "bicycle" "house" "programming" "linux" "bash" "script")

# Select a random word from the list
WORD=${WORDS[$RANDOM % ${#WORDS[@]}]}

# Create a variable to hold the display version of the word
DISPLAY=$(echo $WORD | sed 's/./_/g')

# Number of allowed wrong attempts
MAX_ATTEMPTS=6

# Initialize the number of attempts made
ATTEMPTS=0 

# Store the letters guessed
GUESSES=""

# Game logic
while [[ $ATTEMPTS -lt $MAX_ATTEMPTS ]]; do
    echo "Current word: $DISPLAY"
    echo "Guesses so far: $GUESSES"
    echo "Attempts left: $((MAX_ATTEMPTS - ATTEMPTS))"
    echo -n "Guess a letter or the whole word: "
    read -n 1 GUESS
    echo

    if [[ $GUESS = "" ]]; then
        echo "Please enter a guess."
        continue
    fi

    # Check if the guess is in the word
    if [[ $WORD == *$GUESS* ]] || [[ $WORD == $GUESS ]]; then
        echo "Correct!"
        # Reveal the letter in DISPLAY
        for (( i=0; i<${#WORD}; i++ )); do
            if [[ ${WORD:$i:1} == $GUESS ]]; then
                DISPLAY=$(echo $DISPLAY | sed "s/./$GUESS/$((i+1))")
            fi
        done
        GUESSES+="$GUESS "
    else
        echo "Incorrect."
        ATTEMPTS=$((ATTEMPTS + 1))
        GUESSES+="$GUESS "
    fi

    # Check for win
    if [[ $DISPLAY == $WORD ]] || [[ $GUESS == $WORD ]]; then
        echo "Congratulations, you've won! The word was \"$WORD\"."
        exit
    fi
done

echo "Game over. The word was \"$WORD\"."
