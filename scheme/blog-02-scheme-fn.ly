\version "2.24.0"

myFunction = { c2 }

\relative c' {
  c4 \myFunction c
}

mySchemeFunction =
#(define-music-function ()()
   #{
     c2
   #})

\relative c' {
  c4 \mySchemeFunction c
}


