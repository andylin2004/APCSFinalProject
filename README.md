# APCSFinalProject

Group name: Electrify

Group members: Andy Lin, Hannah Scheuer

Prototype link: https://docs.google.com/document/d/1jIfvNo0_G3YUK5EwlFBVEmY04cmeLTTwLvjW3gW6hfs/edit

We want to create a simulation of circuits. Users can choose the voltage of the circuit, amount of resistors, amount of resistance, and whether the resistors are in series or parallel (or a combination) by clicking to add components. They will then be able to measure the voltage, current, and power at different locations. In the bottom corner there will be a reset button so that users do not have to restart the program to clear the screen.

Instructions for use:

Welcome to Electrify, an interactive circuit simulation! To add an object, right click in the location you would like to display it. You will then see two dots. If you click the right dot, a  lightbulb will be added to the circuit, and the left side adds a battery. To add a wire, click one of the nodes on a lightbulb/battery and click again on the node you would like to attach it to. To adjust the resistance or voltage of a circuit component, hover over the component and use the arrow keys. Click the center of a circuit component to move it and the component will follow your mouse. When you want to put it down, click again. To view specific info about the component like voltage and resistance, hover over the component and click ‘d’. To erase the simulation, click the reset button in the bottom right corner.


Hannah's Development Log

May 26th: Added get and set methods for the CircuitComponents class. Started the Resistor class with a display method and a constructor.

May 27th: Spent way too much time figuring out Git and trying to fix (to no avail) the way git interacts in my terminal. I also worked on fixing a lot of merge conflicts. 

May 31st: Added methods to calculate the total current, voltage, and resistence of a series circuit and display those values in the top left corner. I also worked to fix the colors of text and circuit components in order to be more readable.

June 1st: Created a button in the bottom left corner that when clicked shows intructions for opperating the simulation.

June 4th: I began the process of finding images to use in the simulation rather than just rectangles and squares. Currently images for lightbulbs and batteries are included but do not allow you to connect wires to them.

June 6th: I attached the buttons to the sides of the resistor and battery images. I also created a way to alter the resistance and voltage of various circuit components by using the arrow keys.

June 8th: Worked on trying to make the code a bit neater, especially the mousePressed function which is very unreadable.

June 9th: Worked on updating UML since it hasn't been updated since the start of the project.

June 10th: Added images for the various buttons and changed the instructions to be more desscriptive.

June 11th: When you click the center of a circuit comoponent you can move it around the screen and the wires will follow. I also made a text box appear when the key d is pressed that has information on current, voltage, and resistence.

Andy's Dev Log:

May 25: implemented the RightClickMenu as a dummy menu in order to prepare for being able to add elements into the workspace. This also necessitated adding a button class for the right click menu.

May 26: implemented full functionality of the right click menu (now able to add circuit components). Implemented a reset button to clear workspace (necessitated extending button class). Implemented battery class (progress akin to Hannah's resistor class). Placed a dummy display function in circuitcomponents to accomdate a for loop to render the circuit parts.

May 27: implemented buttons on the circuit components (where the wires will be placed). Changed shape position to ints because buttons were having an issue and pixels are in int anyways. Implemented adding the start end of the wire (end point and dragging it around not implemented yet).

May 31: added the wires class in order to connect circuit components in a linked list manner. Overloaded CircuitComponent class in order to accomdate the wires class. Assisted with design choices for demo day (how to display data and when to display the data).

June 1: made a recursion loop to verify if a circuit is actually a circuit (which is not treating me well right now). This also forced me to have a input left/right variable for circuitcomponents and a later rewrite of the adding wire thing so that wires hook up to wires.

June 2: tried to work more on the recursion loop, but did not get much result due to fixes not being effective at resolving the issue.

June 3: I managed to fix the linked list thing, but this did not prove to be idiot-proof, as parts kept being linked the wrong way. I also had to fix a null pointer since I shifted wires to be added in parts in this change.

June 4: I made a circuitbranch class in order to more easily house the branches, but the doubily linked list implementation that I had was very shoddy and proved to break in the circuitbranch

June 5: I decided to restart the linked list development with the same structure, but from a blank sheet just so that I can think everything through properly. Before this, I also made it such that if there is a wire there and I add another wire there, it will branch out.

June 7: I had to change again to a multilinked list (no dedicated start/end) just so that people can place wires in any way and it won't break. Troubleshooting branching.

June 8: Proper linking with wires using the new linked list style. Implemented a function to see if a circuit is complete and left and right were misplaced (source of some of my issues).

June 9: Fix nullpointer involving wires again. Branching check to account for all branches and had to fix issues with stack overflow when it came to these recursion type functions.

June 10-11: functions to calculate for resistance, voltage, and current and tried to squash bugs (taking longer than what I wanted it to take). Fix lightbulb illegally shining (two wires connecting to the same end on the other end). Started to make a labeling system for circuit components (which is hard, as I need to account for parallel and series).