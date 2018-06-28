predicates
  male(String)
  female(String)
  place(String)  
  pair(String,String)
  
  cond1(String, String)
  cond2(String, String)
  cond3(String, String)
  cond4(String, String)
  cond5_(String, String, String)
  
  solution(String,String,String,String,
  	String,String,String,String,
  	String,String,String,String)
  	
  print
clauses
  male(M):- M = "Andr"; M = "Bel";
 	 M ="Cha"; M = "Der".
  female(F):- F = "Olg"; F ="Roz";
  	F = "Pan"; F = "Sha". 
  place(P):- P = "concert"; P = "show";
  	P = "theather"; P = "movie".
  cond1(M, P):-M="Andr", P="concert".
  cond2(M, F):-M="Bel", F="Olg".
  cond3(M, F):-M="Cha", not(F="Roz").
  cond4(F, P):-F="Pan", P="movie".
  cond5_(M, F, P):-not(M="Cha"), F="Roz",
  	P="theather".
  
  pair(M, F):-male(M), female(F).
  solution(M1,F1,P1,
  	M2,F2,P2,
  	M3,F3,P3,
  	M4,F4,P4):-
  place(P1), place(P2),
  place(P3), place(P4),
  P1<>P2, P1<>P3, P1<>P4,
  P2<>P3, P2<>P4, P3<>P4,
  pair(M1, F1),pair(M2, F2),
  pair(M3, F3),pair(M4, F4),
  M1<>M2, M1<>M3, M1<>M4,
  M2<>M3, M2<>M4, M3<>M4,
  F1<>F2, F1<>F3, F1<>F4,
  cond1(M1, P1), cond2(M2,F2), 
  cond4(F3, P3), cond5_(M4, F4, P4).
  print:-solution(M1,F1,P1,M2,F2,P2,M3,F3,P3,
  	M4,F4,P4),
  write("**** Solution ****"), nl,
  write(M1, " & ", F1, " visited ", P1),nl,
  write(M2, " & ", F2, " visited ", P2), nl,
  write(M3, " & ", F3, " visited ", P3), nl,
  write(M4, " & ", F4, " visited ", P4), nl, fail.
goal
  print.
