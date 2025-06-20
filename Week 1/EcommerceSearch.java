import java.util.Arrays;
import java.util.Comparator;

// Product class
class Product {
    int productId;
    String productName;
    String category;

    public Product(int productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }

    public String toString() {
        return "[" + productId + "] " + productName + " - " + category;
    }
}

// Main class with search logic
public class EcommerceSearch {

    // Linear Search by product name
    public static int linearSearch(Product[] products, String targetName) {
        for (int i = 0; i < products.length; i++) {
            if (products[i].productName.equalsIgnoreCase(targetName)) {
                return i;
            }
        }
        return -1;
    }

    // Binary Search by product name (requires sorted array)
    public static int binarySearch(Product[] products, String targetName) {
        int low = 0, high = products.length - 1;
        while (low <= high) {
            int mid = (low + high) / 2;
            int compare = products[mid].productName.compareToIgnoreCase(targetName);
            if (compare == 0)
                return mid;
            else if (compare < 0)
                low = mid + 1;
            else
                high = mid - 1;
        }
        return -1;
    }

    public static void main(String[] args) {
        Product[] products = {
            new Product(101, "Laptop", "Electronics"),
            new Product(102, "Shoes", "Fashion"),
            new Product(103, "Watch", "Accessories"),
            new Product(104, "Mobile", "Electronics"),
            new Product(105, "Bag", "Fashion")
        };

        // ➤ Linear Search (unsorted)
        System.out.println("\n--- Linear Search ---");
        int index1 = linearSearch(products, "Watch");
        System.out.println(index1 != -1 ? "Found: " + products[index1] : "Product not found");

        // ➤ Sort for Binary Search
        Arrays.sort(products, Comparator.comparing(p -> p.productName.toLowerCase()));

        // ➤ Binary Search (sorted)
        System.out.println("\n--- Binary Search ---");
        int index2 = binarySearch(products, "Watch");
        System.out.println(index2 != -1 ? "Found: " + products[index2] : "Product not found");
    }
}
