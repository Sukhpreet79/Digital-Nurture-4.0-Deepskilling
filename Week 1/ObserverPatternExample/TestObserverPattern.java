public class TestObserverPattern {
    public static void main(String[] args) {
        StockMarket market = new StockMarket();

        Observer mobileUser = new MobileApp("Alice");
        Observer webUser = new WebApp("Bob");

        market.registerObserver(mobileUser);
        market.registerObserver(webUser);

        market.setStockPrice("AAPL", 182.15);
        market.setStockPrice("GOOGL", 2780.30);

        market.removeObserver(mobileUser);

        market.setStockPrice("AAPL", 190.00);
    }
}
