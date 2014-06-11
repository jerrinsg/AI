/*
	Jerrin Shaji George, B090437CS
	
	Sliding Tile solver
	
	Usage : solve(Start_State).
	Start_State can be a permutation of b/b/b/0/w/w/w

	Each state has the form : A/B/C/D/E/F/G
		where {A,...,G} = {w,b,0} 
        w : White tile at position
		b : Black tile at position
		0 : Empty tile
		
	Heuristics used
	H :- Number of white tiles to the right of at least one black tile. 

*/                   

% Set of goal states
goal(0/w/w/w/b/b/b).
goal(w/0/w/w/b/b/b).
goal(w/w/0/w/b/b/b).
goal(w/w/w/0/b/b/b).
goal(w/w/w/b/0/b/b).
goal(w/w/w/b/b/0/b).
goal(w/w/w/b/b/b/0).

% Set of moves
move_left(0/A/B/C/D/E/F, A/0/B/C/D/E/F).
move_left(A/0/B/C/D/E/F, A/B/0/C/D/E/F).
move_left(A/B/0/C/D/E/F, A/B/C/0/D/E/F).
move_left(A/B/C/0/D/E/F, A/B/C/D/0/E/F).
move_left(A/B/C/D/0/E/F, A/B/C/D/E/0/F).
move_left(A/B/C/D/E/0/F, A/B/C/D/E/F/0).

move_right(A/B/C/D/E/F/0, A/B/C/D/E/0/F).
move_right(A/B/C/D/E/0/F, A/B/C/D/0/E/F).
move_right(A/B/C/D/0/E/F, A/B/C/0/D/E/F).
move_right(A/B/C/0/D/E/F, A/B/0/C/D/E/F).
move_right(A/B/0/C/D/E/F, A/0/B/C/D/E/F).
move_right(A/0/B/C/D/E/F, 0/A/B/C/D/E/F).

hop_left_one(0/A/B/C/D/E/F, B/A/0/C/D/E/F).
hop_left_one(A/0/B/C/D/E/F, A/C/B/0/D/E/F).
hop_left_one(A/B/0/C/D/E/F, A/B/D/C/0/E/F).
hop_left_one(A/B/C/0/D/E/F, A/B/C/E/D/0/F).
hop_left_one(A/B/C/D/0/E/F, A/B/C/D/F/E/0).

hop_left_two(0/A/B/C/D/E/F, C/A/B/0/D/E/F).
hop_left_two(A/0/B/C/D/E/F, A/D/B/C/0/E/F).
hop_left_two(A/B/0/C/D/E/F, A/B/E/C/D/0/F).
hop_left_two(A/B/C/0/D/E/F, A/B/C/F/D/E,0).

hop_right_one(A/B/C/D/E/F/0, A/B/C/D/0/F/E).
hop_right_one(A/B/C/D/E/0/F, A/B/C/0/E/D/F).
hop_right_one(A/B/C/D/0/E/F, A/B/0/D/C/E/F).
hop_right_one(A/B/C/0/D/E/F, A/0/C/B/D/E/F).
hop_right_one(A/B/0/C/D/E/F, 0/B/A/C/D/E/F).

hop_right_two(A/B/C/D/E/F/0, A/B/C/0/E/F/D).
hop_right_two(A/B/C/D/E/0/F, A/B/0/D/E/C/F).
hop_right_two(A/B/C/D/0/E/F, A/0/C/D/B/E/F).
hop_right_two(A/B/C/0/D/E/F, 0/B/C/A/D/E/F).
   
move(P,C,move_left) 	:-  move_left(P,C).
move(P,C,move_right) 	:-  move_right(P,C).
move(P,C,hop_left_one) 	:-  hop_left_one(P,C).
move(P,C,hop_left_two) 	:-  hop_left_two(P,C).
move(P,C,hop_right_one) :-  hop_right_one(P,C).
move(P,C,hop_right_two) :-  hop_right_two(P,C).

% Heuristic function 
heuristic_fn(Puzz,H) :- eval_fn1(Puzz,H1),
 						eval_fn2(Puzz, H2), 
 						H is H2.

eval_fn2(A/_/_/_/_/_/_, H2) :- =(A,b), =(H2,3), !.
eval_fn2(A/B/_/_/_/_/_, H2) :- =(A,0), =(B,b), =(H2,3), !.

eval_fn2(A/B/_/_/_/_/_, H2) :- =(A,w), =(B,b), =(H2,2), !.
eval_fn2(A/B/C/_/_/_/_, H2) :- =(A,0), =(B,w), =(C,b), =(H2,2), !.
eval_fn2(A/B/C/_/_/_/_, H2) :- =(A,w), =(B,0), =(C,b), =(H2,2), !.

eval_fn2(A/B/C/D/_/_/_, H2) :- =(A,0), =(B,w), =(C,w), =(D,b), =(H2,1), !.
eval_fn2(A/B/C/D/_/_/_, H2) :- =(A,w), =(B,0), =(C,w), =(D,b), =(H2,1), !.
eval_fn2(A/B/C/D/_/_/_, H2) :- =(A,w), =(B,w), =(C,0), =(D,b), =(H2,1), !.
eval_fn2(A/B/C/_/_/_/_, H2) :- =(A,w), =(B,w), =(C,b), =(H2,1), !.
eval_fn2(_/_/_/_/_/_/_, 0) :- !.

eval_fn1(A/B/C/D/E/F/G, P) :- a(A,Pa), b(B,Pb), c(C,Pc),
							d(D,Pd), e(E,Pe), f(F,Pf), g(G,Pg),
							P is Pa+Pb+Pc+Pd+Pe+Pf+Pg.
a(_,0).
b(w,1). b(b,0). b(0,0).
c(w,2). c(b,0). c(0,0).
d(w,3). d(b,0). d(0,0).
e(w,4). e(b,0). e(0,0).
f(w,5). f(b,0). f(0,0).
g(w,6). g(b,0). g(0,0).

writelist([],_).
writelist([H|T],X) :- write(X), write('. '), write(H),nl, Y is +(X,1), writelist(T, Y).

solve(P) :- solve(P,S, X), writelist(S,1), !.


/*   
	A* Algorithm
	Nodes have the form :	S#D#F#A
				       		
				       		where S describes the state or configuration
							D is the depth of the node
                  			F is the evaluation function value
                  			A is the ancestor list for the node
*/

:- op(400,yfx,'#').    								% Node builder notation

solve(State,Soln, X) :- f_function(State,0,F),  		
                     search([State#0#F#[]],S, 0, X), 
                     reverse(S,Soln).

f_function(State,D,F) :- heuristic_fn(State,H),
                         F is D + H.

search([State#_#_#Soln|_], Soln, Y, P) :- goal(State), P is Y.

search([B|R],S, X, P) :-  Y is X+1, expand(B,Children),
                   insert_all(Children,R,Open),
                   search(Open,S, Y, P), !.

insert_all([F|R],Open1,Open3) :- insert(F,Open1,Open2),
                                 insert_all(R,Open2,Open3).
insert_all([],Open,Open).

insert(B,Open,Open) :- repeat_node(B,Open), ! .
insert(B,[C|R],[B,C|R]) :- cheaper(B,C), ! .
insert(B,[B1|R],[B1|S]) :- insert(B,R,S), !.
insert(B,[],[B]).

repeat_node(P#_#_#_, [P#_#_#_|_]).

cheaper( _#_#F1#_ , _#_#F2#_ ) :- F1 < F2.

expand(State#D#_#S,All_My_Children) :-
     bagof(Child#D1#F#[Move|S],
           (D1 is D+1,
             move(State,Child,Move),
             f_function(Child,D1,F)),
           All_My_Children).
