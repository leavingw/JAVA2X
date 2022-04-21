package com.company;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {



        while(true) {

            System.out.println("\n");
            System.out.println("LibrarySystem Menu");
            System.out.println("[1] Add user");
            System.out.println("[2] View users");
            System.out.println("[3] Search for user");


            Scanner userInput = new Scanner(System.in);
            String userChoice = userInput.next();

                if (userChoice.equalsIgnoreCase("1")) {
                    userMethods.addUser();
                } else if (userChoice.equalsIgnoreCase("2")) {
                    userMethods.selectUsers();
                } else if (userChoice.equalsIgnoreCase("3")) {
                    userMethods.searchUser();
                }
                else{
                    System.out.println("Invalid option.. GoodBye");
                    break;
                }
        }
    }


}
