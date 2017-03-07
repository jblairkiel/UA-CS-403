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

/*sum2([2,3,4,5],R).*/
sum2([],0).
sum2([H|T],R):- number(H), sum2(T,S), R is H+S.

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
delete2(H, [H|T], T).
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
