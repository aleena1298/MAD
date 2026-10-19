# Study Tracker Lab Answers

Name: Aleena Tariq  
Roll No: 04072313016

A1: 7

A2: 7

A3: 9

A4: 40

## B1
LabApp, HomePage, StudentCard and GoalBanner are Stateless because they do not store changing data.

Tally, BuggyCounter and Countdown are Stateful because their values change while the app is running.

## B2
The Timer must be cancelled in dispose() so it stops when the widget is removed.
Otherwise, it may keep running and cause "setState() called after dispose()".

## B3
Widgets that do not change can be const, such as LabApp, HomePage, Tally, Countdown, BuggyCounter, SizedBox and fixed Text widgets.

const tells Flutter that the widget will not change, so Flutter can reuse it and avoid unnecessary work.
