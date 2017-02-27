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

