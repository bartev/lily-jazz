\version "2.24.0"

dyn = #(define-event-function 
    (arg)
    (markup?)
    (make-dynamic-script arg))

\relative c' { 
  c\dyn pfsss d\dyn abcd c-\dyn pf
}
