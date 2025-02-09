const fs = require('fs');
const { log, exp, cos, PI } = Math;

let a = -5, b = 6;
let tol = 1e-3;
let xr = (a + b) / 2;
let errorAbs = Math.abs(log(xr ** 2 + 1) - exp(xr / 2) * cos(PI * xr));
let startTime = process.hrtime();

while (errorAbs > tol) {
    let fa = log(a ** 2 + 1) - exp(a / 2) * cos(PI * a);
    let fxr = log(xr ** 2 + 1) - exp(xr / 2) * cos(PI * xr);
    
    if (fa * fxr < 0) {
        b = xr;
    } else {
        a = xr;
    }
    
    xr = (a + b) / 2;
    errorAbs = Math.abs(log(xr ** 2 + 1) - exp(xr / 2) * cos(PI * xr));
}

let endTime = process.hrtime(startTime);
let executionTime = endTime[0] + endTime[1] / 1e9;

fs.writeFileSync("execution_time.txt", `Javascript execution Time: ${executionTime.toFixed(6)} seconds\n`);
