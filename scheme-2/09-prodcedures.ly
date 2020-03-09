\version "2.20.0"

% https://github.com/uliska/scheme-book/blob/master/scheme/procedures/lambda.md

% (lambda <formals> <expressions>)

#((lambda (x) (+ x x)) 9)

#((lambda (x y)
  (newline)
  (display (format "X: ~a\n" x))
  (display (format "Y: ~a\n" y))
  (display (+ x y))) 7 9)

% alternate lambda form - varying list of arguments
% (lambda <var> <exp1> <exp2> ...)

#((lambda var-list
    (newline)
    (display "var-list lambda\n")
    (display (car var-list))
    (newline)
    (display (length var-list)))
 'one 'two 'three 'four)

% hybrid lambda form
% (lambda (<var-1> ... <var-n> . <var-last>) <exp1> <exp2> ...)
#((lambda (x y . z)
          (newline)
          (display "alternate form\n")
          (display "(1 + 2) * 4\n")
          (display (* (+ x y)
          (length z))))
    1 2 3 4 5 6)

% bind lambda to a name 
#(define my-proc-lambda
  (lambda (x y) (+ x y)))

% more common
#(define (my-proc x y)
  (+ x y))

% Long and shorthand
% <var-0> is the procedure's name

% simple lambda
% (define <var-0> (lambda (<var-1> ... <var-n>) <exp1> ...))
% (define (<var-0> <var-1> ... <var-n>) <exp1> ...)

% Alternate lambda (arbitrary list of arguments)
% (define <var-0> (lambda <var-1> <exp1> ...))
% (define (<var-0> . <var-1>) <exp1> ...)

% hybrid form
% (define <var-0> (lambda <var-1> ... <var-n> . <var-rest>) <exp1-> ...)
% (define (<var-0> <var-1> ... <var-n> . <var-rest>) <exp1> ...)


#(define damp-color 
   (lambda (color damping) 
     (let ((damp-element (lambda (elem) (/ (elem color) damping))))
       (list (damp-element first) 
             (damp-element second) 
             (damp-element third)))))

{ c' 
  \override NoteHead.color = #(damp-color red 1) d' 
  \override NoteHead.color = #(damp-color red 1.25) d' 
  \override NoteHead.color = #(damp-color red 1.5) d' 
  \override NoteHead.color = #(damp-color red 1.75) d' 
  \override NoteHead.color = #(damp-color red 2) d' 
  \override NoteHead.color = #(damp-color red 3) d' 
  \override NoteHead.color = #(damp-color red 4) d' 
  \override NoteHead.color = #(damp-color green 2) e' }

% Predicates

% Check for positive integer

#(define (positive-integer? x)
    (and (integer? x)
         (> x 0)))

#(define (reddish? col)
    (and (color? col)
         (>= (first col) 
             (+ (second col) (third col)))))

#(newline)
#(display (reddish? red))
#(newline)
#(display (reddish? blue))
#(newline)
#(display (reddish? green))#(newline)

% Custom predicate
#(define (list-or-color-or-symbol? x) 
         (or (list? x) 
             (color? x) 
             (symbol? x))) 

#(define (mode? x) 
         (and (symbol? x) 
              (or (eq? x 'major) 
                  (eq? x 'minor)))) 

#(define (alist-with-color? x) 
    (and (list? x) 
         (every pair? x) 
         (assq 'color x)))

#(display (alist-with-color? '((amount . 5) (color . red))))

% Return #t or #f
#(define (alist-with-color-tf? x) 
    (and (list? x) 
         (every pair? x) 
         (if (assq 'color x) #t #f)))

#(newline)
#(display (alist-with-color-tf? '((amount . 5) (color . red))))

% Handle different parameter data types
#(define (double x) 
    (cond ((number? x) (+ x x)) 
          ((string? x) "not implemented yet") 
          (else "'double' needs a number or a string as parameter")))

#(define (double x) 
    (cond ((number? x) (+ x x)) 
          ((string? x) (let ((num (string->number x))) 
                            (if num 
                                (number->string (+ num num)) 
                                (string-append x x)))) 
          (else "'double' needs a number or a string as parameter")))

#(newline) 
#(display (double 3)) 
#(newline) 
#(display (double "3")) 
#(newline) 
#(display (double "AB ")) 
#(newline) 
#(display (double '(2 . 3)))
