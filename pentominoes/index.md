# Pentominoes

Using the code in my [automata](https://github.com/knoxa/automata) repository, 
I want to fill a board with 60 squares and get them to self-organize into the 12 distinct [pentominoes](https://en.wikipedia.org/wiki/Pentomino).

I'll start with an easier proposition, which is to simply fill the board with pentominoes of any type. The following algorithm does this:

* Partition the board into tiles. Initially, all the tiles will be of size 1.
* While there are no tiles of size 6 or more, randomly select one of the tiles of smallest size.
* Find the neighbouring tiles that touch this tile. Have a square defect from the selected tile to a smallest neighbour.
The defector is chosen at random when there is more than one square that could defect.
* If a tile gets to size 6 it is 'dissolved', which is to say that all its component squares are detached.
* Stop when all tiles are of size 5.

I typically get something like this:

![pentominoes](initial.svg)

This has 7 different pentominoes.
Theoretically, I can get all 12 pentominoes if I repeat this process often enough.
However, some pentominoes are more likely to appear than others, and it might take a long time to get a solution.
I'd like to force the pace.

I can try starting the pentomino forming procedure with some pentominoes already in place. For example, I can dissolve any duplicate
pentominoes from the first run ...

![dissolved duplicate pentominoes](dissolve1.svg)

... and try again:

![first attempt](attempt1.svg)

I now have 8 different pentominoes, but repeating the procedure again isn't necessarily going to improve the situation.
One problem is that the the procedure doesn't always preserve the pentominoes that were in the start state, so the number of distinct tiles
doesn't monotonically increase. 
Another problem is that small, isolated groups of squares are likely to reform exactly the tiles that were dissolved to make them.
I can address both problems by changing the pentomino dissolving strategy to select contiguous tiles.

With this as my next starting point ...

![dissolved duplicate pentominoes](dissolve2.svg)

and get ...

![second attempt](attempt2.svg)

... but this may still alter tiles in the starting state, such as the I-pentomino along the bottom edge.
I can fix this by altering the sensed environment in the start state to include only tiles of size one.
The fixed pentominoes become 'invisible' and play no part in the algorithm.

I can proceed along these lines, but success is not guaranteed because the part of the board I've fixed may not be part of a valid solution.
I am likely to find that the last two or three tiles I need to fit can't be arranged in the space available.
Above, for example, I have an X-pentomino and W-pentomino still to fit - and it's not clear that they go.

Something different I can try is to transform pentominoes instead of dissolving and reforming them.
One method has a square leaving a pentomino and attaching to one of its neighbours, which disgorges another square in turn.
A singleton square thus moves from tile to tile until it joins the tetronimo created in the first step, halting the process.
I can make this operate in a limited area of the board by restricting the sensed environment as above.
Another method is to transform an adjacent pair of pentominoes to produce an alternate pair covering the same ground.

These pentomino transformations allow a partial solution to be changed within the same area of the board, leaving a different set of remaining tiles that might be easier to fit.
Transformations could be usefully exploited if some planning step is included, but aren't helpful if they are chosen randomly.

To get a feel for the planning problem, I proceeded step-by-step to try out various combinations of operations and see if I could get to a solution.
I soon got to this point:

![third attempt](attempt3.svg)

This has 10 unique pentominoes. A missing U-pentomino and Y-pentomino need to replace a W-pentomino and P-pentomino.
This is a hopeful situation because the P-pentomino is the easiest to produce, randomly or by transformation, and there is a U-pentomino next to a Y-pentomino at the bottom-left of the board. Unfortunately, the W-pentomino is awkward and won't fit into the space.
The nearby X-pentomino and U-pentomomino can't be moved into that space either. I'm painted into a corner.

What I do notice though is that the X-pentomino and F-pentomino can swap places by transformation ...

![a pentomino transformation](transformation.svg)

... which gives a bit more working room at the left of the board. Proceeding as before, I clear spaces, create tiles that fit, and try to transform this to fit the more awkward tiles.
I can get the W-pentomino and F-pentomino fixed, then the N-pentomino and the Z-pentomino, moving the focus of my attention along the bottom of the board as I go.
When I get to this point ... 

![fourth attempt](attempt4.svg)

... the end is in sight. There are 9 distinct pentominoes. I'm missing the Y-pentomino, U-pentomino, and T-pentomino. The V-pentomino, P-pentomino and L-pentomino are repeated, but there are three of them together in an almost square block near the top-right of the board. I can see that the tiles I need would fit, but it's not clear
how to get there by pairwise transformations. However, I can dissolve the repeated tiles ...

![dissolved near solution](dissolve3.svg)

... and fill the gap.

![fifth attempt](attempt5.svg)

... then transform an L-pentomino and the P-pentomino to give a T-pentomino and P-pentomino ...

![sixth attempt](attempt6.svg)

.. then transform the newly created P-pentomino and the other L-pentomino to give a solution:

![a 6x10 pentominoes solution](solution.svg)

In some cases at least, it's possible to get from a degenerate solution (with duplicate pentominoes) to a proper solution (all 12 pentominoes) by transforming pairs of tiles.
 Whether it's always possible is an open question.
 If it is, then any degenerate solution could be used as a starting point for an algorithm that searches for the sequence of transformations needed to reach a proper solution.
I'll come back to that.

## A random solution

The method described above gives me a solution with 10 distinct pentominoes every thousand or so attempts, and 11 pentominoes every thirty to forty thousand.
I've run eight hundred thousand attempts without getting a complete solution in though.

I can improve the likelihood of getting a proper solution by adding complete pentominoes at random rather letting a board of distinct squares coalesce to pentominoes.
This approach will fail to fill board if placing a pentomino closes off an area that is not a multiple of 5.
I can reduce the chances of this happening a little by controlling the order in which squares are filled: corners first, then edges, then the interior.
I can also add the constraint that the next tile cannot be the same as one already placed, so I either get a solution or the method fails with a partially filled board.
This gives me a proper solution every twenty to thirty thousand attempts. Incomplete boards of 10 or 11 pentominoes are fairly common.

## Random pentomino transformations

Another random approach is to create a degenerate solution and randomly transform pairs of pentominoes until a true solution is reached. As noted above,
it's not obvious if a transformation step will take you closer to the solution or not.
I first tried making a completely random choice (from adjoining pairs that can transform), which failed to succeed in the first hundred thousand trials.
The number of unique pentominoes fluctuates under this method, and there are some things to be learned about the frequency of occurrence of pentomino types
in degenerate solutions. Notably, the P pentomino is the most common and the X pentomino the least common.

Next, I adjusted the method to choose the first of the pair from the set of pentominoes that are duplicated, with the second of the pair a 
random neighbour. This often produces solutions,
but sometimes gets to a stage where there are 11 (occassionally 10) unique pentominoes, and the transformations just repeat around a short loop.
Either result happens within a few thousand transformations.

I also tried exluding the X pentomino from the choice of pair to transform.
This produced fewer proper solutions, and more degenerate 11 pentomino solutions, but finished more quickly either way.
Interestingly, one of the degenerate solutions (in just 78 transformations) was a very near miss:

![a near miss](swap-nearly.svg)

This is missing the F pentomino, but the P pentomino and the X pentomino to its left transform to F and P:

![swap solution](swap-nearly.svg)

If I start from the near-miss state, and remove the restriction on selecting X pentominoes, the algorithm (without further interference) happens to choose
the 'wrong' X pentomino at the next step, and wanders away from the solution subsequently.

This seems like a reasonably useful method, at least when searching for 6 x 10 solutions, which are the most common.
I did manage to get 5 x 12 and 4 x 15 solutions without much trouble though.
When  I tried for a 3 x 20 solution, the first several attempts (starting with different random number seeds) ended in loops over degenerate solutions
- but then I got ... 

![3 x 20 solution](3x20.svg)

... which is one of the two possible 3 x 20 solutions. The earlier attempts failed in under 10,000 transformations, and the successful run took 8124 transformations.

## Conclusion 

This exercise is by way of applying the code in my [automata](https://github.com/knoxa/automata) repository.
Pentominoes are colonies of 5 square cells.
The random methods described above need take no account of the orientation of pentominoes - a colony of 5 cells either fits or it doesn't.

If I were just interested in generating solutions, I could implement something like the [Exact Cover algorithm](https://en.wikipedia.org/wiki/Exact_cover)
or some other form of exhaustive search.
Alternatively, I could just download solutions from [Isomer Design's Pentomino page](https://isomerdesign.com/Pentomino/index.html).

I'm more interested in how pentomino transformations relate degenerate solutions to proper solutions, and how they relate solutions to each other.
There is some discussion of the relationship between solutions on the Isomer Design page. This discusses several classes of transformation,
all of which could (I hypothesize) be reduced to transforming pairs of tiles in sequence. Plenty more to explore.