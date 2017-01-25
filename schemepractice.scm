;\\
;Variables
;\\
( define (randomList x)

	(if (= x 0)
		'()
		(cons (random x) (randomList (- x 1)))
	)
)

( define (printEvens L)
	(if (null? L)
		'()	
		(if (= 0 (modulo (car L) 2))
			(cons (car L) (printEvens (cdr L)) )
			(printEvens (cdr L))
		)
	)
)

( define (printOdds L)
	(if (null? L)
		'()
		(if (= 0 (modulo (car L) 2))
			(printOdds (cdr L))	
			(cons (car L) (printOdds (cdr L)) )
		)
	)

)

( define (maxList L)
	(apply max L)
)

( define L (cons 5 (cons 4 (cons 3 ()))) )
( define L2 (append (map square L) L ))
( define L3 (append (map square L2) L2 ))
( define L4 (randomList 100))

;\\Problems
;#1 Write a power function such that (power m n) returns m raised to the power n, where n is non-negative integer.
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

( define (oddIndexes L) 
	(if (null? L)
		'()
		(if (null? (cdr L))
			(list (car L))
			(cons (car L) (oddIndexes (cddr L)))
		)
	)
			
)

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

