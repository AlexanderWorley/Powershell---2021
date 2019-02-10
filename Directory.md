# Folder: Active Directory Scripts
    Account Unlock Script
  This script are built for Sys Admins to input and unlock user's accounts when they are locked out. PLEASE NOTE THAT THEY USERNAME WILL BE WHAT YOU LAUNCH POWERSHELL ISE AS!!!

    Discover Locked Out
  Searches your Domain controllers for all locked users on a server. All you have to input is the serverName  and your Admin Password;

    Distribution group
    This script will target a specific OU(Org Unit) and DC(Domain Controller) and will pull all users in a CSV file then spit out which one has no members. Really useful for cleaning up Active Directories.

    Full Name to USERNAME
      This script will take the input of all servers you have; run the Full Name of that person through the directory of all servers and spit out their usernames! Extremely useful for troubleshooting directory account issues.

    Username Extractor
      This script will import a list of users FIRST AND LAST NAMES in a CSV; then run a Try-Catch function then export their DisplayName, and Email address.  

    Time Frame Enabled
      This script will select all users within a DC/Server and output all that fit the dates you select in the variables; this shows which accounts are disabled for clean up.

# Folder: Email scripts
    Active Directory Group All Emails
      This script will pull all of the users from a selected Active Directory group that you select in the "AD Group" variable. On the Domain you select in the "Domain" group and export it to a nice CSV on your desk top.
        - Things to replace in the script with your information:
        $adgroup
        $domain
        "C:\Users\USERNAME\\
      Folder Items
        This script will pull the targeted user's email folders and the count of emails in those folders. Really useful for troubleshooting Mailbox size issues. (Note this is for Microsoft Exchange 2013!)

# Folder: Security
    Secured Admin Creds
      This script is used as a function in most scripts; it will save your credentials as a global cred and will protect from plain text passwords and repetitive inputs.  
