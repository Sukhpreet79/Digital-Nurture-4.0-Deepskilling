import java.util.Arrays;

// Order class
class Order {
    int orderId;
    String customerName;
    double totalPrice;

    public Order(int orderId, String customerName, double totalPrice) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.totalPrice = totalPrice;
    }

    public String toString() {
        return "[" + orderId + "] " + customerName + " | Rs." + totalPrice;
    }
}

public class CustomerOrderSetting {

    // Bubble Sort
    public static void bubbleSort(Order[] orders) {
        int n = orders.length;
        for (int i = 0; i < n - 1; i++) {
            boolean swapped = false;
            for (int j = 0; j < n - i - 1; j++) {
                if (orders[j].totalPrice > orders[j + 1].totalPrice) {
                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;
                    swapped = true;
                }
            }
            if (!swapped) break;
        }
    }

    // Quick Sort
    public static void quickSort(Order[] orders, int low, int high) {
        if (low < high) {
            int pi = partition(orders, low, high);
            quickSort(orders, low, pi - 1);
            quickSort(orders, pi + 1, high);
        }
    }

    private static int partition(Order[] orders, int low, int high) {
        double pivot = orders[high].totalPrice;
        int i = low - 1;

        for (int j = low; j < high; j++) {
            if (orders[j].totalPrice < pivot) {
                i++;
                Order temp = orders[i];
                orders[i] = orders[j];
                orders[j] = temp;
            }
        }

        Order temp = orders[i + 1];
        orders[i + 1] = orders[high];
        orders[high] = temp;

        return i + 1;
    }

    // Display helper
    public static void displayOrders(Order[] orders) {
        for (Order o : orders) {
            System.out.println(o);
        }
    }

    public static void main(String[] args) {
        Order[] orders1 = {
            new Order(201, "Alice", 3499.50),
            new Order(202, "Bob", 1200.00),
            new Order(203, "Charlie", 5799.00),
            new Order(204, "Daisy", 2200.75),
            new Order(205, "Eve", 999.99)
        };

        // Copy array for different sorting
        Order[] orders2 = Arrays.copyOf(orders1, orders1.length);

        System.out.println("--- Before Sorting ---");
        displayOrders(orders1);

        // Bubble Sort
        System.out.println("\n--- Bubble Sort (by Price) ---");
        bubbleSort(orders1);
        displayOrders(orders1);

        // Quick Sort
        System.out.println("\n--- Quick Sort (by Price) ---");
        quickSort(orders2, 0, orders2.length - 1);
        displayOrders(orders2);
    }
}
