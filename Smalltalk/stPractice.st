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
Object subclass: #MyQueue1.
MyQueue1 instanceVariableNames: 'front back'.
MyQueue1 extend [ 
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

"Collection Queue: "
Collection subclass: #MyQueue2.
MyQueue2 instanceVariableNames: 'list'.
MyQueue2 extend [
	insert: Key [list addLast: Key ] 					"enqueue"
	remove [ list isEmpty ifTrue: [^nil] ifFalse: [^list removeFirst] ] 	"dequeue"
	display [list do: [:x | Transcript display: x; cr] ]
	init [list:= OrderedCollection new]

	do: aBlock [list do: aBlock ]
	collect: aBlock [
		| q |
		q:= MyQueue2 new.
		self do: [:key | q insert: (aBlock value: key)].
		^q
	]

	select: aBlock [
		| q |
		q:= MyQueue2 new.
		self do: [:key | (aBlock value: key) ifTrue: [q insert: key] ].
		^q
	]

	reject: aBlock [
		^self select: [:x | (aBlock value: x) not]
	]
]

MyQueue2 class extend [
	new [ ^super new init]
]

Object subclass: #MorseChar.
MorseChar instanceVariableNames: 'val'.
MorseChar extend [
	init: Key [
		(Key = 'A' or: [Key = 'a']) ifTrue: [val:= '.-'].
		(Key = 'B' or: [Key = 'b']) ifTrue: [val:= '-...'].
		(Key = 'C' or: [Key = 'c']) ifTrue: [val:= '-.-.'].
		(Key = 'D' or: [Key = 'd']) ifTrue: [val:= '-..'].
		(Key = 'E' or: [Key = 'e']) ifTrue: [val:= '.'].
		(Key = 'F' or: [Key = 'f']) ifTrue: [val:= '..-.'].
		(Key = 'G' or: [Key = 'g']) ifTrue: [val:= '--.'].
		(Key = 'H' or: [Key = 'h']) ifTrue: [val:= '....'].
		(Key = 'I' or: [Key = 'i']) ifTrue: [val:= '..'].
		(Key = 'J' or: [Key = 'j']) ifTrue: [val:= '.---'].
		(Key = 'K' or: [Key = 'k']) ifTrue: [val:= '-.-'].
		(Key = 'L' or: [Key = 'l']) ifTrue: [val:= '.-..'].
		(Key = 'M' or: [Key = 'm']) ifTrue: [val:= '--'].
		(Key = 'N' or: [Key = 'n']) ifTrue: [val:= '-.'].
		(Key = 'O' or: [Key = 'o']) ifTrue: [val:= '---'].
		(Key = 'P' or: [Key = 'p']) ifTrue: [val:= '.--.'].
		(Key = 'Q' or: [Key = 'q']) ifTrue: [val:= '--.-'].
		(Key = 'R' or: [Key = 'r']) ifTrue: [val:= '.-.'].
		(Key = 'S' or: [Key = 's']) ifTrue: [val:= '...'].
		(Key = 'T' or: [Key = 't']) ifTrue: [val:= '-'].
		(Key = 'U' or: [Key = 'u']) ifTrue: [val:= '..-'].
		(Key = 'V' or: [Key = 'v']) ifTrue: [val:= '...-'].
		(Key = 'W' or: [Key = 'w']) ifTrue: [val:= '.--'].
		(Key = 'X' or: [Key = 'x']) ifTrue: [val:= '-..-'].
		(Key = 'Y' or: [Key = 'y']) ifTrue: [val:= '-.--'].
	
		(Key = '0') ifTrue: [val:= '-----'].
		(Key = '1') ifTrue: [val:= '.----'].
		(Key = '2') ifTrue: [val:= '..---'].
		(Key = '3') ifTrue: [val:= '...--'].
		(Key = '4') ifTrue: [val:= '....-'].
		(Key = '5') ifTrue: [val:= '.....'].
		(Key = '6') ifTrue: [val:= '-....'].
		(Key = '7') ifTrue: [val:= '--...'].
		(Key = '8') ifTrue: [val:= '---..'].
		(Key = '9') ifTrue: [val:= '----.'].

		(Key = ' ') ifTrue: [val:= '    '].
		(Key = '.') ifTrue: [val:= '.-.-.-'].
		(Key = ',') ifTrue: [val:= '--.--'].
		(Key = '?') ifTrue: [val:= '..--..'].
		(Key = '!') ifTrue: [val:= '.----.'].
		
	]

	display [ Transcript display: val]
	
]

MorseChar class extend [
	new: Key [ ^super new init: Key]
]

Collection subclass: #MyMorse.
MyMorse instanceVariableNames: 'list'.
MyMorse extend [
	init: word [
		list:= OrderedCollection new. 
		word do: [:ch | self insert: ch. ]
	]

	insert: val [
		|m|
		m:= MorseChar new: val asString. 
		list addLast: m.
	]

	remove [list isEmpty ifTrue: [^nil] ifFalse: [^list removeFirst] ]
	display [list do: [:x | x display. Transcript show: '  '] ]

	do: aBlock [list do: aBlock ]

	collect: aBlock [
		| q |
		q:= MyMorse2 new.
		self do: [:key | q insert: (aBlock value: key)].
		^q
	]
]

MyMorse class extend [
	new: word [ ^super new init: word]
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

"BST: Contains BSTNode with Data,Left,Right"
Object subclass: #BSTNode.
BSTNode instanceVariableNames: 'data left right level'.
BSTNode extend [

	data [^data]
	left [^left]
	right [^right]
	level [^level]
	data: d [data:= d]
	left: l [left:= l]
	right: r [right:= r]
	level: l [level:= l]

	preorder [
		Transcript show: ' '. Transcript display: data.
		left notNil ifTrue: [ left preorder].
		right notNil ifTrue: [ right preorder].
	]

	inorder [
		left notNil ifTrue: [ left inorder].
		Transcript show: ' '. Transcript display: data.
		right notNil ifTrue: [ right inorder].
	]

	postorder [
		left notNil ifTrue: [ left postorder].
		right notNil ifTrue: [ right postorder].
		Transcript show: ' '. Transcript display: data.
	]

	levelorder: l [
		(level == l) ifTrue: [Transcript show: ' '. Transcript display: data].
		left notNil ifTrue: [ left levelorder: l].
		right notNil ifTrue: [ right levelorder: l].
	]
]

Object subclass: #BST.
BST instanceVariableNames: 'root height'.
BST extend [
	root [^root]
	root: r [root:= r]
	height [^height]
	height: h [height:= h]

	insert: Key [
		|n p l|
		l:= 1.
		n:= BSTNode new data: Key.
		p:= root.
		root isNil
			ifTrue: [n level: 1. root:= n. height:= l.]
			ifFalse: [ [n notNil] whileTrue:
						[(p data > Key)
						ifTrue: [(p left isNil)
								ifTrue: [l:= l + 1. n level: l. p left: n. n:= nil. (l > height) ifTrue: [ height:= l]. ]
								ifFalse: [l:= l + 1. p:= p left.]
							]
						ifFalse: [(p right isNil)
								ifTrue: [l:= l + 1. n level: l. p right: n. n:= nil. (l > height) ifTrue: [ height:= l]. ]
								ifFalse: [l:= l + 1. p:= p right.]
							].
						]
				]
	]

	remove: Key [
		|n p|
		n:= BSTNode new data: Key.
		p:= root.
		root isNil
			ifTrue: [root:= n.]
			ifFalse: [ [n notNil] whileTrue:
						[(p data > Key)
						ifTrue: [(p left isNil)
								ifTrue: [p left: n. n:= nil]
								ifFalse: [p:= p left].
							]
						ifFalse: [(p right isNil)
								ifTrue: [p right: n. n:= nil]
								ifFalse: [p:= p right].
							].
						]
				]
	]

	inorder[
		Transcript show: 'Inorder of Tree: '.
		root inorder.
		Transcript cr.
	]

	preorder [
		Transcript show: 'Preorder of Tree: '.
		root preorder.
		Transcript cr.
	]

	postorder [
		Transcript show: 'Postorder of Tree: '.
		root postorder.
		Transcript cr.
	]

	levelorder [ 
		|h|
		h:= height.
		Transcript show: 'Levelorder of Tree: '.
		Transcript cr.
		1 to: h do: [:x | Transcript show: 'Level '. Transcript display: x. Transcript show: ':'. root levelorder: x . Transcript cr.].
		Transcript cr.
	]

]

Object subclass: #MyMath.
MyMath instanceVariableNames: 'int1 int2'.
MyMath extend [

	int1 [^int1]
	int2 [^int2]
	int1: x [int1:= x]
	int2: x [int2:= x]
	
	sum [
		|x|
		x:= int1 + int2.
		Transcript display: x.
		[^x].
	]

	dif [
		|x|
		x:= int1 - int2.
		Transcript display: x.
		[^x].
	]

	product [
		|x|
		x:= int1 * int2.
		Transcript display: x.
		[^x].
	]
	
	quotient [
		|x|
		x:= int1 // int2.
		Transcript display: x.
		[^x].
	]

	remainder [
		|x|
		x:= int1 \\ int2.
		Transcript display: x.
		[^x].
	]

	pow [
		|p x|
		p:= int2 - 1.
		x:= int1.
		[p == 0] whileFalse: [x:= x*int1. p:= p-1].
		Transcript display: x.
		[^x].
		
		
	]

]

"'Main' Calls"

"
Transcript cr.
Transcript show: 'MorseChar'.
Transcript cr.
a:= MorseChar new: 'a'.
a display.
Transcript cr.

Transcript cr.
Transcript show: 'MorseWord: Lorem Ipsum'.
Transcript cr.
b:= MyMorse new: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam gravida auctor pulvinar. Integer erat odio, ultrices ut diam sit amet, porttitor pretium enim. Mauris a augue augue. Aenean viverra rhoncus enim a pulvinar. Nulla id sem justo. Suspendisse potenti. Duis eget enim in sem sodales fringilla id vitae nisi. Aenean tortor odio, posuere sit amet tincidunt eget, pretium sed felis. Phasellus enim mauris, laoreet non orci ut, efficitur dignissim nibh. In id aliquet tellus. Sed a tincidunt augue. Pellentesque eu dignissim metus. Mauris venenatis pulvinar enim vitae rhoncus.'.
b display.
Transcript cr.


Transcript cr.
Transcript show: 'MyQueue2:'.
Transcript cr.
q:= MyQueue2 new.
q insert: 20; insert: 40; insert: 60; insert: 80.
5 timesRepeat: [Transcript display: q remove; cr].
Transcript cr.

Transcript cr.
Transcript show: 'Mapping x*x to queue:'.
Transcript cr.
q insert: 20; insert: 40; insert: 60; insert: 80.
r:= q collect: [:x | x*x].
r do: [:x | Transcript display: x; cr].
Transcript cr.

Transcript cr.
Transcript show: 'Selecting only x>15 and x<35'.
Transcript cr.
f:= q select: [:x | x>15 and: [x<35] ].
f do: [:x | Transcript display: x; cr].
Transcript cr.


Transcript cr.
Transcript show: 'Rejecting anything not x>15 and x<35'.
Transcript cr.
r:= q reject: [:x | x>15 and: [x<35] ].
r do: [:x | Transcript display: x; cr].
Transcript cr.

Transcript cr.
Transcript show: 'Injecting a+b (similiar to foldl) into MyQueue2'.
Transcript cr.
Transcript display: (q inject: 0 into: [:a :b | a+b]); cr.
Transcript cr.

Transcript cr.
Transcript show: 'Injecting a*b (similiar to foldl) into MyQueue2'.
Transcript cr.
Transcript display: (q inject: 1 into: [:a :b | a*b]); cr.
Transcript cr.

Transcript cr.
Transcript show: 'Detecting x < 15 (find first in list) in MyQueue2 if not 99'.
Transcript cr.
Transcript display: (q detect: [:x | x < 15] ifNone: [99]); cr.
Transcript cr.

Transcript cr.
Transcript show: 'Detecting x > 25 (find first in list) in MyQueue2 if not 99'.
Transcript cr.
Transcript display: (q detect: [:x | x > 25] ifNone: [99]); cr.
Transcript cr.

Transcript cr.
Transcript show: 'Detecting x > 50 (find first in list) in MyQueue2 if not 99'.
Transcript cr.
Transcript display: (q detect: [:x | x > 50] ifNone: [99]); cr.
Transcript cr.

Transcript show: 'MyQueue1:'.
Transcript cr.
q:= MyQueue1 new.
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

Transcript show: 'BST:'.
Transcript cr.
t:= BST new.
t insert: 5; insert: 10; insert: 18; insert: 7; insert: 20; insert: 15.
t preorder.
t inorder.
t postorder.
t levelorder.

Transcript show: 'MyMath:'.
Transcript cr.
a:= 46.
b:= 4.
m:= MyMath new int1: a; int2: b.
Transcript display: a. Transcript show: ' + '. Transcript display: b. Transcript show: ' = '.
x:= m sum.
Transcript cr.
Transcript display: a. Transcript show: ' - '. Transcript display: b. Transcript show: ' = '.
x:= m dif.
Transcript cr.
Transcript display: a. Transcript show: ' * '. Transcript display: b. Transcript show: ' = '.
x:= m product.
Transcript cr.
Transcript display: a. Transcript show: ' / '. Transcript display: b. Transcript show: ' = '.
x:= m quotient.
Transcript cr.
Transcript display: a. Transcript show: ' % '. Transcript display: b. Transcript show: ' = '.
x:= m remainder.
Transcript cr.
Transcript display: a. Transcript show: ' ^ '. Transcript display: b. Transcript show: ' = '.
x:= m pow.
Transcript cr.
"

Transcript cr.
Transcript show: 'Generated Lists: '.
Transcript cr.
col:= ((1 to: 25) select: [:x| (x*x) > 3]) collect: [:x | (x*2)].
col2:= ((1 to: 25) select: [:x| (x*x) > 3]) collect: [:x | (x*3)].
Transcript display: col.
Transcript cr.
Transcript cr.
Transcript display: col2.
Transcript cr.

Transcript cr.
Transcript show: 'Inspecting Generated List '.
Transcript cr.
col inspect.
Transcript cr.

Transcript cr.
Transcript show: 'Detecting Generated List with invalid boolean'.
Transcript cr.
col detect: [:x | x<0 ] ifNone: [Transcript show: 'None detected'].
Transcript cr.
Transcript cr.
Transcript show: 'Detecting Generated List with valid boolean'.
Transcript cr.
c:= col detect: [:x | x>10 ] ifNone: [Transcript show: 'None detected'].
Transcript display: c.
Transcript cr.
 
Transcript cr.
Transcript show: 'Collecting Generated List x*x'.
Transcript cr.
d:= col collect: [:x | x*x].
Transcript display: d.
Transcript cr.

Transcript cr.
Transcript show: 'Selecting Generated List x % 3 = 0 (This is \\ in smalltalk)'.
Transcript cr.
e:= col select: [:x | x \\ 3 = 0 ].
Transcript display: e.
Transcript cr.

Transcript cr.
Transcript show: 'Rejecting Generated List x % 3 = 0 (This is \\ in smalltalk)'.
Transcript cr.
f:= col reject: [:x | x \\ 3 = 0 ].
Transcript display: f.
Transcript cr.


Transcript cr.
Transcript show: 'Collecting col2 if in col '.
Transcript cr.
g:= col select: [:x | col2 includes: x].
Transcript display: g.
Transcript cr.

Transcript cr.
Transcript show: 'Injecting Generated List with a+b: '.
Transcript cr.
Transcript display: (col inject: 0 into: [:a :b | a+b]); cr.
Transcript cr.

