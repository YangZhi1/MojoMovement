# MojoMovement
Simple code which uses bit shift logic and a register to select rows to "move" a bit around (which will be displayed on the IO shield of the Mojo FPGA

Use the IO buttons on the shield (up/down/left/right) to move

The IO LEDs will display "your current position". Right-most row is row 0, so pressing down button will move you "down" to row 1 (middle row)


## Simple Explanation
For left and right movement, the in-built shift-left and shift-right functions from mojo are used


For up and down movement, I have created a "register" (dff row_selector) which stores the current row you are at.

When moving up, the data stored in the current row will be written into the row you are moving into. Current row data will be "erased" (set to all zeroes) and row_selector will be updated accordingly to your new row.



## Trivia stuff
It is important to include such lines for dff which you want the data to persist (for example):

row_selector.d = row_selector.q;

D is actually the input of the D-type flip-flop and Q is the output of the D-type flip-flop. You can think of this as wiring your output straight back into your input for the data to be persistent and not "erased" after 1 clock cycle.
![Repo List](/dff.png)

Taken from: https://alchitry.com/blogs/tutorials/synchronous-logic-1
