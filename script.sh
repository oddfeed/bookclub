#!/bin/bash

rm index.md
output_file="index.md"

# Start the masterlist
echo "# Masterlist"  >> "$output_file"
echo "---" >> "$output_file"

# Create an associative array to hold file names, indexed by year and month
declare -A files_by_year_month

# Loop through each Markdown file
for file in *.md; do
    # Skip README.md and index.md
    if [ "$file" == "README.md" ] || [ "$file" == "index.md" ]; then
        continue
    fi

    # Get the last modified year and month of the file
    year_month=$(date -r "$file" +"%Y-%m")

    # Append the file to the array for its year and month
    files_by_year_month[$year_month]+="- [$file](https://oddfeed.github.io/bookclub/${file%.*}.html)\n"
done

# Sort years and months and write to the file
previous_year=""
for year_month in $(echo ${!files_by_year_month[@]} | tr ' ' '\n' | sort -u); do
    year=${year_month:0:4}
    month=${year_month:5:2}

    # Check if the year has changed and add a year heading if it has
    if [ "$year" != "$previous_year" ]; then
        echo "# $year" >> "$output_file"
        previous_year=$year
    fi

    # Convert month number to month name
    month_name=$(date -d "$year-$month-01" +"%B")

    echo "## $month_name" >> "$output_file"
    echo -e "${files_by_year_month[$year_month]}" >> "$output_file"
done

