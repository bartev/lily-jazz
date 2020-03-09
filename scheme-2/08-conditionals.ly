\version "2.20.0"

% https://github.com/uliska/scheme-book/blob/master/SUMMARY.md

% Key words
% if
% cond
% case

% logical expressions
% and
% or
% not

% (if test consequent alternative)
% True values
% -- every object except #f is considered a "true value"

#(display 
   (let* ((rand (random 100)) 
          (state (if (even? rand) "even" "odd"))) 
          (format "The random number ~a is ~a" rand state)))

#(newline)
#(display "step 1")
#(newline)
#(display 
   (let ((rand (random 100))) 
        (cond 
              ((> 50 rand) 
               (display rand) 
               (newline) 
               "Random number is greater than 50") 
              ((< 50 rand) 
               (display rand) 
               (newline) 
               "Random number is smaller than 50") 
              (else 
               (display rand) 
               (newline) 
               "Random number equals 50"))))

#(newline)
#(display "step 2")
#(newline)
colors = #`((col-red . ,red) 
            (col-blue . ,blue) 
            (col-yellow . ,yellow))

#(newline)
#(display "step 3")
#(newline)
#(display 
   (cond ((assq 'col-lime colors)) 
         ((assq 'col-darkblue colors)) 
         ((assq 'col-red colors)) 
         (else `(col-black . ,black))))

#(newline)
#(display "step 4")
#(newline)
#(display colors)



#(newline)
#(display "test => proc")
#(newline)
#(display (cond 
                ((assq 'col-lime colors) => cdr) 
                ((assq 'col-darkblue colors) => cdr) 
                ((assq 'col-red colors) => cdr) 
                (else black)))


