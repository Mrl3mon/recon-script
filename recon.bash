#!/bin/bash

# Get the current date and time
TODAY=$(date)

# Print a message indicating when the scan was created
echo "This scan was created on $TODAY"

# Extract the domain from the command-line arguments
DOMAIN=$1

# Create a directory for the scan output
DIRECTORY=${DOMAIN}_recon
echo "Creating directory $DIRECTORY."
mkdir -p "$DIRECTORY"

# Define a function to run an Nmap scan
nmap_scan() {
    nmap "$DOMAIN" > "$DIRECTORY/nmap"
    echo "The results of the Nmap scan are stored in $DIRECTORY/nmap."
}

# Define a function to run a Dirsearch scan
dirsearch_scan() {
    dirsearch -u "$DOMAIN" -e php --format plain -o "$DIRECTORY/dirsearch.txt"
    echo "The results of the Dirsearch scan are stored in $DIRECTORY/dirsearch.txt."
}

# Define a function to download and parse certificate information using crt.sh
crt_scan() {
    curl "https://crt.sh/?q=$DOMAIN&output=json" -o "$DIRECTORY/crt"
    echo "The results of the crt.sh scan are stored in $DIRECTORY/crt."
}

# Define a function to run a Wayback Machine URLs scan
waybackurls_scan() {
    waybackurls "$DOMAIN" > "$DIRECTORY/waybackurls.txt"
    echo "The results of the Wayback Machine URLs scan are stored in $DIRECTORY/waybackurls.txt."
}

# Determine which scan to run based on the user's choice
if [[ "$2" == "nmap" ]]; then
    nmap_scan
elif [[ "$2" == "dirsearch" ]]; then
    dirsearch_scan
elif [[ "$2" == "crt" ]]; then
    crt_scan
elif [[ "$2" == "waybackurls" ]]; then
    waybackurls_scan
else
    echo "Usage: $0 <domain> <nmap|dirsearch|crt|waybackurls>"
    exit 1
fi

# Generate a report from the output file
echo "Generating recon report from output file..."
TODAY=$(date)
echo "This scan was created on $TODAY" > "$DIRECTORY/report"
if [[ "$2" == "nmap" ]]; then
    echo "Results for Nmap:" >> "$DIRECTORY/report"
    grep -E "^\s*\S+\s+\S+\s+\S+\s*$" "$DIRECTORY/nmap" >> "$DIRECTORY/report"
elif [[ "$2" == "dirsearch" ]]; then
    echo "Results for Dirsearch:" >> "$DIRECTORY/report"
    cat "$DIRECTORY/dirsearch.txt" >> "$DIRECTORY/report"
elif [[ "$2" == "crt" ]]; then
    echo "Results for crt.sh:" >> "$DIRECTORY/report"
    jq -r ".[] | .name_value" "$DIRECTORY/crt" >> "$DIRECTORY/report"
elif [[ "$2" == "waybackurls" ]]; then
    echo "Results for Wayback Machine URLs:" >> "$DIRECTORY/report"
    cat "$DIRECTORY/waybackurls.txt" >> "$DIRECTORY/report"
fi
