:- module(find).
:- export(sentence/3).


sentence(�����������(S,V, V2)) --> {write("������� ������ ������"), nl},
 		sentence_(�����������(S,V, V2)).

sentence_(�����������(S,V, V2)) --> subject(S), verb(V);
				subject(S), fpart(V), mpart(V2);
				subject(S), hpart(V), mpart(V2);
				subject(S), rverb(V).

subject(����������(M,N)) --> modifier(M),  noun(N);
					noun(N).

rverb(���������(M, N)) --> modifier2(M),  verb(N).

modifier(���������������(��)) --> [��].
modifier(���������������(���)) --> [���].
modifier(���������������(������)) --> [������].
modifier(���������������(������)) --> [������].
modifier(���������������(��������)) --> [��������].

noun(���������������(������)) --> [������].
noun(���������������(�������)) --> [�������].
noun(�����������(��)) --> [��].
noun(�����������(���)) --> [���].
noun(���������������(�������)) --> [�������].

fpart(���������������2(F1, F2))--> modifier2(F1), hpart(F2).
modifier2(���������������2(������)) --> [������].
modifier2(���������������2(�����������)) --> [�����������].
modifier2(���������������2(������)) --> [������].
verb(������(����)) --> [����].
verb(������(�����)) --> [�����].
verb(������(���������)) --> [���������].
verb(������(������)) --> [������].
verb(������(��������)) --> [��������].

%cverb(���������(s1, s2)) --> hpart(s1), mpart(s2).
%comp_verb(wtf(w1, w2)) --> hpart(w1), mpart(w2).



hpart(����������(�����)) --> [�����].
hpart(����������(������)) --> [������].
hpart(����������(�����)) --> [�����].
hpart(����������(���)) --> [���].
hpart(����������(���)) --> [���].
hpart(����������(�����)) --> [�����].

mpart(���������(������)) --> [������].
mpart(���������(���������)) --> [���������].
mpart(���������(����������)) --> [����������].
mpart(���������(���������)) --> [���������].
mpart(���������(����������)) --> [����������].
mpart(���������(��������)) --> [��������].

:- end_module(find)
