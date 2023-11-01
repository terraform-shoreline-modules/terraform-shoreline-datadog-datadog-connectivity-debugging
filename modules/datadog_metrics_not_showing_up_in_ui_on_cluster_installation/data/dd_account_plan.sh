

#!/bin/sh



# Set the Datadog API key as an environment variable

export DD_API_KEY=${DATADOG_API_KEY}



# Check the Datadog account plan for limitations

LIMIT=$(curl -s -X GET "https://app.datadoghq.com/api/v1/account" -H "Content-Type: application/json" -H "DD-API-KEY: $DD_API_KEY" | jq '.account.plan.name')



if [ "$LIMIT" = "\"Free\"" ]

then

  echo "Account plan is Free, which has limitations on metrics and features."

else

  echo "Account plan is not Free."

fi