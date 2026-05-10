package psm.model;

import java.util.List;

public class Snapshot {
    public long timestamp;
    public SystemMetrics system;
    public List<ProcessInfo> processes;
}
