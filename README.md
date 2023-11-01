
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Datadog Metrics Not Showing Up in UI on Cluster Installation.
---

This incident type involves an issue where Datadog metrics fail to show up in the Datadog user interface (UI) after installation on a cluster. The incident requires the software engineer to run a list of commands to debug the issue.

### Parameters
```shell
export DATADOG_AGENT_POD_NAME="PLACEHOLDER"

export DATADOG_API_KEY="PLACEHOLDER"

export DATADOG_APP_KEY="PLACEHOLDER"
```

## Debug

### Check that the Datadog agent is deployed and running on the cluster
```shell
kubectl get pods -n datadog
```

### Check for any errors or issues with the Datadog agent
```shell
kubectl logs ${DATADOG_AGENT_POD_NAME} -n datadog
```

### Verify that the Datadog agent is collecting metrics from the cluster
```shell
kubectl exec ${DATADOG_AGENT_POD_NAME} -n datadog -- agent status
```

### Check if the Datadog agent is forwarding metrics to the Datadog API
```shell
kubectl exec ${DATADOG_AGENT_POD_NAME} -n datadog -- agent info
```

### Verify that the Datadog API is receiving metrics from the Datadog agent
```shell
curl -X GET https://api.datadoghq.com/api/v1/validate -H "Content-Type: application/json" -H "DD-API-KEY: ${DATADOG_API_KEY}" -H "DD-APPLICATION-KEY: ${DATADOG_APP_KEY}"
```

### Check that the correct tags are applied to metrics in the Datadog UI
```shell
kubectl get pods --show-labels
```

### Check your Datadog account plan limitations
```shell


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


```