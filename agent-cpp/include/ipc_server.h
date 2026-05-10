#pragma once
#include <string>

class IPCServer {
public:
    IPCServer(int port);

    void start();
    void handle_request(const std::string& request);
};
