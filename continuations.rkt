#lang racket
; Factorial Example for Reference
(define (Factorial n k)
  (if (= n 0)
      (k 1)
      (Factorial (- n 1)
                 (lambda (v) (k (* n v))))))

(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))


; Helper Code
(define (I v) v)
(define (square n) (* n n))
(define (double n) (* 2 n))


; HW Problems

; member
(define (member? x L)
  (if (null? L)
      #f
      (if (equal? x (car L))
          #t
          (member? x (cdr L)))))

(define (Member? x L k)
  (if (null? L)
      (k #f)
      (if (equal? x (car L))
          (k #t)
          (Member? x (cdr L)
                   (lambda (v) (k v))))))


; fastexp
(define (fastexp b e)
  (if (= e 0)
      1
      (if (even? e)
          (square (fastexp b (/ e 2)))
          (* b (fastexp b (- e 1))))))

(define (Fastexp b e k)
  (if (= e 0)
      (k 1)
      (if (even? e)
          (square (Fastexp b (/ e 2) k))
          (Fastexp b (- e 1) (lambda (v) (k (* b v)))))))


; fastmult
(define (fastmult m n)
  (if (= n 0)
      0
      (if (even? n)
          (double (fastmult m (/ n 2)))
          (+ m (fastmult m (- n 1))))))

(define (Fastmult m n k)
  (if (= n 0)
      (k 0)
      (if (even? n)
          (Fastmult m (/ n 2) (lambda (v) (k (double v))))
          (Fastmult m (- n 1) (lambda (v) (k (+ m v)))))))


; map
(define (map f L)
  (if (null? L)
      '()
      (cons (f (car L)) (map f (cdr L)))))

(define (Map f L k)
  (if (null? L)
      (k '())
      (Map f (cdr L) (lambda (v) (k (cons (f (car L)) v))))))


; filter
(define (filter pred L)
  (if (null? L)
      '()
      (if (pred (car L))
          (cons (car L) (filter pred (cdr L)))
          (filter pred (cdr L)))))

(define (Filter pred L k)
  (if (null? L)
      (k '())
      (if (pred (car L))
          (Filter pred (cdr L) (lambda (v) (k (cons (car L) v))))
          (Filter pred (cdr L) (lambda (v) (k v))))))


; tack
(define (tack x L)
  (if (null? L)
      (cons x '())
      (cons (car L) (tack x (cdr L)))))

(define (Tack x L k)
  (if (null? L)
      (k (cons x '()))
      (Tack x (cdr L) (lambda (v) (k (cons (car L) v))))))


; reverse
(define (reverse L)
  (if (null? L)
      '()
      (tack (car L) (reverse (cdr L)))))

(define (Reverse L k)
  (if (null? L)
      (k '())
      (Reverse (cdr L) (lambda (v) (k (tack (car L) v))))))


; append 
(define (append S T)
  (if (null? S)
      T
      (cons (car S) (append (cdr S) T))))

(define (Append S T k)
  (if (null? S)
      (k T)
      (Append (cdr S) T (lambda (v) (k (cons (car S) v))))))


; fib
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

(define (Fib n k)
  (if (< n 2)
      (k n)
      (Fib (- n 2) (lambda (v) (Fib (- n 1) (lambda (w) (k (+ w v))))))))


; fringe
(define (fringe S)
  (if (null? S)
      '()
      (if (number? S)
          (list S)
          (append (fringe (car S)) (fringe (cdr S))))))

(define (Fringe S k)
  (if (null? S)
      (k '())
      (if (number? S)
          (k (list S)) 
          (Fringe (car S) (lambda (v) (Fringe (cdr S) (lambda (w) (k (Append v w I)))))))))


; tag
(define (tag x L)
  (if (null? L)
      '()
      (cons (cons x (car L)) (tag x (cdr L)))))

(define (Tag x L k)
  (if (null? L)
      (k '())
      (Tag x (cdr L) (lambda (v) (k (cons (cons x (car L)) v))))))


; powerset
(define (powerset S)
  (if (null? S)
      '(())
      ((lambda (T) (append (tag (car S) T) T))
       (powerset (cdr S)))))

(define (Powerset S k)
  (if (null? S)
      (k '(()))
      (Powerset (cdr S)
                (lambda (v)
                  (Tag (car S) v
                       (lambda (w)
                         (Append w v k)))))))


; cross
(define (cross S T)
  (if (null? S)
      '()
      (append (tag (car S) T)
              (cross (cdr S) T))))

(define (Cross S T k)
  (if (null? S)
      (k '())
      (Cross (cdr S) T
             (lambda (v)
               (Tag (car S) T
                    (lambda (w)
                      (Append w v k)))))))


; largers
(define (largers x L)
  (filter (lambda (n) (>= n x)) L))

(define (Largers x L k)
  (Filter (lambda (n) (>= n x)) L k))


; smallers
(define (smallers x L)
  (filter (lambda (n) (< n x)) L))

(define (Smallers x L k)
  (Filter (lambda (n) (< n x)) L k))


; quicksort
(define (quicksort F)
  (if (null? F)
      '()
      (append (quicksort (smallers (car F) (cdr F)))
              (cons (car F)
                    (quicksort (largers (car F) (cdr F)))))))

(define (Quicksort F k)
  (if (null? F)
      (k '())
      (Smallers (car F) (cdr F)
                (lambda (v)
                  (Largers (car F) (cdr F)
                           (lambda (w)
                             (Append (Quicksort v k)
                                     (cons (car F) (Quicksort w k)) 
                                     k)))))))




