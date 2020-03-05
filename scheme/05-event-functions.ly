\version "2.20.0"

dyn = #(define-event-function 
    (arg)
    (markup?)
    (make-dynamic-script arg))

\relative c' { 
  c\dyn pfsss d\dyn "abcd" c-\dyn fff
}
