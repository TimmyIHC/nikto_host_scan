#!/bin/bash

# Clone Nikto repository
git clone https://github.com/sullo/nikto.git

if [ $? -ne 0 ]; then
    echo "Error: Failed to clone Nikto repository"
    exit 1
fi

cd nikto

# Build Nikto Docker image
docker build -t sullo/nikto .

# Display Nikto help
docker run --rm sullo/nikto

# URLs to scan
URLS=(
"https://google.com/",
"https://facebook.com/",
"https://yahoo.com/",
"https://youtube.com/",
"https://gmail.com/"
)

# Loop through each URL and execute Nikto scan
for url in "${URLS[@]}"; do
    echo "Scanning $url"
    output_file="$(echo "$url" | sed 's/[^a-zA-Z0-9]/_/g').json"
    docker run --rm -d -v "$(pwd)":/tmp sullo/nikto -h "$url" -o "/tmp/$output_file"
done