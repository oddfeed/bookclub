#!/bin/bash

rm index.md
output_file="index.md"

# Start the masterlist
echo "# Masterlist"  >> "$output_file"
echo "---" >> "$output_file"
echo "" >> "$output_file"

# Create an associative array to hold file names, indexed by year
declare -A files_by_year

# Loop through each Markdown file
for file in *.md; do
    # Skip README.md and index.md
    if [ "$file" == "README.md" ] || [ "$file" == "index.md" ]; then
        continue
    fi

    # Get the last modified year of the file
    year=$(date -r "$file" +"%Y")

    # Append the file to the array for its year
    files_by_year[$year]+="- [$file](https://oddfeed.github.io/bookclub/${file%.*}.html)\n"
done

# Sort years and write to the file
for year in "${!files_by_year[@]}"; do
    echo "# $year" >> "$output_file"
    echo -e "${files_by_year[$year]}" >> "$output_file"
done

