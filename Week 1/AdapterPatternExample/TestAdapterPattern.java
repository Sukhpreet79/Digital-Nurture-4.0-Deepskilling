public class TestAdapterPattern {
    public static void main(String[] args) {
        // Using PayPal
        PaymentProcessor paypal = new PayPalAdapter(new PayPalGateway());
        paypal.processPayment(250.00);

        // Using Stripe
        PaymentProcessor stripe = new StripeAdapter(new StripeGateway());
        stripe.processPayment(450.50);
    }
}
