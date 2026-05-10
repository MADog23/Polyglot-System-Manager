#pragma once
#include <string>
#include <vector>

struct SystemMetrics {
    double cpu_usage_percent;
    double memory_used_mb;
    double memory_total_mb;
    double disk_read_mb_s;
    double disk_write_mb_s;
    double net_in_kb_s;
    double net_out_kb_s;
};

struct ProcessInfo {
    int pid;
    std::string name;
    double cpu_percent;
    double memory_mb;
};

struct Snapshot {
    long timestamp;
    SystemMetrics system;
    std::vector<ProcessInfo> processes;
};
