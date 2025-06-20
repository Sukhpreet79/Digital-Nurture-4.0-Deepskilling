public class TestStrategyPattern {
    public static void main(String[] args) {
        PaymentContext context = new PaymentContext();

        // Use Credit Card payment
        context.setPaymentStrategy(new CreditCardPayment("1234567890123456"));
        context.pay(150.0);

        // Use PayPal payment
        context.setPaymentStrategy(new PayPalPayment("user@example.com"));
        context.pay(75.5);
    }
}
