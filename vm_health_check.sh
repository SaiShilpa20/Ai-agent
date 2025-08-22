#!/bin/bash

# This script checks the health status of an Ubuntu VM based on CPU, memory, and disk utilization.
# Usage:
#   ./vm_health_check.sh             # Prints health status only
#   ./vm_health_check.sh explain     # Prints health status and explanation

# Function to get CPU utilization (percentage)
get_cpu_usage() {
    # Get CPU idle percentage and subtract from 100 for usage
    cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{for(i=1;i<=NF;i++){if($i~/%id/){print $i}}}' | awk '{print $1}' | sed 's/%id//')
    cpu_usage=$(echo "scale=2; 100 - $cpu_idle" | bc)
    echo "$cpu_usage"
}

# Function to get Memory utilization (percentage)
get_mem_usage() {
    mem_total=$(free -m | awk '/Mem:/ {print $2}')
    mem_used=$(free -m | awk '/Mem:/ {print $3}')
    mem_usage=$(echo "scale=2; ($mem_used/$mem_total)*100" | bc)
    echo "$mem_usage"
}

# Function to get Disk utilization (percentage) for root partition
get_disk_usage() {
    disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
    echo "$disk_usage"
}

EXPLAIN_MODE=0
if [[ "$1" == "explain" ]]; then
    EXPLAIN_MODE=1
fi

cpu=$(get_cpu_usage)
mem=$(get_mem_usage)
disk=$(get_disk_usage)

HEALTHY=1
REASON=""

if (( $(echo "$cpu > 60" | bc -l) )); then
    HEALTHY=0
    REASON+="CPU utilization is high ($cpu%). "
fi
if (( $(echo "$mem > 60" | bc -l) )); then
    HEALTHY=0
    REASON+="Memory utilization is high ($mem%). "
fi
if (( $(echo "$disk > 60" | bc -l) )); then
    HEALTHY=0
    REASON+="Disk utilization is high ($disk%). "
fi

if [[ $HEALTHY -eq 1 ]]; then
    STATUS="healthy"
    [[ $EXPLAIN_MODE -eq 1 ]] && REASON="All resource utilizations are below 60%."
else
    STATUS="unhealthy"
fi

echo "VM State: $STATUS"

if [[ $EXPLAIN_MODE -eq 1 ]]; then
    echo "Reason: $REASON"
fi
