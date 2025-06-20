public class DependencyInjectionDemo {
    public static void main(String[] args) {
        // Create repository
        CustomerRepository repository = new CustomerRepositoryImpl();

        // Inject repository into service
        CustomerService service = new CustomerService(repository);

        // Use the service
        System.out.println("Fetching customer C001:");
        service.getCustomerInfo("C001");

        System.out.println("\nFetching customer C003:");
        service.getCustomerInfo("C003");
    }
}
