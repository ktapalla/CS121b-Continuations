# README - COSI 121b Continuations PS

The code provided in this repository contains the solutions to the Continuations Problem Set for COSI 121b - Structure and Interpretations of Computer Programs. A general description of the assignment and its relevant problems will be provided below. 

## Installation and Execution 

Get the files from GitHub and in your terminal/console move into the folder of the project. Run the following line to open the program in DrRacket: 

``` bash 
drracket continuations.rkt 
```

This will open up your DrRacket application where you will be able to run the program. Click the button labeled "Run" at the top right of the DrRacket Application window, which will allow the user to type the appropriate commands on the REPL.

Note: The instructions above assume that the user already has Racket and DrRacket installed on their device and the executable command of ``` drracket ``` added to their ``` $PATH ``` as an executable command. If the user does not have this done already, they can follow the steps at the following link to do so: 

https://docs.racket-lang.org/pollen/Installation.html 

Following the first four bullets under the section '1.2 Installation' will be enough. 

If the user would rather not open the program through the terminal, then they can also just make sure that they have DrRacket installed and open the ``` continuations.rtk ``` file on the application directly. 


## Assignment Instructions 

This assignment focuses on explicit continuation, which involves adding a parameter that is a one-argument function that says what to do with the answer.  

Your solutions should observe the following conditions: 

1. All of your calls of your code with explicit continuations should be tail recursive, meaning no work builds up outside of the recursive call. Do not make your code recursive by adding an accumulator for the answer. 
2. If you call one of these procedures from another one of your procedures- including a recursive call in a procedure- you cannot (except at the very top level, when you call the procedure from the ```read-eval-print ``` loop of an evaluation) use the continuation ``` (define (I v) v) ```. 

Notice that ``` (factorial n) ``` evaluates the same thing as ``` (Factorial n I) ```, so this work-around would be computationally cheating. On the other hand, Scheme primitives ``` car ```, ``` cdr ```, ``` cons ```, and ``` + - * / ``` are all called "as usual" without a continuation. 
3. You should rewrite each procedure with essentially the same control structure- do not rewrite the procedure with your own hame-grown algorithm. 
4. Here are some procedures you are allowed to call without a continuation: 
* ``` (define (I v) v) ``` 
* ``` (define (square n) (* n n)) ``` 
* ``` (define (double n) (* 2 n)) ``` 

### Problems to Code 

Code the following procedures as their equivalent procedure, but with explicit continuation (the new explicit continuation versions of the procedures below will have the first character of the original method as an uppercase letter in its name): 

1. **member? -> Member?**: 
``` 
(define (member? x L) 
    (if (null? L) 
        #f 
        (if (equal? x (car L))
            #t 
            (member? x (cdr L))))) 
``` 

2. **fastexp -> Fastexp**: 
``` 
(define (fastexp b e) 
    (if (= e 0)
        1 
        (if (even? e)
            (square (fastexp b (/ e 2)))
            (* b (fastexp b (- e 1)))))) 
``` 

3. **fastmult -> Fastmult**: 
``` 
(define (fastmult m n)
    (if (= n 0) 
        0 
        (if (even? n)
            (double (fastmult m (/ n 2)))
            (+ m (fastmult m (- n 1)))))) 
``` 

4. **map -> Map**: 
``` 
(define (map f L)
    (if (null? L) 
        '()
        (cons (f (car L)) (map f (cdr L))))) 
``` 

5. **filter -> Filter**: 
``` 
(define (filter pred L) 
    (if (null? L) 
        '() 
        (if (pred (car L)) 
            (cons (car L) (filter pred (cdr L))) 
            (filter pred (cdr L))))) 
``` 

6. **tack -> Tack**: 
``` 
(define (tack x L) 
    (if (null? L) 
        (cons x '()) 
        (cons (car L) (tack x (cdr L))))) 
``` 

7. **reverse -> Reverse**: 
``` 
(define (reverse L) 
    (if (null? L) 
        '() 
        (tack (car L) (reverse (cdr L))))) 
```

8. **append -> Append**: 
``` 
(define (append S T) 
    (if (null? S) 
        T 
        (cons (car S) (append (cdr S) T)))) 
``` 

9. **fib -> Fib**: 
``` 
(define (fib n) 
    (if (< n 2) 
        n 
        (+ (fib (- n 1)) (fib (- n 2))))) 
``` 

10. **fringe -> Fringe**: 
``` 
(define (fringe S) 
    (if (null? S) 
        '() 
        (if (number? S) 
            (list S) 
            (append (fringe (car S)) (fringe (cdr S)))))) 
``` 

11. **tag -> Tag**: 
``` 
(define (tag x L) 
    (if (null? L) 
        '() 
        (cons (cons x (car L)) (tag x (cdr L))))) 
``` 

12. Procedure ``` powerset ``` takes a list of length n, returning one of length 2^n^, containing all the possible sublists of its input, in order, keeping or removing each element. It is the list equivalent of the powerset operation for sets. Remember, if ``` powerset ``` calls ``` tag ``` and ``` append ```, then ``` Powerset ``` calls ``` Tag ``` and ``` Append ```- the same applies for the other following solutions (see *Condition 4* in the **Assignment Instructions** section above). 

**powerset -> Powerset**: 
``` 
(define (powerset S) 
    (if (null? S) 
        '(())
        ((lambda (T) (append (tag (car S) T) T)) 
        (powerset (cdr S))))) 
``` 

13. Procedure ``` cross ``` codes cross products of pairs of elements, one each from its two inputs. 

**cross -> Cross**: 
``` 
(define (cross S T) 
    (if (null? S) 
        '() 
        (append (tag (car S) T) 
            (cross (cdr S) T)))) 
``` 

14. **largers -> Largers**: 
``` 
(define (largers x L) 
    (filter (lambda (n) (>= n x)) L)) 
``` 

15. **smallers -> Smallers**: 
``` 
(define (smallers x L) 
    (filter (lambda (n) (< n x)) L)) 
``` 

16. **quicksort -> Quicksort**: 
``` 
(define (quicksort F) 
    (if (null? F) 
        '() 
        (append (quicksort (smallers (car F) (cdr F))) 
            (cons (car F) 
                (quicksort (largers (car F) (cdr F))))))) 
``` 