from dataclasses import dataclass
from typing import List

@dataclass
class SystemMetrics:
    cpu_usage_percent: float
    memory_used_mb: float
    memory_total_mb: float
    disk_read_mb_s: float
    disk_write_mb_s: float
    net_in_kb_s: float
    net_out_kb_s: float

@dataclass
class ProcessInfo:
    pid: int
    name: str
    cpu_percent: float
    memory_mb: float

@dataclass
class Snapshot:
    timestamp: float
    system: SystemMetrics
    processes: List[ProcessInfo]
