#!/bin/bash

echo -e "#\n#\n#\nThis script will install a status.html page on your uptime server for public access to basic server status information, it will overwrite some files in your default uptime install folder, backups of the overwritten files can be found at the same file location with a .BACKUP extention.\n#\n#\n#";

LocationUptime="/usr/local/uptime";
read -e -p "Location of uptime [/usr/local/uptime]: " LocationUptimeinput;
LocationUptime="${LocationUptimeinput:-$Locationuptime}";

cp status.html status.html.BACKUP;

cname=" ";
read -e -p "Your Company Name []: " cnameinput;
cname="${cnameinput:-$cname}";
sed -i "s@companyname@$cname@" status.html;

echo -e "#\n#\nYou should create a user and group in uptime with read-only access to the applications you would like to monitor before you continue to this step. Any username\password entered here will be stored in PLAINTEXT. You can also create the username and password seen here (viewonly/viewonly) after install.\n#\n#";

loginusername="viewonly";
read -e -p "Username for uptime(should be read-only!) [viewonly]: " loginusernameinput;
loginusername="${loginusernameinput:-$loginusername}";
sed -i "s@userusername@$loginusername@" status.html;

loginpassword="viewonly";
read -e -p "Password for uptime [viewonly]: " loginpasswordinput;
loginpassword="${loginpasswordinput:-$loginpassword}";
sed -i "s@useruserpassword@$loginpassword@" status.html;

echo -e "#\n#\nEnter the URL for your uptime server, localhost will not work. Do not enter http:// or trailing /index.html's/n#/n#";

serverlocation="127.0.0.1";
read -e -p "Uptime URL [uptime.example.com]: " serverlocationinput;
serverlocation="${serverlocationinput:-$serverlocation}";
sed -i "s@serverurl@$serverlocation@" status.html;

contact="555-555-5555";
read -e -p "Company Contact Phone/Email [555-555-5555]: " contactinput;
contact="${contactinput:-$contact}";
sed -i "s@companycontact@$contact@" status.html;

twitter=" "
read -e -p "Twitter widget code []: " twitterinput;
twitter="${twitterinput:-$twitter}";
sed -i "s@twittercode@$twitter@" status.html;

cp -f status.html /usr/local/uptime/GUI/status.html; 
cp -f gradient.png /usr/local/uptime/GUI/images/gradient.png;
cp -f /usr/local/uptime/GUI/classes/globalscan/GlobalScanApplications.inc /usr/local/uptime/GUI/classes/globalscan/GlobalScanApplications.inc.BACKUP;
cp -f GlobalScanApplications.inc /usr/local/uptime/GUI/classes/globalscan/GlobalScanApplications.inc;
cp -f status.html.BACKUP status.html;


echo -e "#\n#\nYou can now visit your updated status page at http://$serverlocation/status.html\n#\n#";
