My project generates 'trees' of various design

Mostly makes use of random() and PVectors to generate shapes
Also makes heavy use of Matrix transformations/rotations

Breakdown of generation:
- a main 'stem' starts at center-bottom of screen
- a left and right stem converge on X pos of the main stem to form 'roots'
- these stems continue upwards until they reach a generated y-value - where they stop
- 'branches' (similar in function to the stems) form at various generated rotations, increasing in Y pos
- at generated points along each branch, a 'split' can form (max of 7 per branch)
- each split is like a thinner branch, with varying generated length and thickness
- after every branch and split has reached it's minimum size (size of rects shrink with each draw cycle), they stop growing
- leaves form at the last locations of each branch and split (the tips)
- leaves formed at branch positions spawn additional leaves to the left, right, and top of the origin point
- leaves start at an origin point, and randomly draw within a radius which increases each cycle, until it reaches a generated max-size
- flowers then spawn at generated points within the leaves

Colors and sizes of elements are generated at the start of the program, within a range I have decided to be most appealing

