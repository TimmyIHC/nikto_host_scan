# Nikto Vulnerability Scan Script

## Introduction

This script facilitates running a Nikto vulnerability scan on a list of URLs, providing an individual vulnerability report for each URL at the end of the scan.

## Nikto

Nikto is a free, command-line vulnerability scanner that examines web servers for potentially dangerous files/CGIs, outdated server software, and other security issues.

## Pre-requisites

- Ensure Docker is installed on your machine.
- Verify that your machine has all necessary Linux executable command permissions.

## How to Implement

1. **Edit the Hosts List**
   - Open the `nikto_host_scan.sh` file.
   - Under the `URLS` variable, list all the hosts you wish to scan.

2. **Run the Shell Script**
   - The script will:
     - Clone the Nikto repository from GitHub.
     - Build the Docker image.
     - Spin up one container per host to run the scan individually. (Eg. To scan 5 hosts it will spin up 5 containers)
   - After the scans complete, the reports will be found in the `/tmp/` folder. You can change this directory by modifying the last part of line 29 in the script.
   - The output files will be named in the format: `___https:domainname__path__newpath___.json`.

## Additional Information

The script is currently set to spin up individual Docker containers for each URL. If your machine lacks the resources to handle multiple containers simultaneously, you can modify line 29 with the following command to run scans sequentially:

```sh
docker run --rm -v "$(pwd)":/tmp sullo/nikto -h "$url" -o "/tmp/$output_file"
```

This adjustment ensures that one container runs at a time, only starting the next scan after the current one completes.