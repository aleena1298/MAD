# CS 442 - Week 1 Lab Task
## Enhance the Counter App

**Name:** Aleena Tariq  
**Registration No:** 04072313016

### Personal Parameters
- `myThreshold = (0 + 1 + 6) + 5 = 12`
- `mySeedColor = Colors.amberAccent`

### Features
- Increment counter button
- Reset counter button
- Reset usage tracker
- "You're on a roll!" message when the counter exceeds 12
- Personalized app theme
- Student information displayed in the app

### Screenshot

<img width="953" height="441" alt="image" src="https://github.com/user-attachments/assets/0855eb1a-b7f2-4488-bb25-0af10b00d404" />

### Reflection
`setState()` is used when a value in the app changes and the screen needs to show the updated value. For example, when I increase or reset the counter, `setState()` tells Flutter to rebuild the widget with the new data. Without it, the variable may change internally, but the updated value would not appear on the screen.
