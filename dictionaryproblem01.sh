#!/bin/bash

# initialize an associative array to store the die roll results
declare -A results

# roll the die and update the results array
function roll_die() {
  num=$((1 + RANDOM % 6))
  if [ ${results[$num]+_} ]; then
    ((results[$num]++))
  else
    results[$num]=1
  fi
  echo $num
}

# roll the die until one number reaches 10 times
while true; do
  num=$(roll_die)
  if [ ${results[$num]} -eq 10 ]; then
    break
  fi
done

# find the number that reached maximum and minimum times
max_num=$(printf '%s\n' "${!results[@]}" | awk '{print $1" "results[$1]}' | sort -k2nr | head -1 | cut -d' ' -f1)
min_num=$(printf '%s\n' "${!results[@]}" | awk '{print $1" "results[$1]}' | sort -k2n | head -1 | cut -d' ' -f1)

# print the results
echo "Results: ${results[@]}"
echo "Maximum: $max_num (${results[$max_num]} times)"
echo "Minimum: $min_num (${results[$min_num]} times)"
