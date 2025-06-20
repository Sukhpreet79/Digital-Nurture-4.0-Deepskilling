public class WebApp implements Observer {
    private String name;

    public WebApp(String name) {
        this.name = name;
    }

    public void update(String stockName, double price) {
        System.out.println("Web App [" + name + "] - Stock: " + stockName + " updated to $" + price);
    }
}
