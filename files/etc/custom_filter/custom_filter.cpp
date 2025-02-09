#include <fstream>
#include <vector>
#include <cstdlib>

int main() {
    std::ifstream file("/etc/custom_filter/blocklist.txt");
    std::vector<std::string> domains;
    std::string line;

    while (std::getline(file, line)) {
        if (!line.empty() && line[0] != '#') {
            domains.push_back("address=/" + line + "/0.0.0.0\n");
        }
    }

    std::ofstream dnsmasq_conf("/etc/dnsmasq.d/custom_block.conf");
    for (const auto& entry : domains) {
        dnsmasq_conf << entry;
    }

    system("service dnsmasq reload");
    return 0;
}
