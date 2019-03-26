function spin() 
{
   local -a marks=( 'rock    ' 'paper   ' 'scissors' )
   while true; do
     printf '%s\r' "${marks[i++ % ${#marks[@]}]}"
     sleep 0.05
   done
}


spin