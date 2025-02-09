use std::fs::File;
use std::io::Write;
use std::time::Instant;

fn f(x: f64) -> f64 {
    (x.powi(2) + 1.0).ln() - (x / 2.0).exp() * (std::f64::consts::PI * x).cos()
}

fn main() {
    let start_time = Instant::now();

    let mut a: f64 = -5.0;
    let mut b: f64 = 6.0;
    let tol: f64 = 1e-3;
    let mut xr: f64 = (a + b) / 2.0;
    let mut fxr = f(xr);
    let mut error_abs = fxr.abs();

    while error_abs > tol {
        let fa = f(a);

        if fa * fxr < 0.0 {
            b = xr;
        } else {
            a = xr;
        }

        xr = (a + b) / 2.0;
        fxr = f(xr);
        error_abs = fxr.abs();
    }

    let execution_time = start_time.elapsed().as_secs_f64();

    let mut file = File::create("execution_time.txt").expect("Unable to create file");
    writeln!(file, "Rust execution Time: {:.6} seconds", execution_time).expect("Unable to write to file");
}
