public class TestDecoratorPattern {
    public static void main(String[] args) {
        // Step-by-step wrapping: Email -> SMS -> Slack
        Notifier notifier = new SlackNotifierDecorator(
                                new SMSNotifierDecorator(
                                    new EmailNotifier()
                                )
                            );

        notifier.send("System maintenance at 2 AM.");
    }
}
