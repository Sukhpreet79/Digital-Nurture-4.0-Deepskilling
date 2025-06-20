import java.util.HashMap;
import java.util.Map;

public class CustomerRepositoryImpl implements CustomerRepository {
    private Map<String, Customer> customers = new HashMap<>();

    public CustomerRepositoryImpl() {
        // Add sample customers
        customers.put("C001", new Customer("C001", "John Doe"));
        customers.put("C002", new Customer("C002", "Alice Smith"));
    }

    public Customer findCustomerById(String id) {
        return customers.get(id);
    }
}
