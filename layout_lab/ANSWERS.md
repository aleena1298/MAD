
**Name:** Aleena Tariq  
**Roll Number:** 04072313016

A1: 16

A2: 7

A3: 3

A4: 66


### B1: Which classes are Stateless and which are Stateful, and why?

In my app, LabApp, HomePage, SettingsCard, Welcome, Probe, InfoPanel, SummaryRow, ShareRow, InfoBox, and StampStack are StatelessWidgets because they only display information or arrange widgets on the screen. They don't need to manage any changing data.

Clock, Tile, and SwapBoard are StatefulWidgets because their data changes. Clock updates the time every second, Tile updates its count when we click it, and SwapBoard changes the positions of the tiles when we press Swap.

### B2: Widget, Element, RenderObject: which one is rebuilt on every setState and which ones are kept? What did Probe show you?

When we call setState(), Flutter runs the build() method again and creates new Widget objects. However, the Element and RenderObject are usually kept and reused instead of being created again.

In the Probe experiment, I noticed that the Widget number changed when the clock updated, but the Element number stayed the same. This helped me understand that Widgets can be rebuilt, while Elements keep track of their place in the widget tree.

### B3: Explain “constraints go down, sizes go up” using your Step 7 or Step 8 example.

This means that a parent widget tells its children how much space they can use, and the children decide their sizes based on that space.

For example, in Step 7, the three Text widgets inside the Row were too long and caused an overflow because they needed more space than was available.

When I used Expanded, the Row divided the available width between the three Text widgets. The text then adjusted itself and moved onto multiple lines.

So, the parent gives the space limits to its children, and the children calculate their sizes and pass them back to the parent.
