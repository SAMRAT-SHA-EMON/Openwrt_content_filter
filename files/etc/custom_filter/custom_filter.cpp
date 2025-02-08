#include <fstream>
#include <vector>
#include <cstdlib>

int main() {
    std::ifstream file("/etc/custom_filter/blocklist.txt");
    std::vector<std::string> domains;
    std::string line;

    while (std::getline(file, line)) {
        if (!line.empty() && line[0] != '#') { // Skip empty lines and comments
            domains.push_back("address=/" + line + "/0.0.0.0\n");
        }
    }

    std::ofstream dnsmasq_conf("/etc/dnsmasq.d/custom_block.conf");
    for (const auto& entry : domains) {
        dnsmasq_conf << entry;
    }

    std::ifstream ip_file("/etc/custom_filter/blocklist.txt");
    std::string ip_line;

    while (std::getline(ip_file, ip_line)) {
        if (ip_line.find("# IP Addresses") != std::string::npos) {
            while (std::getline(ip_file, ip_line)) {
                if (!ip_line.empty() && ip_line.find('.') != std::string::npos) {
                    system(("iptables -A FORWARD -d " + ip_line + " -j DROP").c_str());
                }
            }
        }
    }
    system("iptables -A FORWARD -d 104.16.123.96 -j DROP");
    system("service dnsmasq reload");
    return 0;
}
