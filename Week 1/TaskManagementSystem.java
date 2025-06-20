import java.util.Scanner;

// Node class
class Task {
    int taskId;
    String taskName;
    String status;
    Task next;

    public Task(int taskId, String taskName, String status) {
        this.taskId = taskId;
        this.taskName = taskName;
        this.status = status;
        this.next = null;
    }

    public String toString() {
        return "[" + taskId + "] " + taskName + " - " + status;
    }
}

// Linked List class
public class TaskManagementSystem {
    static Task head = null;

    // Add task at end
    public static void addTask(int id, String name, String status) {
        Task newTask = new Task(id, name, status);
        if (head == null) {
            head = newTask;
        } else {
            Task temp = head;
            while (temp.next != null) {
                temp = temp.next;
            }
            temp.next = newTask;
        }
        System.out.println("Task added.");
    }

    // Search task by ID
    public static void searchTask(int id) {
        Task temp = head;
        while (temp != null) {
            if (temp.taskId == id) {
                System.out.println("Found: " + temp);
                return;
            }
            temp = temp.next;
        }
        System.out.println("Task not found.");
    }

    // Display all tasks
    public static void displayTasks() {
        if (head == null) {
            System.out.println("No tasks available.");
            return;
        }
        Task temp = head;
        while (temp != null) {
            System.out.println(temp);
            temp = temp.next;
        }
    }

    // Delete task by ID
    public static void deleteTask(int id) {
        if (head == null) {
            System.out.println("No tasks to delete.");
            return;
        }

        if (head.taskId == id) {
            head = head.next;
            System.out.println("Task deleted.");
            return;
        }

        Task temp = head;
        while (temp.next != null && temp.next.taskId != id) {
            temp = temp.next;
        }

        if (temp.next == null) {
            System.out.println("Task not found.");
        } else {
            temp.next = temp.next.next;
            System.out.println("Task deleted.");
        }
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        while (true) {
            System.out.println("\n1. Add Task  2. Search Task  3. Display All  4. Delete Task  5. Exit");
            System.out.print("Choose: ");
            int ch = sc.nextInt();
            switch (ch) {
                case 1:
                    System.out.print("Task ID: ");
                    int id = sc.nextInt();
                    sc.nextLine(); // consume newline
                    System.out.print("Task Name: ");
                    String name = sc.nextLine();
                    System.out.print("Status: ");
                    String status = sc.nextLine();
                    addTask(id, name, status);
                    break;
                case 2:
                    System.out.print("Enter ID to search: ");
                    searchTask(sc.nextInt());
                    break;
                case 3:
                    displayTasks();
                    break;
                case 4:
                    System.out.print("Enter ID to delete: ");
                    deleteTask(sc.nextInt());
                    break;
                case 5:
                    System.out.println("Exiting...");
                    return;
                default:
                    System.out.println("Invalid choice.");
            }
        }
    }
}
