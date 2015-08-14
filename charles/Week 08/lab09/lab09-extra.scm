(define (composed f g)
  (lambda (x) (f (g x)))
)

(define (max a b) (if (> a b) a b))
(define (min a b) (if (> a b) b a))
(define (gcd a b)
	(if (not (or (= a 0) (= b 0)))
	  (if (= (modulo (max a b) (min a b)) 0)
	  	(min a b)
	  	(gcd (min a b) (modulo (max a b) (min a b)))
	  )
	  (max a b)
	)
)

(define (filter f lst)
	(if (null? lst)
	  lst
	  (if (f (car lst)) 
	  	(cons (car lst) (filter f (cdr lst)))
	  	(filter f (cdr lst))
	  )
	)
)

(define (all-satisfies lst pred)
	(= (length lst) (length (filter pred lst)))
)

(define (accumulate combiner start n term)
  (if (= n 0)
      start
      (combiner (term n) 
      	(accumulate combiner start (- n 1) term)
      ))

