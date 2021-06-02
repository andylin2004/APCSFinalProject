# APCSFinalProject

Group name: Electrify

Group members: Andy Lin, Hannah Scheuer

Prototype link: https://docs.google.com/document/d/1jIfvNo0_G3YUK5EwlFBVEmY04cmeLTTwLvjW3gW6hfs/edit

We want to create a simulation of circuits. Users can choose the voltage of the circuit, amount of resistors, amount of resistance, and whether the resistors are in series or parallel (or a combination) by clicking to add components. They will then be able to measure the voltage, current, and power at different locations. In the bottom corner there will be a reset button so that users do not have to restart the program to clear the screen.


Hannah's Development Log

May 26th: Added get and set methods for the CircuitComponents class. Started the Resistor class with a display method and a constructor.

May 27th: Spent way too much time figuring out Git and trying to fix (to no avail) the way git interacts in my terminal. I also worked on fixing a lot of merge conflicts. 

May 31: Added methods to calculate the total current, voltage, and resistence of a series circuit and display those values in the top left corner. I also worked to fix the colors of text and circuit components in order to be more readable.

Andy's Dev Log:

May 25: implemented the RightClickMenu as a dummy menu in order to prepare for being able to add elements into the workspace. This also necessitated adding a button class for the right click menu.

May 26: implemented full functionality of the right click menu (now able to add circuit components). Implemented a reset button to clear workspace (necessitated extending button class). Implemented battery class (progress akin to Hannah's resistor class). Placed a dummy display function in circuitcomponents to accomdate a for loop to render the circuit parts.

May 27: implemented buttons on the circuit components (where the wires will be placed). Changed shape position to ints because buttons were having an issue and pixels are in int anyways. Implemented adding the start end of the wire (end point and dragging it around not implemented yet).

May 31: added the wires class in order to connect circuit components in a linked list manner. Overloaded CircuitComponent class in order to accomdate the wires class. Assisted with design choices for demo day (how to display data and when to display the data).

June 1: made a recursion loop to verify if a circuit is actually a circuit (which is not treating me well right now). This also forced me to have a input left/right variable for circuitcomponents and a later rewrite of the adding wire thing so that wires hook up to wires.
