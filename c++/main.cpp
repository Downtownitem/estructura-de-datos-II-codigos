#include <iostream>
#include <fstream>
#include <cmath>
#include <chrono>

int main() {
    auto start_time = std::chrono::high_resolution_clock::now();
    
    double a = -5, b = 6;
    double tol = 1e-3;
    double xr = (a + b) / 2;
    double errorAbs = std::abs(std::log(xr * xr + 1) - std::exp(xr / 2) * std::cos(M_PI * xr));
    
    while (errorAbs > tol) {
        double fa = std::log(a * a + 1) - std::exp(a / 2) * std::cos(M_PI * a);
        double fxr = std::log(xr * xr + 1) - std::exp(xr / 2) * std::cos(M_PI * xr);
        
        if (fa * fxr < 0) {
            b = xr;
        } else {
            a = xr;
        }
        
        xr = (a + b) / 2;
        errorAbs = std::abs(std::log(xr * xr + 1) - std::exp(xr / 2) * std::cos(M_PI * xr));
    }
    
    auto end_time = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> execution_time = end_time - start_time;
    
    std::ofstream file("execution_time.txt");
    file << "C++ execution Time: " << execution_time.count() << " seconds\n";
    file.close();
    
    return 0;
}
