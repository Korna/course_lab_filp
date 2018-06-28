domains
i=integer
s=symbol
list=s*
  database
db_path(s,s,list,i)
mode(i)
  predicates
path(s,s,list,i)
path1(s,list,i,list,i)
member(s,list)
way(s,s,i)
db0(s,s)
db(s,s)
run(s,s)
%add(i,i,i)
incr(i,i,i,i)
start
  goal
start.
  clauses
start:-
%makewindow(1,7,7,"Expert System",1,3,22,71),
clearwindow,
write("Enter mode: "), 
readchar(C), 
assert(mode(C)),
write(C), nl,
write("First point: "), readln(First),nl,
write("Second point: "), readln(Second),nl,
run(First,Second),readchar(_).

way(a1,a2,1).
way(a2,a3,1).
way(a3,a4,1).
way(a4,a5,1).
way(a5,a6,1).

way(a1, b1, 100).
way(b1, a1, 100).
way(b3, a6, 100).
way(a6, b3, 100).
way(a3, c2, 100).
way(c2, a3, 100).
way(b2, c3, 100).
way(c3, b2, 100).

way(b1,b2,1).
way(b2,b3,1).

way(c1,c2,1).
way(c2,c3,1).
way(c3,c4,1).

incr(O, L, S, 48):- S = O + L. 
	%write("O+L=", S), nl.
	%,assert(sum(S))
incr(O, L, S, 49):- S = O + 1, L = L. 
	%write("O+1=", S), nl
	%,assert(sum(S))
	
run(Start,End):-db0(Start,End), db(Start,End),
 db_path(Start,End,MP,MD),
nl, write("Way: "),write(MP),nl,
mode(M), retract(mode(M)),
db_path(X1,Y1,P1,C1), retract(db_path(X1,Y1,P1,C1)),
%write("Length of path is:"),write(MD),
nl.
path(A,Z,Path,C):- path1(A,[Z],0,Path,C).

path1(A,[A|Path1],C,[A|Path1],C).
path1(A,[Y|Path1],O,Path,C):-
	way(X,Y, L),
	not(member(X,Path1)), mode(M), 
	write(M),
	%clearwindow,
	incr(O, L, S3, M),
	path1(A,[X,Y|Path1],S3,Path,C).

member(Head,[Head|_]).
member(Head,[_|Tail]):- member(Head,Tail).

db0(X,Y) :-path(X,Y,P,C), assert(db_path(X,Y,P,C)).

db(X,Y):-db_path(X,Y,P,C), path(X,Y,MP,MC), MC<C,!,
retract(db_path(X,Y,P,C)), 
assert(db_path(X,Y,MP,MC)), db(X,Y).
db(_,_).
