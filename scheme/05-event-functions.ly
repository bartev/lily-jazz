\version "2.18.2"

dyn = #(define-event-function 
    (parser location arg)
    (markup?)
    (make-dynamic-script arg))

\relative c' { 
  c\dyn pfsss d\dyn "abcd" c-\dyn fff
}
