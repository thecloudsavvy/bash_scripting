#!/bin/bash

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

# file=email.csv
# emailFile=email.txt

#  ## check if the email_content file exists already..
#     if [[ -f $emailFile ]]
#     then
#         rm $emailFile
#     fi

#     touch $emailFile

# while read -r line
# do
#     ## echo the emails to a variable
#     emails="$line"

#     ## create the email_content file
    
# cat <<EOF >> $emailFile
#     To: $emails
#     From: Domain@kloudinja.online
#     Subject: Oakland Design Build


#     I hope this finds you well. I am reaching out to you with an exciting opportunity to acquire a premium domain OaklandDesignBuild.com that aligns perfectly with your business
#     This domain contains highly searched keywords which fits perfectly with your area of practice and the real value of the domain is that it defines your service in Oakland, CA and surrounding environs.


#     It will also help you cut down on ads spending because you own the right keyword prospects are searching for.


#     You can decide to redirect the domain to your current website or build another website on it to further capture more targeted prospects.


#     Price: $499 (one time purchase).


#     If you're interested in this opportunity, kindly visit www.OaklandDesignBuild.com  to buy now.


#     Best Regards
#     Domain expert.  

# EOF


#     msmtp $emails < $emailFile



# done < $file

#!/bin/bash

# file=email.csv
# emailFile=email.txt

# ## Create the email_content file once before the loop


# while read -r line; do
#     ## echo the emails to a variable
#     # emails="$line"

#     if [[ -f $emailFile ]]; then
#     rm $emailFile
#     fi
#     touch $emailFile

#     cat <<EOF >> $emailFile
# To: $line
# From: Domain@kloudinja.online
# Subject: Oakland Design Build

# I hope this finds you well. I am reaching out to you with an exciting opportunity to acquire a premium domain OaklandDesignBuild.com that aligns perfectly with your business
# This domain contains highly searched keywords which fits perfectly with your area of practice and the real value of the domain is that it defines your service in Oakland, CA and surrounding environs.

# It will also help you cut down on ads spending because you own the right keyword prospects are searching for.

# You can decide to redirect the domain to your current website or build another website on it to further capture more targeted prospects.

# Price: $499 (one time purchase).

# If you're interested in this opportunity, kindly visit www.OaklandDesignBuild.com to buy now.

# Best Regards,
# Domain expert.
# EOF

#     msmtp "$line" < $emailFile
#     sleep 0.5

#     # ## Clean the emailFile for the next iteration
#     # > $emailFile
# done < "$file"


#!/bin/bash

file="email.csv"
emailFile="email.txt"

while IFS= read -r emails; do
    ## trim leading and trailing whitespace from email address
    emails="$(echo -e "$emails" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

    cat <<EOF | msmtp "$emails"
To: $emails
From: Domain@kloudinja.online
Subject: Oakland Design Build

I hope this finds you well. I am reaching out to you with an exciting opportunity to acquire a premium domain OaklandDesignBuild.com that aligns perfectly with your business
This domain contains highly searched keywords which fit perfectly with your area of practice, and the real value of the domain is that it defines your service in Oakland, CA, and surrounding environs.

It will also help you cut down on ad spending because you own the right keyword prospects are searching for.

You can decide to redirect the domain to your current website or build another website on it to further capture more targeted prospects.

Price: $499 (one-time purchase).

If you're interested in this opportunity, kindly visit www.OaklandDesignBuild.com to buy now.

Best Regards,
Domain expert.
EOF

done < "$file"
