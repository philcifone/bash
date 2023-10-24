#!/bin/bash

# Website URL to check
WEBSITE_URL="http://philcifone.com"

# Email address to receive notifications
RECIPIENT_EMAIL="phil@philcifone.com"

# Send an HTTP GET request to the website
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$WEBSITE_URL")

# Check if the website is down (HTTP status code 200 means it's up)
if [ "$HTTP_STATUS" != "200" ]; then
    # Website is down, send an email notification
    SUBJECT="Website Status Alert: $WEBSITE_URL is down"
    MESSAGE="The website $WEBSITE_URL is currently down. HTTP Status Code: $HTTP_STATUS"
    echo "$MESSAGE" | mail -s "$SUBJECT" "$RECIPIENT_EMAIL"
fi

