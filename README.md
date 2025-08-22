# Ai-agent
# VM Health Check Script

This repository contains a shell script (`vm_health_check.sh`) designed to monitor the health of Ubuntu-based virtual machines. The script evaluates CPU, memory, and disk space utilization to determine the VM's state. 

## How It Works

The script performs the following steps:

1. **CPU Utilization**  
   The script checks the percentage of CPU usage using the `top` command. If the CPU utilization is above 60%, it is considered a risk for VM health.

2. **Memory Utilization**  
   The script uses the `free` command to assess memory usage. If memory utilization exceeds 60%, it can negatively impact the VM's performance.

3. **Disk Space Utilization**  
   The script examines the root partition's disk usage using the `df` command. Disk utilization above 60% may affect the VM's stability.

4. **Health Status**  
   - If all three parameters (CPU, memory, and disk utilization) are below 60%, the VM is declared **healthy**.
   - If any of the parameters exceed 60%, the VM is declared **unhealthy**.

5. **Explain Mode**  
   The script accepts an optional command line argument `explain`. When provided, it explains the reason for the health status alongside the result.

## Usage

1. Save the script as `vm_health_check.sh`.
2. Make it executable:
   ```bash
   chmod +x vm_health_check.sh
   ```
3. Run the script:
   ```bash
   ./vm_health_check.sh
   ```
   - Output: `VM State: healthy` or `VM State: unhealthy`

4. Run with explanation:
   ```bash
   ./vm_health_check.sh explain
   ```
   - Output: Health status with explanation for the result.

## Example Output

```
$ ./vm_health_check.sh
VM State: healthy

$ ./vm_health_check.sh explain
VM State: unhealthy
Reason: CPU utilization is high (75%). 
```

## Requirements

- Ubuntu VM
- Bash shell
- Standard system utilities: `top`, `free`, `df`, `awk`, `sed`, `bc`

## Notes

- The script is intended for Ubuntu VMs and may require adjustments for other Linux distributions.
- Thresholds for health assessment can be modified in the script as needed.

---

Feel free to contribute improvements or report issues!
