# Course Roster Console App

Name: Aleena Tariq  
Registration No: 04072313016

In Part 1, I learned how to create the `main()` function, make a helper function, pass a value to a function, and print a welcome message.

In Part 2, I learned how to use different data types and the difference between `const`, `final`, and normal variables. I also used `List`, `Set`, and `Map` to store course and student data. `const` is used when the value is known at compile time and cannot change. `final` is used when the value is known only at runtime but should only be assigned once. `DateTime.now()` cannot be `const` because the current date and time are only known when the program runs. Normal variables are used for values that we may need to change later.

In Part 3, I learned about null safety, nullable variables, `??`, `?.`, `late`, and why using `!` on a null value can cause an error. Nullable variables are used when a value may be missing or null. The `?` after a data type allows it to store null. The `??` operator is used to give a fallback value if something is null. The `?.` operator safely accesses a property only when the value is not null. `late` is used when a variable will be assigned later before it is used. The `!` operator tells Dart that a value is definitely not null, so using it on an actual null value can cause a runtime error.

In Part 4, I learned how to split and clean strings using `.split()` and `.trim()`, use a `for-in` loop, create multi-line strings, and use string interpolation. `.split()` is used to divide one string into smaller parts, while `.trim()` removes extra spaces from the beginning and end of a string. A `for-in` loop is used to go through each item one by one. Multi-line strings are useful when we want to write text on several lines, and string interpolation lets us insert variables or expressions directly inside a string using `$` or `${}`.

In Part 5, I learned how to use operators like `~/`, `%`, `is`, `is!`, `..`, `?..`, and `??=`. `~/` is used for integer division, while `%` gives the remainder. The `is` operator checks whether a value is of a certain type, and `is!` checks whether it is not that type. The `..` cascade operator lets us perform multiple operations on the same object without repeating its name. The `?..` operator does the same thing safely for a nullable object, and `??=` assigns a value only when the variable is currently null.

In Part 6, I learned how to use `if/else`, `switch`, `break`, and the ternary operator to control the flow of the program.

In Part 7, I learned how to use `for-in`, `forEach`, and how to use `if` and `for` inside a list to create announcements dynamically.
