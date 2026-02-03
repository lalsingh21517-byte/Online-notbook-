#!/data/data/com.termux/files/usr/bin/bash

# JSON se data fetch karna
DATA=$(cat ~/Online-notbook/data/loans.json)

# Aaj ki date nikalna
TODAY=$(date +%Y-%m-%d)

echo "Checking EMIs for: $TODAY"

# Unity Bank Check
UNITY_DATE=$(echo $DATA | jq -r '.loans[0].next_emi_date')
if [ "$TODAY" == "$UNITY_DATE" ]; then
    termux-notification --title "🚨 किस्त अलर्ट!" --content "Bhai, aaj Unity Bank ki kist ₹4140 bharni hai!" --priority high
fi

# SATIN Check (Example)
# Isi tarah baki banks ka logic add karenge
