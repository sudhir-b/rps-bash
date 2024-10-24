#!/bin/bash

# Initialise running scores
playerScore=0
computerScore=0

echo "Enter choice:" # rock, paper or scissors

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
			echo "Invalid word"
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
			local result="It's a draw!"
		elif [ "$winNum" -eq 1 ]
			then
			local result="Oh no you lost!"
			computerScore=$((computerScore+=1))
		elif [ "$winNum" -eq 2 ]
			then
			local result="You won!"
			playerScore=$((playerScore+=1))
		fi

		echo "$result"
	}

	echo "The computer picked: $computerChoiceWord"

	playGame computerChoiceNumber playerChoiceNumber

	printf "\n"
	echo "Running score"
	echo "You: $playerScore"
	echo "Computer: $computerScore"
	printf "\n"
	echo "Choose again!"

done
