# Answers

Name: Aleena Tariq  
Roll No: 04072313016

## Q1) What can a subclass using extends use for free that a class using implements has to write itself?
A class using extends gets the fields and working methods of the parent class. A class using implements must write the required methods itself.

## Q2) Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?
A mixin is used when different classes need the same behaviour without having the same parent. An abstract parent class is used when the classes have a common IS-A relationship.

## Q3) Why must you override hashCode whenever you override ==?
Equal objects should have the same hashCode otherwise Sets and Maps may not treat equal objects correctly.

## Q4) An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?
An extension adds new behaviour to String without changing or inheriting from it. Dart does not allow String to have subclasses.
