;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\Variables\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

; Prints a list of length(x), bounded randomly from (0 to x)
; (randomlist 3)
; (cons (2) (randomlist 2))
; (cons (2) (cons (0) (randomlist 1)))
; (cons (2) (cons (0) (cons (1) '())))
; '( 2 0 1)
( define (randomList x)

	(if (= x 0)
		'()
		(cons (random x) (randomList (- x 1)))
	)
)

; Returns a list of the even numbers in a list
; (printEvens '(4 10 3 5))
; (cons 4 (printEvens '(10 3 5)))
; (cons 4 (cons 10 (printEvens '(3 5))))
; (cons 4 (cons 10 (printEvens '(5))))
; (cons 4 (cons 10 (printEvens '())))
; (cons 4 (cons 10 '()))
; '(4 10)
( define (printEvens L)
	(if (null? L)
		'()	
		(if (= 0 (modulo (car L) 2))
			(cons (car L) (printEvens (cdr L)) )
			(printEvens (cdr L))
		)
	)
)

;Returns a list of the odd numbers in a list
; (printOdds '(3 6 10 1))
; (cons 3 (printOdds '(6 10 1)))
; (cons 3 (printOdds '(10 1)))
; (cons 3 (printOdds '(1)))
; (cons 3 (cons 1 (printOdds '())))
; (cons 3 (cons 1 '()))
; '(3 1)
( define (printOdds L)
	(if (null? L)
		'()
		(if (= 0 (modulo (car L) 2))
			(printOdds (cdr L))	
			(cons (car L) (printOdds (cdr L)) )
		)
	)

)

;Returns the maximum value of a list of numbers
; (maxList '(1 2 3 4 5 6 7 8 9 10)
; 10
( define (maxList L)
	(apply max L)
)

( define L (cons 5 (cons 4 (cons 3 ()))) )
( define L2 (append (map square L) L ))
( define L3 (append (map square L2) L2 ))
( define L4 (randomList 100))

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\BEGIN EXCERSISES\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

;\\Problems
;#1 Write a power function such that (power m n) returns m raised to the power n, where n is non-negative integer.
; (powerfunction 3 2)
; (powerhelper 3 2)
; (* 3 (powerhelper 3 1))
; (* 3 (* 3 (powerhelper 3 0)))
; (* 3 (* 3 1))
; 9
( define (powerfunction m n)
	(powerhelper m n)
)

( define (powerhelper m n)
	;Recursively multiply m until n == 0 then multiply by 1 (also accounts for base case m^0 = 1)
	(if (= n 0)
	  	1
	  	(* m (powerhelper m (- n 1)))
	)
)

;#2 Write a log function such that (log m q) returns n such that (power m n) returns q.
; (logfunction 3  9)
; (loghelper 3 9)
; (+ (log helper 
( define (logfunction m q)
	(loghelper m q)
)

( define (loghelper m q)
	(if (<= m q)
	 	1	
	 	(+ (loghelper (/ m q) q) 1)
	)

)

;#3 Write a comb function such that (comb n k) returns the number of combinations n-choose-k.
; (comb 3 2)
; (combhelper 3 2)
; (* 3 (combhelper 3 1))
; (* 3 (* 3 1))
; 9
( define (comb n k)
	(combhelper n k)
)

( define (combhelper n k)
	(if (= k 0)
		1
		(* n (combhelper n (- k 1))) 
	)
)

;#4 Write an insertion_sort function such that (insertion_sort L) returns the elements of L rearranged into ascending order.
; => (insertion_sort (25 16 9 5 3 1))
; => (insertionHelper (25) (insertion_sort (16 9 5 3 1)))
; => (insertionHelper (25) (insertionHelper (16) (insertion_sort (9 5 3 1)) ))
; => (insertionHelper (25) (insertionHelper (16) (insertionHelper (9) (insertion_sort (5 3 1)))))
; => (insertionHelper (25) (insertionHelper (16) (insertionHelper (9) (insertionHelper (5) (insertion_sort (3 1))))))
; => (insertionHelper (25) (insertionHelper (16) (insertionHelper (9) (insertionHelper (5) (insertionHelper (3) (insertion_sort (1)))))))
; => (insertionHelper (25) (insertionHelper (16) (insertionHelper (9) (insertionHelper (5) (insertionHelper (3) (insertionHelper (1) (insertion_sort())))))))
; => (insertionHelper (25) (insertionHelper (16) (insertionHelper (9) (insertionHelper (5) (insertionHelper (3) (cons (1) ()))))))
; => (insertionHelper (25) (insertionHelper (16) (insertionHelper (9) (insertionHelper (5) (insertionHelper (3) (cons (1 ())))))))
; => (insertionHelper (25) (insertionHelper (16) (insertionHelper (9) (insertionHelper (5) (cons (1 (cons (3 ())))) )))
; => (insertionHelper (25) (insertionHelper (16) (insertionHelper (9) (cons 1 (cons 3 (cons 5 ())))) )))
; => (insertionHelper (25) (insertionHelper (16) (cons 1 (cons 3 (cons 5 (cons 9 ())))) ))
; => (insertionHelper (25) (cons 1 (cons 3 (cons 5 (cons 9 (cons 16 ())))) ))
; => (cons 1 (cons 3 (cons 5 (cons 9 (cons 16 (cons 25 ())))))) 
; => (1 3 5 9 16 25)

( define (insertion_sort L)
	(if (null? L)
		'()
		;Recursively sort from tail of list to the beginning
		(insertionHelper (car L) (insertion_sort (cdr L)))
	)
)

( define (insertionHelper x L)
	(if (null? L)
		(list x)	
		;y is the beginning of L
		;M is the remaining of L
		(let ((y (car L)) (ys (cdr L)))
			;
			(if (< x y)
				(cons x L)
				(cons y (insertionHelper x ys))
			)
		)

	)
)

;#5 Write a selection_sort function.
; => (selection_sort (3 8 2 6 7))
; => (cons 2 (selection_sort (3 8 6 7))
; => (cons 2 (cons 3 (selection_sort (8 6 7))))
; => (cons 2 (cons 3 (cons 6 (selection_sort (8 7)))))
; => (cons 2 (cons 3 (cons 6 (cons 7 (selection_sort (8))))))
; => (cons 2 (cons 3 (cons 6 (cons 7 (cons 8 (selection_sort ()))))))
; => (cons 2 (cons 3 (cons 6 (cons 7 (cons 8 ())))))
; => (2 3 6 7 8)
( define (selection_sort L)
	(if (null? L)
		'()
		(cons (smallest L (car L)) (selection_sort (ss_remove L (smallest L (car L)))) )
	)
)

;iterates down the list to pick out the smallest element
; (smallest '(2 3 1) 2)
; (smallest '(3 1) 2)
; (smallest '(1) 2)
; (smallest '() 1)
; 1
( define (smallest L A) 
	(if (null? L)
		A
		(if (< (car L) A)
			(smallest (cdr L) (car L))
			(smallest (cdr L) A)
		)
	)
)

;removes the 'A' fro the list
; (ss_remove '(5 3 1) 3)
; (cons 5 (ss_remove '(3 1) 3))
; (cons 5 1)
; '( 5 1)
( define (ss_remove L A)
	(if (null? L)
		'()	
		(if (= (car L) A)
			(cdr L)
			(cons (car L) (ss_remove (cdr L) A))
		)

	)
)

; => (merge_sort '(5 4 3 2 1))
; => (merge (merge_sort (car '('(5 3 1) '(4 2)) ) ) (merge_sort (cadr ('('(5 3 1) '(4 2)) ) )))
; => .
; => ..
; => ...
; #6 write a merge_sort function

( define (merge_sort L)
	(if (null? L)
		'()
		(if (null? (cdr L))
			L
			(merge 
				(merge_sort (car (split L)))
				(merge_sort (cadr (split L)))
			)
		)
		
	)
)

( define (merge L1 L2)
	(if (null? L1)
		L2
		(if (null? L2)
			L1
			(if (< (car L1) (car L2))
				(cons (car L1) (merge (cdr L1) L2))	
				(cons (car L2) (merge (cdr L2) L1))
			)
		)
	)
)

( define (split L)
	(cons (oddIndexes L) (cons (evenIndexes L) '()) )
)

; Resturns the odd indices for a list of numbers
; (oddIndexes '(1 12 6 9))
; (cons 1 (oddIndexes '(6 9)))
; (cons 1 (cons 6 (oddIndexes '())))
; (cons 1 (cons 6 '()))
; '(1 6)
( define (oddIndexes L) 
	(if (null? L)
		'()
		(if (null? (cdr L))
			(list (car L))
			(cons (car L) (oddIndexes (cddr L)))
		)
	)
			
)

; Returns the even indices for a list of numbers
; (evenIndexes '(0 3 16 7 2))
; (cons (3) (evenIndexes '(16 7 2))
; (cons 3 (cons 7 '()))
; '(3 7)
( define (evenIndexes L) 
	(if (null? L)
		'()
		(if (null? (cdr L))
			'()
			(cons (cadr L) (evenIndexes (cddr L)))
		)
	)
			
)

; =>
; #7 write a quick_sort function
; NOTE: Partition is MAX / 2
( define (quick_sort L)
	(cond 
		((null? L)
			'()
		)
		(else
			(let ((pivot (car L)))
				(append 
					(append 
						(quick_sort (part (lambda (x) (< x pivot)) L ))
						(part (lambda (x) (= x pivot)) L)
					)
					(quick_sort (part (lambda (x) (> x pivot)) L))
				)
			)
		)
	)
)

( define (part compare L)
	(cond 
		((null? L)
			'()
		)
		((compare (car L))
			(cons (car L) (part compare (cdr L)))
		)
		(else
			(part compare (cdr L))	
		)
	)
)

;
; #8-11 BST Functions
;

;////////////////////////////////
;/// BST HELPERS ////////////////
;////////////////////////////////
(define (data node) 
	(if (null? node)
		'()
		(if (null? (car node))
			'()
			(car node)
		)
	)
)

(define (left node)
	(if (null? node)
		'()
		(if (null? (cadr node))
			'()
			(cadr node)
		)
	)
)

(define (right node)
	(if (null? node)
		'()
		(if (null? (caddr node))
			'()
			(caddr node)
		)
	)
)

; (maketree '(3 2 1))
; (insert (car '(3 2 1)) (maketree (cdr '(3 2 1))) )
; 
( define (maketree L)
	(if (null? L)
		'()
		(let ((T (maketree (fold-right cons '() (cdr L))) ))
			(insert (car L) T)
		)
	)
)

( define (insert x T)
	(if (null? T)
		(list x '() '())
		(if (null? (data T))
			x
			(if (= (data T) x)
				(list (data T) (constree (left T)) (constree (right T)))
				(if (< (data T) x)
					(list (data T) (constree (left T)) (insert x (right T)))
					(list (data T) (insert x (left T)) (constree (right T)))
				)	
			)
		)
	)
)

( define (constree T)
	(if (null? T)
		'()
		(if (null? (left T))
			(if (null? (right T))
				(list (data T) '() '())
				(list (data T) '() (constree (right T)))
				
			)
			(if (null? (right T))
				(list (data T) (constree (left T)) '())	
				(list (data T) (constree (left T)) (constree (right T)))
			)
		)
	)
)

( define (member? x T) 
	(if (null? T)
		#f
		(if (eqv? (data T) x)
			#t
			(if (< (data T) x)
				(member? x (right T))
				(member? x (left T))
			)
		)
	)
)

( define (removeNode x T)
	(if (null? T)
		'()
		(if (null? (data T))
			'()
			(if (= (data T) x)
				(if (null? (left T))
					(if (null? (right T))
						'()
						(list (data (right T)) '() (removeNode (data (right T)) (right T)))
					)
					(if (null? (right T))
						(list (data (left T)) (removeNode (data (left T)) (left T)) '())
						(list (data (left T)) (removeNode (data (left T)) (left T)) (constree (right T)))
					)
				)
				(if (< (data T) x)
					(list (data T) (constree (left T)) (removeNode x (right T)))
					(list (data T) (removeNode x (left T)) (constree (right T)))
				)	
			)
		)
	)
)

;left root right
( define (inorder T)
	(if (null? T)
		T
		(append (append (inorder (left T)) (list (data T))) (inorder (right T)))
	)
)

;root left right
( define (preorder T)
	(if (null? T)
		T
		(append (append (list (data T)) (preorder (left T))) (preorder (right T)))
	)
)

;left right root
( define (postorder T)
	(if (null? T)
		T
		(append (append (postorder (left T)) (postorder (right T))) (list (data T)))
	)
)


;////////////////////////////////
;/// BST VARS ///////////////////
;////////////////////////////////
( define smalltree (maketree l2))
( define largetree (maketree l4))

; #12 filter for (filter P L)
; P = predicate evaluator (lambda (x) (> x 0))
; L = list to be applied to 
( define (filterFunc P L)
	(if (null? L)
		'()
		(if (P (car L))
			(cons (car L) (filterFunc P (cdr L)))
			(filterFunc P (cdr L))
		)
	)
)

; #13 reject for (reject P L)
; P = predicate evaluator (lambda (x) (> x 0))
; L = list to be applied to 
( define (reject P L)
	(if (null? L)
		'()
		(if (P (car L))
			(reject P (cdr L))
			(cons (car L) (reject P (cdr L)))
		)	
	)
)

; #14 applyeach for (applyeach L1 L2) 
; applies each function in L1 to the corresponding value in L2
( define (applyeach L1 L2)
	(applyeachHelper L1 L2 '())
)

( define (applyeachHelper L1 L2 LRet)
	(if (null? L1)
		LRet
		(applyeachHelper 
			(cdr L1) 
			(cdr L2) 
			(append LRet (list ((car L1) (car L2)))))
	)
)
