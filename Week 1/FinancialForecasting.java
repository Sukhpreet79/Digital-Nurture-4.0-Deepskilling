import java.util.Scanner;

public class FInancialForecasting {

    // Recursive method to calculate future value
    public static double calculateFutureValue(double presentValue, double rate, int years) {
        if (years == 0) {
            return presentValue;
        } else {
            return (1 + rate) * calculateFutureValue(presentValue, rate, years - 1);
        }
    }

    // Optimized using memoization
    public static double calculateFutureValueMemo(double presentValue, double rate, int years, Double[] memo) {
        if (years == 0) return presentValue;
        if (memo[years] != null) return memo[years];
        memo[years] = (1 + rate) * calculateFutureValueMemo(presentValue, rate, years - 1, memo);
        return memo[years];
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter present value: ");
        double pv = sc.nextDouble();

        System.out.print("Enter annual growth rate (as decimal, e.g. 0.05 for 5%): ");
        double rate = sc.nextDouble();

        System.out.print("Enter number of years: ");
        int years = sc.nextInt();

        double futureVal = calculateFutureValue(pv, rate, years);
        System.out.printf("Predicted Future Value (Recursive): %.2f%n", futureVal);

        Double[] memo = new Double[years + 1];
        double memoVal = calculateFutureValueMemo(pv, rate, years, memo);
        System.out.printf("Predicted Future Value (Memoized): %.2f%n", memoVal);
    }
}
