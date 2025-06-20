public class PaymentContext {
    private PaymentStrategy paymentStrategy;

    public void setPaymentStrategy(PaymentStrategy strategy) {
        this.paymentStrategy = strategy;
    }

    public void pay(double amount) {
        if (paymentStrategy == null) {
            System.out.println("Payment strategy not set.");
        } else {
            paymentStrategy.pay(amount);
        }
    }
}
