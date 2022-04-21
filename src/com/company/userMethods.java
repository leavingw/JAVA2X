package com.company;

import java.sql.*;
import java.util.Scanner;

public class userMethods {

    public static void addUser() {

        Scanner userInput = new Scanner(System.in);

        System.out.println("Please enter first name");
        String firstName = userInput.nextLine();
        firstName = firstName.substring(0, 1).toUpperCase() + firstName.substring(1).toLowerCase();

        System.out.println("Please enter last name");
        String lastName = userInput.nextLine();
        lastName = lastName.substring(0, 1).toUpperCase() + lastName.substring(1).toLowerCase();

        System.out.println("Please enter email");
        String email = userInput.nextLine();

        System.out.println("Please enter personal number");
        String personalNumber = userInput.nextLine();

        System.out.println("Please enter phone number");
        String phonenumber = userInput.nextLine();

        int status = 1;

        String accountType = "Standard";


        try (
                // Step 1: Construct a database 'Connection' object called 'conn'
                Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/libraryx?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC",
                        "root", "1234");   // For MySQL only
                // The format is: "jdbc:mysql://hostname:port/databaseName", "username", "password"

                // Step 2: Construct a 'Statement' object called 'stmt' inside the Connection created
                Statement stmt = conn.createStatement()
        ) {




            // Step 3: Write a SQL query string. Execute the SQL query via the 'Statement'.
            String strInsert = "INSERT INTO user (AccountType, Fname, Lname, Email, SSN, PhoneNumber, Status) " +
                    "VALUES ('"+accountType+"', '"+firstName+"', '"+lastName+"', '"+email+"', '"+personalNumber+"', '"+phonenumber+"', '"+status+"')";
            System.out.println("The SQL statement is: " + strInsert + "\n"); // Echo For debugging
            stmt.executeUpdate(strInsert);



            // System.out.println(rset);


        } catch(SQLException ex) {
            ex.printStackTrace();
        }  // Step 5: Close conn and stmt - Done automatically by try-with-resources (JDK 7)


    }

    public static void selectUsers() {
        try (
                Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/libraryx?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC",
                        "root", "1234");

                Statement stmt = conn.createStatement()
        ) {

            String strSelect = "select * from user";
            System.out.println("The SQL statement is: " + strSelect + "\n");

            ResultSet rset = stmt.executeQuery(strSelect);

            System.out.println("Users are:");
            int rowCount = 0;

                while(rset.next()) {
                    String firstName = rset.getString("Fname");
                    String lastName = rset.getString("Lname");
                    String email   = rset.getString("Email");
                    String personnummer   = rset.getString("SSN");
                    String phonenumber   = rset.getString("PhoneNumber");
                    int status   = rset.getInt("Status");
                    String AccountType   = rset.getString("AccountType");


                    System.out.println(firstName + " " + lastName + ", " + email + ", " + personnummer + ", "+ phonenumber+", Status: "+status+", AT: "+AccountType);
                    ++rowCount;
                }
            System.out.println("Total number of records = " + rowCount);

        } catch(SQLException ex) {
            ex.printStackTrace();
        }
    }



    public static void searchUser() {

        Scanner userInput = new Scanner(System.in);

        System.out.println("Please enter a last name to search for: ");
        String searchName = userInput.nextLine();
        searchName = searchName.substring(0, 1).toUpperCase() + searchName.substring(1).toLowerCase();


        try (
                Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/libraryx?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC",
                        "root", "1234");

                Statement stmt = conn.createStatement()
        ) {


            String strSelect = "SELECT * FROM user WHERE Fname='" + searchName + "'";
            System.out.println("The SQL statement is: " + strSelect + "\n");

            ResultSet rset = stmt.executeQuery(strSelect);

            System.out.println("Search results: ");
            int rowCount = 0;
                while (rset.next()) {

                    String firstName = rset.getString("Fname");
                    String lastName = rset.getString("Lname");
                    String userID = rset.getString("userID");
                    System.out.println(firstName + " " + lastName + ", Users ID is: " + userID);
                    ++rowCount;
                }
            System.out.println("Total number of records = " + rowCount);

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

    }

}
