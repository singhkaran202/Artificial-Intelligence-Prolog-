/* Helper functions for list operations */
writenlist([]):- nl.
writenlist([H|T]):- write(H), write(' '), writenlist(T).

reverse_writenllist([]).
reverse_writenllist([H|T]):- reverse_writenllist(T), write(H), nl.

member(X,[X|_]).
member(X,[_|T]):- member(X,T).
/*Here, I took east and west only for depicting the two directions*/
/* Change bank from east to west and vice versa */
opposite(e,w).
opposite(w,e).

/* Define weights */
weight(man, 80).
weight(woman, 80).
weight(child, 30).

/* Check if a move is valid (total weight <= 100) */
valid_move(People) :-
    findall(W, (member(P, People), weight(P, W)), Weights),
    sum_list(Weights, Total),
    Total =< 100.

/* Define possible moves */
move(state(X, Man, Woman, [C1, C2]), state(Y, Man, Woman, [C1, C2])) :-
    opposite(X, Y),
    valid_move([]),
    writenlist(['Try empty boat ', Y, Man, Woman, [C1, C2]]).

move(state(X, X, Woman, [C1, C2]), state(Y, Y, Woman, [C1, C2])) :-
    opposite(X, Y),
    valid_move([man]),
    writenlist(['Try man crosses ', Y, Y, Woman, [C1, C2]]).

move(state(X, Man, X, [C1, C2]), state(Y, Man, Y, [C1, C2])) :-
    opposite(X, Y),
    valid_move([woman]),
    writenlist(['Try woman crosses ', Y, Man, Y, [C1, C2]]).

move(state(X, Man, Woman, [X, C2]), state(Y, Man, Woman, [Y, C2])) :-
    opposite(X, Y),
    valid_move([child]),
    writenlist(['Try child 1 crosses ', Y, Man, Woman, [Y, C2]]).

move(state(X, Man, Woman, [C1, X]), state(Y, Man, Woman, [C1, Y])) :-
    opposite(X, Y),
    valid_move([child]),
    writenlist(['Try child 2 crosses ', Y, Man, Woman, [C1, Y]]).

move(state(X, X, X, [C1, C2]), state(Y, Y, Y, [C1, C2])) :-
    opposite(X, Y),
    valid_move([man, woman]),
    writenlist(['Try man and woman cross ', Y, Y, Y, [C1, C2]]).

move(state(X, X, Woman, [X, C2]), state(Y, Y, Woman, [Y, C2])) :-
    opposite(X, Y),
    valid_move([man, child]),
    writenlist(['Try man and child 1 cross ', Y, Y, Woman, [Y, C2]]).

move(state(X, X, Woman, [C1, X]), state(Y, Y, Woman, [C1, Y])) :-
    opposite(X, Y),
    valid_move([man, child]),
    writenlist(['Try man and child 2 cross ', Y, Y, Woman, [C1, Y]]).

move(state(X, Man, X, [X, C2]), state(Y, Man, Y, [Y, C2])) :-
    opposite(X, Y),
    valid_move([woman, child]),
    writenlist(['Try woman and child 1 cross ', Y, Man, Y, [Y, C2]]).

move(state(X, Man, X, [C1, X]), state(Y, Man, Y, [C1, Y])) :-
    opposite(X, Y),
    valid_move([woman, child]),
    writenlist(['Try woman and child 2 cross ', Y, Man, Y, [C1, Y]]).

move(state(X, Man, Woman, [X, X]), state(Y, Man, Woman, [Y, Y])) :-
    opposite(X, Y),
    valid_move([child, child]),
    writenlist(['Try both children cross ', Y, Man, Woman, [Y, Y]]).

/* Backtrack if no valid move */
move(State, State) :-
    writenlist([' Backtrack from: ', State]),
    fail.

/* Path finding */
path(Goal, Goal, List) :-
    write('Solution Path is: '), nl,
    reverse_writenllist(List).

path(State, Goal, List) :-
    move(State, NextState),
    not(member(NextState, List)),
    path(NextState, Goal, [NextState|List]),
    !.

/* Run the program */
:- path(state(e,e,e,[e,e]), state(w,w,w,[w,w]), [state(e,e,e,[e,e])]), halt(0).