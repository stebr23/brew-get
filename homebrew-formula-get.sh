#!/bin/bash

# check if a formula name was provided as a command-line argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <formula-name>"
  exit 1
fi

formula_name="$1"

# check if the formula exists in the Homebrew Core repository
formula_url="https://formulae.brew.sh/api/formula/${formula_name}.json"
curl --silent --head "$formula_url" | head -n 1 | grep "200" > /dev/null
if [ $? -ne 0 ]; then
  echo "Error: Formula '$formula_name' not found in the Homebrew Core repository"
  exit 1
fi

# download the formula file
formula_url="https://raw.githubusercontent.com/Homebrew/homebrew-core/master/Formula/${formula_name}.rb"
output_file="${formula_name}.rb"
curl -o "$output_file" "$formula_url"

# check if the download was successful
if [ $? -eq 0 ]; then
  echo "Download successful: $output_file"
else
  echo "Download failed"
fi
