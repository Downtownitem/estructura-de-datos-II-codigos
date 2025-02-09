import java.io.FileWriter;
import java.io.IOException;

public class ExecutionTimeLogger {
    public static void main(String[] args) {
        long startTime = System.nanoTime();
        
        double a = -5, b = 6;
        double tol = 1e-3;
        double xr = (a + b) / 2;
        double errorAbs = Math.abs(Math.log(Math.pow(xr, 2) + 1) - Math.exp(xr / 2) * Math.cos(Math.PI * xr));
        
        while (errorAbs > tol) {
            double fa = Math.log(Math.pow(a, 2) + 1) - Math.exp(a / 2) * Math.cos(Math.PI * a);
            double fxr = Math.log(Math.pow(xr, 2) + 1) - Math.exp(xr / 2) * Math.cos(Math.PI * xr);
            
            if (fa * fxr < 0) {
                b = xr;
            } else {
                a = xr;
            }
            
            xr = (a + b) / 2;
            errorAbs = Math.abs(Math.log(Math.pow(xr, 2) + 1) - Math.exp(xr / 2) * Math.cos(Math.PI * xr));
        }
        
        long endTime = System.nanoTime();
        double executionTime = (endTime - startTime) / 1e9;
        
        try (FileWriter file = new FileWriter("execution_time.txt")) {
            file.write("Java execution Time: " + executionTime + " seconds\n");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
