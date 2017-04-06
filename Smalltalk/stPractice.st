"GNU Small Talk Exam 4"


"Standard Node for Data Structures"
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

"Standard Queue: FIFO enqueue to back, dequeue front"
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
	remove [
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


"Standard Stack: FILO push to top, pop from top"
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
	
	remove [
		|Key|
		back isNil ifTrue: [^nil].
		Key:= back data.
		back:= back prev.
		back next: nil.
		^Key
	]

	display [
		|p|
		p:= front.
		[p notNil] whileTrue: [Transcript display: p data. Transcript show: '=>'. p:= p next].
		Transcript cr.
	]

]

"Deck Stack: push to top, popTop from top, popBottom from bottom"
Object subclass: #MyDeck.
MyDeck instanceVariableNames: 'top bottom count'.
MyDeck extend [
	top [^top]
	bottom [^bottom]
	count [Transcript show: 'Deck count is: '. Transcript display: count. Transcript cr]
	top: t [top:= t]
	bottom: b [bottom:= b]
	count: c [count:= c]

	push: Key [
		|p|
		p:= MyNode new data: Key.
		top isNil
			ifTrue: [bottom:= p. top:= p. count:= 1]
			ifFalse: [p prev: top. top next: p. top:= p. count:= count + 1].
	]
	
	popTop [
		|Key|
		top isNil ifTrue: [^nil].
		Key:= top data.
		top:= top prev.
		top next: nil.
		count:= count - 1.
		Transcript show: 'Popping Top: '. 
		Transcript display: Key.
		Transcript cr.
		^Key.
	]

	popBottom [ 
		|Key|
		bottom isNil ifTrue: [^nil].
		Key:= bottom data.
		bottom:= bottom next.
		bottom prev: nil.
		count:= count - 1.
		Transcript show: 'Popping Bottom: '. 
		Transcript display: Key.
		Transcript cr.
		^Key.
	]	

	display [
		|p|
		p:= bottom.
		[p notNil] whileTrue: [Transcript display: p data. Transcript show: '=>'. p:= p next].
		Transcript cr.
	]
	
]

"'Main' Calls"
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

Transcript show: 'Deck:'.
Transcript cr.
d:= MyDeck new.
d count.
d push: 5; push: 10; push: 15; push: 20.
d count.
d display.
d popTop.
d display.
d popBottom.
d display.
Transcript cr.

