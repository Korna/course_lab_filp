domains
  cl=char*
predicates
  make(cl, cl, cl)
clauses
  make([], L, L).
  make(L, [], L).
  make([H1|T1],[H2|T2],[H1,H2|R]):-make(T1, T2, R).
goal
  make(['a'], ['1'], V1), write(V1), nl,	
  make(['a', 'b'], ['1'], V2), write(V2), nl,
  make(['a', 'b', 'c'], ['1', '2', '3'], V3), write(V3), !.
