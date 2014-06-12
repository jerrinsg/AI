##Heuristic

Number of white tiles to the right of at least one black tile. For example w/b/w/0/w/b/b has the heuristic value 2, and w/w/w/0/b/b/b has the heuristic value 0. This heuristic gives a good idea about how close we are to the goal state.

This is an admissible heuristic. For any state S, the heuristic value h(S) ≤ h\*(S), where h\* is the actual cost of an optimal path from the start node to the goal node that passes through node S. This is because the number of white tiles to the right of atleast one black tile gives a tight lower bound to the number of moves required to reach the goal state. Thus the heuristic never overestimates the cost to reach the goal state and remains admissible.

The heuristic is monotonic. For any two adjacent configurations in the state space Si and Sj, where Sj is a descendant of Si, h(Si)-h(Sj) ≤ cost(Si,Sj). This is because for any two adjacent configurations, the number of white tiles to the right of atleast one black tile decreases maximum by 1. Since the cost of every move is 1, the difference in heuristic values of adjacent configurations satisfy the property of monotonicity.

Value of the heuristic lies between 0 and 3. Thus, this heuristic is better informed than simpler heuristics like number of tiles out of place. This is not the best informed heuristic. There are better heuristics, but which are expensive to compute.

## Performance of the heuristic

As per the discussions in [[1]](http://www.cs.trincoll.edu/~ram/cpsc352/hmk/heuristics-ans.html "Ralph Morelli. Heuristic Search. 2005"), the average branching factor of the sliding tile puzzle is 4.29. This value include branches in which undo moves were made. If such moves are eliminated, 1 per state, the branching factor becomes 23/7 = 3.28.

Breadth first search, with a branching factor of B = 3.28 and a solution path of length 10, will require that T = B<sup>1</sup> + B<sup>2</sup> + B<sup>3</sup> + ... + B<sup>10</sup> states be examined, which is more that 2,00,000 states.

## Experimental run
<\br>
?-solve(b/b/b/0/w/w/w).

1. hop right one
2. hop left two
3. hop left one
4. hop right two
5. hop right two
6. move left
7. hop left two
8. hop right one
9. hop left two

true.


 Configuration  | g(n) | h(n) | f(n)  
:--------------:|:----:|:----:|:-----:
 b/b/b/0/w/w/w  |   0  |  3   |   3       
 b/0/b/b/w/w/w  |   1  |  3   |   4  
 b/w/b/b/0/w/w  |   2  |  3   |   5     
 b/w/b/b/w/w/0  |   3  |  3   |   6 
 b/w/b/0/w/w/b  |   4  |  3   |   7
 0/w/b/b/w/w/b  |   5  |  2   |   7
 w/0/b/b/w/w/b  |   6  |  2   |   8
 w/w/b/b/0/w/b  |   7  |  1   |   8
 w/w/0/b/b/w/b  |   8  |  1   |   9
 w/w/w/b/b/0/b  |   9  |  0   |   9
 
The worst case input is solved in 9 steps. With an average branching factor of 4.29, it will examine about 40 states.
 
?- solve(b/w/b/0/w/b/w).

1. hop right two
2. move left
3. hop left two
4. hop left one
5. move right
6. hop right two
7. hop left one
 
true.

 Configuration  | g(n) | h(n) | f(n)  
:--------------:|:----:|:----:|:-----:
 b/w/b/0/w/b/w  |   0  |  3   |   3       
 0/w/b/b/w/b/w  |   1  |  2   |   3  
 w/0/b/b/w/b/w  |   2  |  2   |   4     
 w/w/b/b/0/b/w  |   3  |  1   |   4 
 w/w/b/b/w/b/0  |   4  |  1   |   5
 w/w/b/b/w/0/b  |   5  |  1   |   6
 w/w/0/b/w/b/b  |   6  |  1   |   7
 w/w/w/b/0/b/b  |   7  |  0   |   7
 
## References
 
1. Ralph Morelli. Heuristic Search. 2005. [http://www.cs.trincoll.edu/~ram/cpsc352/hmk/heuristics-ans.html](http://www.cs.trincoll.edu/~ram/cpsc352/hmk/heuristics-ans.html "Ralph Morelli. Heuristic Search. 2005")
