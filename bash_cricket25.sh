echo "------------------------------------------------------------"
echo "                Welcome to Bash Cricket 2025                "
echo "------------------------------------------------------------"
echo ""
sleep 1

final(){
    echo ""
    echo ""
    echo ""
    echo "------------------------------------------------------------"
    echo "             $batter vs $batter1"
    echo "------------------------------------------------------------"
    echo "Team A ($batter)                           Team B ($batter1)"
    echo "$score/$wickets                                               $score1/$wickets1"
    echo "------------------------------------------------------------"
    echo ""
    echo ""
    sleep 2
    if [ "$score1" -ge "$target" ]; then
      echo "$batter1 won by $((5 - wickets1)) wickets"
    elif [ "$score1" -eq "$score" ]; then
      echo "Match tied"
    else
      echo "$batter won by $((target - score1)) runs"
    fi
    echo ""
    echo ""
    echo ""
}
start() {
  read -p "Enter the name of your Team: " teamA
  teamB="Team Sudo"
  echo ""
  sleep 1
  echo "Enter player names of $teamA"
  fileA="TeamA.txt"
  IFS=$'\n'
  for i in {1..6}; do
    read -p "Player $i: " player
    echo $player >> $fileA
  done
  IFS=" "
  echo ""
  echo "------------------------------------------------------------"
  echo "                           TOSS                             "
  echo "------------------------------------------------------------"
  echo ""
  sleep 1
  echo "Welcome to the toss between '$teamA' and '$teamB'"
  sleep 1

  while true; do
    read -p "What will you choose? (head/tail): " whattoss
    if [ "$whattoss" = "head" ] || [ "$whattoss" = "tail" ]; then
      echo "You choose $whattoss"
      break
    else
      echo "Please choose either 'head' or 'tail'."
      sleep 1
    fi
  done
  sleep 1

  echo "Tossing the coin..."
  sleep 1

  toss=$((RANDOM%2))
  if [ "$whattoss" = "head" ] && [ $toss -eq 0 ] || [ "$whattoss" = "tail" ] && [ $toss -eq 1 ]; then
    echo "'$teamA' won the toss"
    whotoss="$teamA"
  else
    echo "'$teamB' won the toss"
    whotoss="$teamB"
  fi
  sleep 1

  if [ "$whotoss" = "$teamA" ]; then
    read -p "What will you choose? (bat/ball): " whatchoose
    if [ "$whatchoose" = "bat" ]; then
      echo "'$teamA' chose to bat"
      batter="$teamA"
    else
      echo "'$teamA' chose to ball"
      batter="$teamB"
    fi
  else
    toss_choice=$((RANDOM%2))
    if [ $toss_choice -eq 0 ]; then
      whatchoose="bat"
    else
      whatchoose="ball"
    fi
    echo "'$teamB' chose to $whatchoose"
    if [ "$whatchoose" = "ball" ]; then
      batter="$teamA"
    else
      batter="$teamB"
    fi
  fi
  sleep 1
  echo ""
  echo "------------------------------------------------------------"
  echo "                    LET'S START THE GAME                    "
  echo "------------------------------------------------------------"
  echo ""
  echo ""
  sleep 1
  echo "------------------------------------------------------------"
  echo "                        PLAYING VI                          "
  echo "------------------------------------------------------------"
  echo "        Team Sudo              vs         $teamA"
  echo "------------------------------------------------------------"
  fileB="team_sudo.txt"
  IFS=$'\n'
  teamA_players=($(cat $fileA))
  teamB_players=($(cat $fileB))
  echo "${teamB_players[0]}                        ${teamA_players[0]}"
  echo "${teamB_players[1]}                       ${teamA_players[1]}"
  echo "${teamB_players[2]}                          ${teamA_players[2]}"
  echo "${teamB_players[3]}                           ${teamA_players[3]}"
  echo "${teamB_players[4]}                        ${teamA_players[4]}"
  echo "${teamB_players[5]}                          ${teamA_players[5]}"
  echo "------------------------------------------------------------"
  echo ""
  IFS=" "
  sleep 1
  echo "Start of first innings"
  sleep 1
  echo "'$batter' will bat first"
  if [ "$batter" = "$teamA" ]; then
    echo "'${teamA_players[0]}' and '${teamA_players[1]}' are batting"
    sleep 1
    echo "'${teamB_players[5]}' is bowling"
  else
    echo "'${teamB_players[0]}' and '${teamB_players[1]}' are batting"
    sleep 1
    echo "'${teamA_players[5]}' is bowling"
  fi
  echo ""
  sleep 1
  wickets=0
  overs=0
  balls=1
  score=0
  over_scores=()
  ball_results=()

  while [ $wickets -lt 5 ] && [ $overs -lt 2 ]; do
    over_score=0

    for ((ball=1; ball<=6; ball++)); do
      read -p "Enter a number (0 to 6): " player_number
      sleep 1
      if [ "$player_number" -lt 0 ] || [ "$player_number" -gt 6 ]; then
        echo "Please enter a number between 0 and 6."
        sleep 1
        ball=$((ball - 1))
        continue
      fi

      bot_number=$((RANDOM % 7))
      echo "'$teamB' chose: $bot_number"
      sleep 1
      event=$((RANDOM % 20))
      if [ $event -eq 7 ]; then
          echo "It's a No ball!"
          score=$((score + 1))
          over_score=$((over_score + 1))
          ball_results+=("NB")
          ball=$((ball - 1))
          sleep 1
          echo "Score: $score/$wickets in $overs.$((balls-1)) overs"
          echo ""
          sleep 1
          continue
      fi
      if [ $event -eq 13 ]; then
          echo "It's a Wide ball!"
          score=$((score + 1))
          over_score=$((over_score + 1))
          ball_results+=("Wd")
          ball=$((ball - 1))
          sleep 1
          echo "Score: $score/$wickets in $overs.$((balls-1)) overs"
          echo ""
          sleep 1
          continue
      fi

      if [ "$player_number" -eq "$bot_number" ]; then
        echo "Batsman is out!"
        ball_results+=("W")
        wickets=$((wickets + 1))
        sleep 1
      else
        difference=$((player_number - bot_number))
        if [ "$difference" -lt 0 ]; then
          difference=$((difference * -1))
        fi

        case $difference in
          6)
            echo "It's a SIX!"
            ball_results+=("6")
            score=$((score + 6))
            over_score=$((over_score + 6))
            sleep 1
            ;;
          5)
            echo "It's a FOUR!"
            ball_results+=("4")
            score=$((score + 4))
            over_score=$((over_score + 4))
            sleep 1
            ;;
          1)
            echo "It's a DOT!"
            ball_results+=("0")
            score=$((score + 0))
            over_score=$((over_score + 0))
            sleep 1
            ;;
          *)
            echo "'$batter' scored $((difference-1)) run(s)"
            ball_results+=("$((difference-1))")
            score=$((score + difference - 1))
            over_score=$((over_score + difference -1))
            sleep 1
            ;;
        esac
      fi

      echo "Score: $score/$wickets in $overs.$balls overs"
      echo ""
      sleep 1

      balls=$((balls + 1))
      if [ $balls -eq 7 ]; then
        overs=$((overs + 1))
        echo "End of over $overs"
        over_scores+=("${ball_results[*]}")
        ball_results=()
        balls=1
        echo ""
            echo "------------------------------------------------------------"
            echo "                         SCORECARD                          "
            echo "------------------------------------------------------------"
            echo "  Team           :     $batter"
            echo "  Score          :     $score/$wickets in $overs.$((balls-1)) overs"
            echo "  Over Scores    :     ${over_scores[*]}"
            echo "------------------------------------------------------------"
        echo ""
        over_scores=()
        sleep 1
      fi
    done
  done

  target=$((score+1))

  echo ""
  echo "------------------------------------------------------------"
  echo "                    END OF FIRST INNINGS                    "
  echo "------------------------------------------------------------"
  echo "  Team           :     $batter"
  echo "  Score          :     $score/$wickets in $overs.$((balls-1)) overs"
  echo "------------------------------------------------------------"
  echo ""
  sleep 2

  wickets1=0
  overs=0
  balls=1
  score1=0
  max_balls=12
  over_scores=()
  ball_results=()

  if [ "$batter" = "$teamA" ]; then
    batter1="$teamB"
  else
    batter1="$teamA"
  fi
  echo "'$batter1' needs $target runs of $max_balls balls."
  echo ""
  sleep 2
  echo "'$batter1' will bat now"
  echo ""
  sleep 1
    if [ "$batter1" = "$teamA" ]; then
      echo "'${teamA_players[0]}' and '${teamA_players[1]}' are batting"
      sleep 1
      echo "'${teamB_players[5]}' is bowling"
    else
      echo "'${teamB_players[0]}' and '${teamB_players[1]}' are batting"
      sleep 1
      echo "'${teamA_players[5]}' is bowling"
    fi
  while [ $wickets1 -lt 5 ] && [ $overs -lt 2 ]; do
    over_score=0

    for ((ball=1; ball<=6; ball++)); do
      read -p "Enter a number (0 to 6): " player_number
      sleep 1
      if [ "$player_number" -lt 0 ] || [ "$player_number" -gt 6 ]; then
        echo "Please enter a number between 0 and 6."
        sleep 1
        ball=$((ball - 1))
        continue
      fi

      bot_number=$((RANDOM % 7))
      echo "'$teamB' chose: $bot_number"
      sleep 1
      event=$((RANDOM % 20))
      if [ $event -eq 7 ]; then
          echo "It's a No ball!"
          score1=$((score1 + 1))
          over_score=$((over_score + 1))
          ball_results+=("NB")
          ball=$((ball - 1))
          sleep 1
          echo "Score: $score1/$wickets1 in $overs.$((balls-1)) overs"
          need=$((target - score1))
          echo "'$batter1' needs $need runs of $max_balls balls."
          echo ""
          sleep 1
          continue
      fi
      if [ $event -eq 13 ]; then
          echo "It's a Wide ball!"
          score1=$((score1 + 1))
          over_score=$((over_score + 1))
          ball_results+=("Wd")
          ball=$((ball - 1))
          sleep 1
          echo "Score: $score1/$wickets1 in $overs.$((balls-1)) overs"
          need=$((target - score1))
          echo "'$batter1' needs $need runs of $max_balls balls."
          echo ""
          sleep 1
          continue
      fi

      if [ "$player_number" -eq "$bot_number" ]; then
        echo "Batsman is out!"
        ball_results+=("W")
        wickets1=$((wickets1 + 1))
        sleep 1
      else
        difference=$((player_number - bot_number))
        if [ "$difference" -lt 0 ]; then
          difference=$((difference * -1))
        fi

        case $difference in
          6)
            echo "It's a SIX!"
            ball_results+=("6")
            score1=$((score1 + 6))
            over_score=$((over_score + 6))
            sleep 1
            ;;
          5)
            echo "It's a FOUR!"
            ball_results+=("4")
            score1=$((score1 + 4))
            over_score=$((over_score + 4))
            sleep 1
            ;;
          1)
            echo "It's a DOT!"
            ball_results+=("0")
            score1=$((score1 + 0))
            over_score=$((over_score + 0))
            sleep 1
            ;;
          *)
            echo "'$batter1' scored $((difference-1)) run(s)"
            ball_results+=("$((difference-1))")
            score1=$((score1 + difference - 1))
            over_score=$((over_score + difference -1))
            sleep 1
            ;;
        esac
      fi

      if [ "$score1" -ge "$target" ]; then
        echo "Congratulations! The target of $target has been chased!"
        sleep 1
        break 2
      fi

      echo "Score: $score1/$wickets1 in $overs.$balls overs"
          need=$((target - score1))
          max_balls=$((max_balls - 1))
          echo "'$batter1' needs $need runs of $max_balls balls."
          echo ""
          sleep 1

      balls=$((balls + 1))
      if [ $balls -eq 7 ]; then
        overs=$((overs + 1))
        echo "End of over $overs"
        over_scores+=("${ball_results[*]}")
        ball_results=()
        balls=1
        echo ""
            echo "------------------------------------------------------------"
            echo "                         SCORECARD                          "
            echo "------------------------------------------------------------"
            echo "  Team           :    $batter1"
            echo "  Score          :    $score1/$wickets1 in $overs.$((balls-1)) overs"
            echo "  Over Scores    :    ${over_scores[*]}"
            echo "------------------------------------------------------------"
            echo ""
            over_scores=()
        sleep 1
      fi
    done
  done
  sleep 2
  echo ""
  echo "------------------------------------------------------------"
  echo "                      FINAL SCORECARD                       "
  echo "------------------------------------------------------------"
  final
  final >> "results.txt"
  truncate -s 0 "TeamA.txt"
}

while true; do
  echo "1. Start"
  echo "2. Show opposition team players"
  echo "3. Past Matches"
  echo "4. Exit"
  echo ""
  read -p "Enter your choice: " choice
  echo ""
  sleep 1
  case $choice in
    1)
      start
      ;;
    2)
      echo "------------------------------------------------------------"
      echo "                  Opposition Team Players                   "
      echo "------------------------------------------------------------"
      echo ""
      fileB="team_sudo.txt"
      IFS=$'\n'
      for i in $(cat $fileB); do
        echo $i
      done
      IFS=" "
      echo ""
      sleep 1
      ;;
    3)
      echo "------------------------------------------------------------"
      echo "                        Past Matches                        "
      echo "------------------------------------------------------------"
      echo ""
      fileC="results.txt"
      IFS=$'\n'
      for i in $(cat $fileC); do
      echo $i
      done
      IFS=" "
      echo ""
      sleep 1
      ;;
    4)
      exit
      ;;
    *)
      echo "Invalid selection"
      ;;
  esac
done
