# bash-scripts

Bash scripts for my everyday usage.

## web-resize.sh

- Resizes JPEG images in a directory to 1200px x 1200px and converts to webp
- Outputs directory list to text file
- Outputs links formatted in markdown to local files for website.

## rsync-backup.sh
    
Thanks to Jay from Learn Linux TV for the lesson in BASH scripting for this script. 
It has been tweaked ever so slightly to fit my humble needs.

## main-backup.sh

### TO DO:
 
 - Assign rsync-backup.sh to binary path on Mac Mini
 - Run segments of script to test

Personal backup script to sync and backup files.
rsync-backup.sh must be in binary path to run.

## filebrowser-backup.sh

Personal backup script from source of authority to homelab.

## yay-install.sh

Install script for yay package for Arch Linux distributions.

## weather.sh

Weather for my location

## website-checker.sh

Checks my website for downtime and sends notification if down. Suggest assignment to `*/15 * * *` cronjob

## randomCocktail.sh

Uses the free CocktailDB API at https://www.thecocktaildb.com/api/json/v1/1/random.php, generates a random cocktail when the script is run.


