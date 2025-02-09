import sympy as sp
import time

x = sp.symbols('x')
func = sp.ln(x**2 + 1) - sp.exp(x/2) * sp.cos(sp.pi * x)

a, b = -5, 6
tol = 1e-3

start_time = time.time()

fa = float(func.subs(x, a).evalf())
fb = float(func.subs(x, b).evalf())

xr = (a + b) / 2
fxr = float(func.subs(x, xr).evalf())

error_abs = abs(fxr)
iteration = 0

while error_abs > tol:
    iteration += 1
    if fa * fxr < 0:
        b, fb = xr, fxr
    else:
        a, fa = xr, fxr

    previous_xr = xr
    xr = (a + b) / 2
    fxr = float(func.subs(x, xr).evalf())
    error_abs = abs(fxr)
    
end_time = time.time()
execution_time = end_time - start_time

with open("execution_time.txt", "w") as file:
    file.write(f"Python execution Time: {execution_time:.6f} seconds\n")
