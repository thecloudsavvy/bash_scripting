#!/bin/bash

## install relevant packages
## ssmtp
if ! command -v msmtp &> /dev/null
then
    echo "Not installed"

    sleep 3
    echo "Installing it ..."
    sleep 1

    brew install msmtp 
else
    echo "Already installed ..."
fi




databaseFile=/Users/macbookpro/bash_automation_classes/database.csv
tierOneFile=/Users/macbookpro/bash_automation_classes/tier1.csv

emailFile=/Users/macbookpro/bash_automation_classes/email.txt

if [[ -f $tierOneFile ]]
then
    rm $tierOneFile
fi

## create the file again
touch $tierOneFile

##add heading to the tierOneFile
echo Firstname,Lastname,Email,Username,Scores >> $tierOneFile

while read line
do
    heading=$(echo $line | grep Firstname,Lastname,Email,Username,Scores)

    if [[ ! $heading ]]
    then
        firstname=$(echo $line | cut -d"," -f1)
        lastname=$(echo $line | cut -d"," -f2)
        email=$(echo $line | cut -d"," -f3)
        username=$(echo $line | cut -d"," -f4)
        score=$(echo $line | cut -d"," -f5)

        if [[ $score -gt 50 ]]
        then
            echo "$firstname, $lastname has a score of $score and will be added and emailed"

            ##create an account for these users on the servers
            ## -> adduser or useradd

            ## delete user if exists already
            # sudo deluser $username


            # sudo useradd $username
            # sudo chpasswd <<< "$username:123456"

            ## check if the email_content file exists already..
            if [[ -f $emailFile ]]
            then
                rm $emailFile
            fi

            ## create the email_content file
            touch $emailFile

            ## add the customized content
            echo "To: $firstname" >> $emailFile
            echo "From: taiwoabatan1999@gmail.com" >> $emailFile
            echo "Subject: Welcome to the Tier3 $firstname!" >> $emailFile
            echo "" >> $emailFile
            echo "Welcome to this program $firstname, $lastname!, this is a very special program." >> $emailFile

            ## send them an email
            msmtp $email < $emailFile


            ## add these users to a tier1_users file
            echo "$firstname,$lastname,$email,$username,$score" >> $tierOneFile

        fi
    fi

done < $databaseFile