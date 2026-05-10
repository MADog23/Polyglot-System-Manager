#pragma once

class MetricsCollector {
public:
    MetricsCollector() = default;

    // TODO: return system metrics struct
    void collect_system_metrics();

    // TODO: return process list
    void collect_process_metrics();
};
