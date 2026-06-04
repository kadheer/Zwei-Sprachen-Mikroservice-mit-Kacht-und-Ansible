#include <httplib.h>  
#include <iostream>
#include <string>

// Berechnet das Quadrat einer Ganzzahl
int quadrat(int x) {
    return x * x;
}

int main() {
    httplib::Server server;

    // HTTP-GET-Endpunkt: /quadrat?zahl=42
    server.Get("/quadrat", [](const httplib::Request& req, httplib::Response& res) {
        if (req.has_param("zahl")) {
            int zahl = std::stoi(req.get_param_value("zahl"));
            int ergebnis = quadrat(zahl);
            res.set_content(std::to_string(ergebnis), "text/plain");
        } else {
            res.status = 400;
            res.set_content("Fehler: Parameter 'zahl' fehlt", "text/plain");
        }
    });

    std::cout << "C++-Service läuft auf Port 8080" << std::endl;
    server.listen("0.0.0.0", 8080);
}
