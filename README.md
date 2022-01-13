# Knights-Tour-Chess

This is a solution to the Knight's Tour problem. Here the knight must move across all squares of a chess board without being allowed to move to the same square more than once.  

The project was inspired by [several puzzles](https://layton.fandom.com/wiki/Puzzle:The_Knight%27s_Tour_4) from the game Professor Layton and the Diabolical Box:

The chessboard length and width can be adjusted arbitrarily.   

The algorithm goes through the possibilities according to the brute force principle until a correct one is found.  

The second script is a parallelized version of the first script. By using the parfor function from the parallel computing toolbox several processors work independently on one solution each. 
By choosing different starting paths for each processor, the chance to find a solution in not too much time is significantly increased.  
Especially for larger chessboards (a normal chessboard of 8x8 and larger) the parallelized code is better suited, because with the serial code the solution finding may take extremely long.
