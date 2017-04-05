/*
	Prolog Practice
	2-27-16
*/

/*Family Tree*/
:- discontiguous(male/1). 
:- discontiguous(female/1).
:- discontiguous(parent/2).
:- discontiguous(sibling/2).

male(greg).
male(blair).
male(brock).
male(donald).
male(jeremy).
male(harold).
male(hal).
male(hayden).

female(kim).
female(molly).
female(shirlene).
female(gay).
female(kimberly).
female(halley).

parent(greg, blair).
parent(kim, blair).
sibling(brock, blair).
sibling(molly, blair).

parent(donald, greg).
parent(shirlene, greg).
sibling(greg, jeremy).

parent(harold, kim).
parent(gay, kim).
sibling(kim, hal).

parent(hal, halley).
parent(kimberly, hayden).
sibling(halley, hayden).

father(Father,Child) :- male(Father),parent(Father,Child).
mother(Mother,Child) :- female(Mother),parent(Mother,Child).
sibling(Kid1,Kid2) :- parent(Parent, Kid1),parent(Parent, Kid2), Kid1 \= Kid2.
brother(Brother,Sibling) :- male(Brother),sibling(Brother,Sibling).
sister(Sister,Sibling) :- female(Sister),sibling(Sister,Sibling).

/***********/
/*Functions*/
/***********/

/*genList2(N,R).*/
genList2(0,[]):- !.
genList2(N,R):- N>0, N1 is N-1, random(1,100,U), R=[U|T], genList2(N1,T).

/*l1(genList2(100),R).*/


/*sum2([2,3,4,5],R).*/
sum2([],0).
sum2([H|T],R):- number(H), sum2(T,S), R is H+S.

/*products([2,3,4,5],R)*/
products([],0):- !.
products([H|[]],R):- R is H, !.
products([H|T],R):- number(H), products(T,S), R is H*S.

/*not(x).*/
not2(X):- \+X.

/*len([a,b,c,d],X).*/
len([], 0).
len([_|T], N):- len(T, M), N is M+1.

/*member2(c, [a,b,c,d]).*/
member2(H, [H|_]).
member2(X, [_|T]):- member2(X,T).

/*append2([a,b,c], [1,2,3], L)*/
append2([], L, L).
/*append2([X|Y],[H|[]],[X|[Y|H]]):- !.*/
append2([H|T],L2,[H|L3]):- append2(T,L2,L3).

/*last2([a,b,c,d,e,f],X).*/
last2([X], X):- !.
last2([_,Y|T],Z):- last2([Y|T], Z).

/*reverse2([a,b,c,d],X).*/
reverse2(L,R):- revhelper(L,[],R).

revhelper([],R,R).
revhelper([H|T], X, R):- revhelper(T, [H|X], R).

/*flatten2([a,b,[c,d],e,[f,g]],X).*/
flatten2([],[]):- !.
flatten2([H|T],X):- flatten(H, A), flatten(T,B), append2(A,B,X).

/*ascend2([1,2,3]).*/
ascend2([]).
ascend2([_]):-!.
ascend2([X,Y|T]):- X=<Y, ascend2([Y|T]).

/*delete2(3,[1,2,3],L).*/
delete2(H, [H|T], T):-!.
delete2(X, [H|T], [H|Z]):- delete2(X,T,Z).

/*permute2([a,b,c],R).*/
permute2([],[]).
permute2(L,[H|T]):- member2(H,L), delete2(H,L,Y), permute2(Y,T).

/*combinations2(As,Bs).*/
combinations2(InList,Out) :-
    splitSet(InList,_,SubList),
    SubList = [_|_],     /* disallow empty list */
    permute(SubList,Out).

splitSet([ ],[ ],[ ]).
splitSet([H|T],[H|L],R) :-
    splitSet(T,L,R).
splitSet([H|T],L,[H|R]) :-
    splitSet(T,L,R).

permute([ ],[ ]) :- !.
permute(L,[X|R]) :-
    omit(X,L,M),
    permute(M,R).

omit(H,[H|T],T).
omit(X,[H|L],[H|R]) :-
    omit(X,L,R).



/*sort1(L,R)*/
sort1(L,X):- permute2(L,X), ascend2(X), !.

/*power2(M,N,R)*/
power2(_,0,1).
power2(M,1,M):-!.
power2(M,N,R):- Q is N-1, power2(M,Q,Z), R is M*Z.

/*log2(M,Q,N)*/
log2(M,Q,1):- M=<Q, !.
log2(M,Q,N):- M>Q, Z is M/Q, log2(Z,Q,T), N is 1+T.

/*insertionsort2(L, R)*/
insertionsort2([], []):- !.
insertionsort2([X|L], S):- insertionsort2(L, S1), insert2(X, S1, S).

insertionsort3(N,S):- genList2(N,R), insertionsort2(R,S).

/*insert2(x,L,R)*/
insert2(X, [], [X]):- !.
insert2(X, [X1|L1], [X, X1|L1]):- X=<X1, !.
insert2(X, [X1|L1], [X1|L]):- insert2(X, L1, L).

/*selectionsort2(L,R)*/
selectionsort2([], []):- !.
selectionsort2([X|[]], X):- !.
selectionsort2([X|L], S):- largest2([X|L],S1), delete2(S1,[X|L],D), selectionsort2(D, A), insert2(S1, A, Z), S is Z.

selectionsort3(N,S):- genList2(N,R), selectionsort2(R,S).

/*largest2(L,R)*/
largest2([],[]).
largest2(X,X):- !.
largest2([X|[]],X):- !.
largest2([X,Y|T], R):- X>=Y, largest2([X|T],R); X<Y, largest2([Y|T],R).


/*smallest2(L,R)*/
smallest2([],[]).
smallest2([X|[]],X):- !.
smallest2([X,Y|T], R):- X=<Y, smallest2([X|T],R); X>Y, smallest([Y|T],R).

/*quicksort2(L,R)*/
quicksort2([],[]):- !.
quicksort2([X|T],S):- split2(X,T,Y,Z), quicksort2(Y,R1), quicksort2(Z,R2), append(R1,[X|R2],S).

quicksort3(X,S):- genList2(X,R), quicksort2(R,S).

/*quicksort2([X|[]],[X|[]]):- !.*/

split2(_X,[],[],[]).
split2(X,[Y|T],[Y|S],B):- X>=Y, split2(X,T,S,B), !.
split2(X,[Y|T],S,[Y|B]):- X<Y, split2(X,T,S,B), !.

/*fib1(N,R)*/
/*Will crash quickly due to overflow*/
fib1(0,0):- !.
fib1(1,1):- !.
fib1(X,Y):- 
	X>1, 
	X2 is X-2, fib1(X2,Y2),
	X1 is X-1, fib1(X1,Y1),
	Y is Y1 + Y2.

fibseq1(A,B,[]):- A>B, !.
fibseq1(A,B,[H|T]):-
	A=<B,
	fib1(A,H),
	AA is A + 1,
	fibseq1(AA,B,T).

/*fib2(N,R)*/
/*More tolerant to overflow*/
fib2(0,0):- !.
fib2(X,Y):- X>0, fib2(X,Y,_).

fib2(1,1,0):- !.
fib2(X,Y1,Y2) :-
	X>1,
	X1 is X-1,
	fib2(X1,Y2,Y3),
	Y1 is Y2+Y3.

fibseq2(A,B,[]):- A>B, !.
fibseq2(A,B,[H|T]):-
	A=<B,
	fib2(A,H),
	AA is A + 1,
	fibseq2(AA,B,T).

/*fact(N)*/
fact1(0,[1]):- !.
fact1(1,[1]):- !.
fact1(N,L):- N1 is N-1, fact1(N1,S), L is N*S.

/*tree2*/
root2([X,_Y,_Z],X):- !.
left_sub([_X,Y,_Z],Y):- !.
left_sub([_X|[]],[]):- !.
right_sub([_X,_Y,Z],Z):- !.
right_sub([_X|[]]):- !.

/*member3(X,T)*/
/*member3(_,[]):- false.*/
member3(X,X):- !.
member3(X,[X,_,_]):- !. 
member3(X,[K,L,_]):- X=<K, member3(X,L), !.
member3(X,[K,_,R]):- X>K, member3(X,R), !.

/*insertTree2(X,T)*/

insertTree2(X, [], [X, [], []]).
insertTree2(X, [K,L,R], [K,NL,R]) :- X=<K, insertTree2(X,L,NL).
insertTree2(X, [K,L,R], [K,L,NR]) :- X>K, insertTree2(X,R,NR).

/*twist([],[]):- !.*/
twist(L,R):- twisthelper(L,[],R).

twisthelper([],A,A):- !.
twisthelper([H|T],A,R):- is_list(H), twisthelper(H,[],X), twisthelper(T,[X|A],R), !; not2(is_list(H)), twisthelper(T,[H|A],R), !.

/*countall([H|T],R)*/
countall(L,R):- countallHelper(L,R).

countallHelper([],0).
countallHelper([H|T],R):- is_list(H), countall(H,X), countallHelper(T,Y), R is X+Y, !; not2(is_list(H)), countallHelper(T,Y), R is Y+1, !.

/*maketree(L,T)*/
maketree([],[]):- !.
maketree([H|T],Tree):- maketree(T,X), insertTree3(H,X,Tree), !.

insertTree3(H,[],[H,[],[]]):- !.
insertTree3(H,[Root,Left,Right],[Root,NewLeft,Right]):- H=<Root, insertTree3(H,Left,NewLeft).
insertTree3(H,[Root,Left,Right],[Root,Left,NewRight]):- H>Root, insertTree3(H,Right,NewRight).

inorder([],[]):- !.
inorder([Root,Left,Right],L):- inorder(Left,X),inorder(Right,Y), append(X,[Root|Y], L).

preorder([],[]):- !.
preorder([Root,Left,Right],L):- preorder(Left,X), preorder(Right,Y), append([Root|Y],X,L).

printTree1(N,Q):- genList2(N,R), maketree(R,S), inorder(S,Q).
printTree2(N,Q):- genList2(N,R), maketree(R,S), preorder(S,Q).

/*inner(X,Y,Z)*/
inner([],[],0):- !.
inner([X|T1],[Y|T2],Z):- R is X*Y, inner(T1,T2,S), Z is R+S.

/*prime(N)*/
prime(N):- N1 is N-1, primeHelper(N,N1,2).

primeHelper(_,1,_).
primeHelper(N,N1,Z):- N1>=Z, R is N mod N1, not2(R==0), Q is N1-1, primeHelper(N,Q,2).

/*sublistSum(L,N,S)*/
sublistSum(L,N,S):- combinations2(L,S), isSum(S,N).

isSum([],0):- !.
isSum([H|T],N):- R is N-H, isSum(T,R).

/*disjoint(X,Y)*/
disjoint([],[_Y|_T2]):- !.
disjoint([X|T1],[Y|T2]):- notInHelper(X,[Y|T2]), disjoint(T1,[Y|T2]).

notInHelper(_X,[]):- !.
notInHelper(X,[Y|T2]):- not2(X==Y), notInHelper(X,T2).

/*diagonal(M,D)*/
diagonal([],[]).
diagonal([X|T1],D):- N is 1, diagonalHelper1(X,N,R), diagonalHelper2(T1,N,Q), append(R,Q,D).

/*indexof*/
diagonalHelper1([],_,[]):- !.
diagonalHelper1([X|_],1,[X]):- !.
diagonalHelper1([_X|T],N,R):- N1 is N-1, diagonalHelper1(T,N1,R).

diagonalHelper2([],_,[]).
diagonalHelper2([X|T1],N,D):-N1 is N+1, diagonalHelper1(X,N1,R), diagonalHelper2(T1,N1,Q), append(R,Q,D).
