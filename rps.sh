#!/bin/bash

# Color definitions
RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
MAGENTA='\e[1;35m'
CYAN='\e[1;36m'
RESET='\e[0m'

# Initialise running scores
playerScore=0
computerScore=0

# Display colorful welcome message
echo -e "${MAGENTA}🎮 Welcome to Rock, Paper, Scissors! 🎮${RESET}"
echo -e "${CYAN}Enter your choice:${RESET} (${GREEN}rock/r${RESET}, ${BLUE}paper/p${RESET}, or ${RED}scissors/s${RESET})"

while true; do
    # Read in player choice
    read playerChoiceWord

    # Maps rock -> 0, paper -> 1, scissors -> 2
    function wordToNum ()
    {
        if [ "$1" = "rock" ] || [ "$1" = "r" ]
            then local num=0
        elif [ "$1" = "paper" ] || [ "$1" = "p" ]
            then local num=1
        elif [ "$1" = "scissors" ] || [ "$1" = "s" ]
            then local num=2
        else
            echo -e "${RED}Invalid choice! Please choose rock(r), paper(p), or scissors(s)${RESET}"
        fi

        echo "$num"
    }

    # Maps 0 -> rock, 1 -> paper, 2 -> scissors
    function numToWord ()
    {
        if [ "$1" -eq 0 ]
            then local word="rock"
        elif [ "$1" -eq 1 ]
            then local word="paper"
        elif [ "$1" -eq 2 ]
            then local word="scissors"
        else 
            echo "Invalid number"
        fi

        echo "$word"
    }

    # Generates a random number between 0 and 2
    function computerChoice ()
    {
        local number=$RANDOM
        local computerChoiceNum=$(($number % 3))

        echo "$computerChoiceNum"
    }

    playerChoiceNumber=$(wordToNum $playerChoiceWord)
    computerChoiceNumber=$(computerChoice)

    computerChoiceWord=$(numToWord $computerChoiceNumber)

    # $1 is computerChoiceNumber, $2 is playerChoiceNumber
    function playGame ()
    {
        local numDiff=$(($1 - $2 + 3))
        local winNum=$(($numDiff % 3))

        if [ "$winNum" -eq 0 ]
            then 
            local result="${CYAN}🤝 It's a draw!${RESET}"
        elif [ "$winNum" -eq 1 ]
            then
            local result="${RED}💔 Oh no you lost!${RESET}"
            computerScore=$((computerScore+=1))
        elif [ "$winNum" -eq 2 ]
            then
            local result="${GREEN}🎉 You won!${RESET}"
            playerScore=$((playerScore+=1))
        fi

        echo -e "$result"
    }

    echo -e "${YELLOW}The computer picked:${RESET} ${MAGENTA}$computerChoiceWord${RESET}"

    playGame $computerChoiceNumber $playerChoiceNumber

    printf "\n"
    echo -e "${CYAN}═══ Running Score ═══${RESET}"
    echo -e "${GREEN}You:${RESET} $playerScore"
    echo -e "${RED}Computer:${RESET} $computerScore"
    printf "\n"
    echo -e "${CYAN}Choose again!${RESET} (${GREEN}rock/r${RESET}, ${BLUE}paper/p${RESET}, or ${RED}scissors/s${RESET})"
done