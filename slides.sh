#!/bin/bash

rm index.md
# File to write
output_file="index.md"
echo "# Masterlist"  >> "$output_file"
echo "---" >> "$output_file"
# Loop through each HTML file in the current directory
for file in *.md; do
    # Extract the filename without extension
    filename="${file%.*}"

    # Append the formatted line to the output file
    echo "- [$filename](https://oddfeed.github.io/bookclub/$filename.html)" >> "$output_file"
done

