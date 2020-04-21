# Unit 9 - Key Topics

## Azure Monitor

- https://azure.microsoft.com/en-us/services/monitor/#features
- https://docs.microsoft.com/en-us/azure/azure-monitor/insights/container-insights-overview
- https://docs.microsoft.com/bs-latn-ba/azure/azure-monitor/insights/container-insights-log-search

## Log Analytics Queries

Last heartbeat of each computer:
```
Heartbeat
| summarize arg_max(TimeGenerated, *) by Computer
```

List all computer heartbeats from the last hour:
```
Heartbeat
| where TimeGenerated > ago(1h)
```

What data is being collected? 
```
Perf
| summarize by ObjectName, CounterName
```

```
ContainerInventory
| project Computer, Name, Image, ImageTag, ContainerState, CreatedTime, StartedTime, FinishedTime
| render table
```

```
Perf
| where ObjectName == "K8SContainer" and CounterName == "cpuUsageNanoCores" | summarize AvgCPUUsageNanoCores = avg(CounterValue) by bin(TimeGenerated, 30m), InstanceName
```
