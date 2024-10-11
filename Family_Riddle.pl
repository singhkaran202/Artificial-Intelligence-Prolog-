% Define the basic relationships
father(father_of_speaker, speaker).
father(speaker, that_man).

% Define rules
son(X, Y) :- father(Y, X).
male(father_of_speaker).
male(speaker).
male(that_man).

% The riddle condition: speaker has no siblings
no_siblings(X) :-
    father(F, X),
    \+ (father(F, Y), Y \= X).

% The riddle solution
solve_riddle(Person) :-
    no_siblings(speaker),
    father(F, speaker),
    son(speaker, F),  % "my father's son" is the speaker
    father(speaker, Person).  % "that man" is the son of the speaker

% Query to solve the riddle
?- solve_riddle(X).