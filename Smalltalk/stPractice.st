"GNU Small Talk Exam 4"

Object subclass: #MyNode.
MyNode instanceVariableNames: 'data next prev'.
MyNode extend [
	data [^data]
	next [^next]
	prev [^prev]
	data: d [data:= d]
	next: n [next:= n]
	prev: p [prev:= p]
	display [Transcript display: data; cr.]
]

Object subclass: #MyQueue.
MyQueue instanceVariableNames: 'front back'.
MyQueue extend [ 
	front [^front]
	back [^back]
	front: f [front:= f]
	back: b [back:= b]

	insert: Key [
		|p|
		p:= MyNode new data: Key.
		front isNil
			ifTrue: [front:= p. back:= p]
			ifFalse: [back next: p. back:= p]
	]
	remove[
		|Key|
		front isNil ifTrue: [^nil].
		Key:= front data.
		front:= front next.
		^Key
	]
	
	display [
		|p|
		p:= front.
		[p notNil] whileTrue: [Transcript display: p data. Transcript show: '=>'. p:= p next].
		Transcript cr.
	]
]


Object subclass: #MyStack.
MyStack instanceVariableNames: 'front back'.
MyStack extend [
	front [^front]
	back [^back]
	front: f [front:= f]
	back: b [back:= b]

	insert: Key [
		|p|
		p:= MyNode new data: Key.
		front isNil
			ifTrue: [front:= p. p prev: p. back:= p]
			ifFalse: [p prev: back. back next: p. back:= p]
	]
	
	remove[
		|Key|
		back isNil ifTrue: [^nil].
		Key:= back data.
		back:= back prev.
		back next: nil.
		^Key
	]

	display[
		|p|
		p:= front.
		[p notNil] whileTrue: [Transcript display: p data. Transcript show: '=>'. p:= p next].
		Transcript cr.
	]

]


Transcript show: 'Queue:'.
Transcript cr.
q:= MyQueue new.
q insert: 20; insert: 40; insert: 60; insert: 80.
q display.
q remove.
q display.
Transcript cr.

Transcript show: 'Stack:'.
Transcript cr.
s:= MyStack new.
s insert: 10; insert: 30; insert: 50; insert: 70.
s display.
s remove.
s display.
Transcript cr.

