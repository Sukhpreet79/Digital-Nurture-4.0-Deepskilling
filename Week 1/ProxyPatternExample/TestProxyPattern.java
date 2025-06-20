public class TestProxyPattern {
    public static void main(String[] args) {
        Image image1 = new ProxyImage("nature_photo.jpg");
        Image image2 = new ProxyImage("mountain_view.jpg");

        // Image is loaded only when display is called
        System.out.println("First time displaying image1:");
        image1.display();  // Loads and displays

        System.out.println("\nSecond time displaying image1:");
        image1.display();  // Just displays (cached)

        System.out.println("\nDisplaying image2:");
        image2.display();  // Loads and displays
    }
}
