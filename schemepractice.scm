;\\
;Variables
;\\
( define L (cons 5 (cons 4 (cons 3 ()))) )
( define L2 (append (map square L) L ))


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
( define (selection_sort L)
	(if (null? L)
		'()
		(cons (smallest L (car L)) (selection_sort (ss_remove L (smallest L (car L)))) )

