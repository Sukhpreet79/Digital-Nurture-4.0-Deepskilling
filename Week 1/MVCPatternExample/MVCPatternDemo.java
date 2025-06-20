public class MVCPatternDemo {
    public static void main(String[] args) {
        // Create model and view
        Student student = new Student("John Doe", "S101", "A");
        StudentView view = new StudentView();

        // Create controller
        StudentController controller = new StudentController(student, view);

        // Initial view
        controller.updateView();

        // Update model data via controller
        controller.setStudentName("Alice Smith");
        controller.setStudentGrade("A+");

        // Updated view
        System.out.println("\nAfter updating student details:");
        controller.updateView();
    }
}
