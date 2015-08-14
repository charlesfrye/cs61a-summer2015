
(define (deep-map fn s)
  (cond 
  	((null? s) ())
  	((list? (car s)) (cons (deep-map fn (car s)) (deep-map fn (cdr s))))
  	(else (cons (fn (car s)) (deep-map fn (cdr s)))) 
  )
)


(define (substitute s old new)
  (define (elemsub word) (cond ((= word old) new) (else word)))
  (deep-map elemsub s)
)

(define (sub-all s olds news)
)