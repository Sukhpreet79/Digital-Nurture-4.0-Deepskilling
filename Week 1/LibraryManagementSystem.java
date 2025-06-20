
// Source code is decompiled from a .class file using FernFlower decompiler.
import java.util.Arrays;
import java.util.Scanner;

public class LibraryManagementSystem {
    static Book[] books = new Book[10];
    static int count = 0;

    public LibraryManagementSystem() {
    }

    public static void addBook(int var0, String var1, String var2) {
        if (count < books.length) {
            books[count++] = new Book(var0, var1, var2);
            System.out.println("Book added.");
        } else {
            System.out.println("Library is full.");
        }

    }

    public static void linearSearch(String var0) {
        boolean var1 = false;

        for (int var2 = 0; var2 < count; ++var2) {
            if (books[var2].title.equalsIgnoreCase(var0)) {
                Book var10001 = books[var2];
                System.out.println("Found (Linear): " + var10001);
                var1 = true;
            }
        }

        if (!var1) {
            System.out.println("Book not found (Linear Search).");
        }

    }

    public static void binarySearch(String var0) {
        Arrays.sort(books, 0, count);
        int var1 = 0;
        int var2 = count - 1;
        var0 = var0.toLowerCase();

        while (var1 <= var2) {
            int var3 = (var1 + var2) / 2;
            int var4 = books[var3].title.compareTo(var0);
            if (var4 == 0) {
                Book var10001 = books[var3];
                System.out.println("Found (Binary): " + var10001);
                return;
            }

            if (var4 < 0) {
                var1 = var3 + 1;
            } else {
                var2 = var3 - 1;
            }
        }

        System.out.println("Book not found (Binary Search).");
    }

    public static void displayBooks() {
        if (count == 0) {
            System.out.println("No books available.");
        } else {
            for (int var0 = 0; var0 < count; ++var0) {
                System.out.println(books[var0]);
            }

        }
    }

    public static void main(String[] var0) {
        Scanner var1 = new Scanner(System.in);
        addBook(101, "Harry Potter", "J.K. Rowling");
        addBook(102, "The Alchemist", "Paulo Coelho");
        addBook(103, "Wings of Fire", "A.P.J. Abdul Kalam");
        addBook(104, "Ikigai", "Francesc Miralles");
        addBook(105, "Think and Grow Rich", "Napoleon Hill");

        while (true) {
            System.out.println("\n1. Display 2. Linear Search 3. Binary Search 4. Exit");
            System.out.print("Choose: ");
            int var2 = var1.nextInt();
            var1.nextLine();
            switch (var2) {
                case 1:
                    displayBooks();
                    break;
                case 2:
                    System.out.print("Enter title to search (Linear): ");
                    linearSearch(var1.nextLine());
                    break;
                case 3:
                    System.out.print("Enter title to search (Binary): ");
                    binarySearch(var1.nextLine());
                    break;
                case 4:
                    System.out.println("Exiting...");
                    return;
                default:
                    System.out.println("Invalid option.");
            }
        }
    }
}
