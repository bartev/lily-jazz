\version "2.18.0"

myFunction = { c2 }

\relative c' {
  c4 \myFunction c
}#

mySchemeFunction =
#(define-music-function (parser location)()
   #{
     c2
   #})

\relative c' {
  c4 \mySchemeFunction c
}


