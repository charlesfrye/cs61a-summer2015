(define (cube x)
  (* x x x)
)

(define (over-or-under x y)
  (if (< x y)
  	'-1
  	(if (> x y)
  		'1
  		'0
  	)
  )
)

(define (integerIs x)
	(cond 
		((and (> x 0) (= (modulo x 2) 0)) 'positive-even)
		((and (> x 0) (= (modulo x 2) 1)) 'positive-odd)
		
		((= x 0) 'zero)

		((and (< x 0) (= (modulo x 2) 0)) 'negative-even)
		((and (< x 0) (= (modulo x 2) 1)) 'negative-odd)

	)
)

(define (make-adder num)
  (lambda (x)
  	(+ x num)
  )
)

(define structure
  (cons (cons 1 nil) 
  	(cons 2 
  		(cons (cons 3 4) 
  			(cons 5 nil))))
)

(define (remove item lst)
  (cond ((null? lst) '())
  	((equal? item (car lst)) (remove item (cdr lst)))
  	(else (cons (car lst) (remove item (cdr lst))))
  	)
)

