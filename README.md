# APCSFinalProject

Group name: Electrify

Group members: Andy Lin, Hannah Scheuer

Prototype link: https://docs.google.com/document/d/1jIfvNo0_G3YUK5EwlFBVEmY04cmeLTTwLvjW3gW6hfs/edit

We want to create a simulation of circuits. Users can choose the voltage of the circuit, amount of resistors, amount of resistance, and whether the resistors are in series or parallel (or a combination) by clicking to add components. They will then be able to measure the voltage, current, and power at different locations. In the bottom corner there will be a reset button so that users do not have to restart the program to clear the screen.


Hannah's Development Log

May 26th: Added get and set methods for the CircuitComponents class. Started the Resistor class with a display method and a constructor.

Andy's Dev Log:

May 25: implemented the RightClickMenu as a dummy menu in order to prepare for being able to add elements into the workspace. This also necessitated adding a button class for the right click menu.
May 26: implemented full functionality of the right click menu (now able to add circuit components). Implemented a reset button to clear workspace (necessitated extending button class). Implemented battery class (progress akin to Hannah's resistor class). Placed a dummy display function in circuitcomponents to accomdate a for loop to render the circuit parts.
