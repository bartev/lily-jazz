\version "2.24.0"

% define-music-function <argument-list> <argument-predicates> <body>

addPalindrome = #(define-scheme-function (my-string)
              (string?)
              (ly:message "Add th reverse of the string to itself")
              (string-append (string-titlecase my-string) 
                             " " 
                             (string-reverse (string-upcase my-string))))

\header {
        title = \addPalindrome "bartev"
        }

{ c' }


% https://github.com/uliska/scheme-book/blob/master/old-stuff/functions/01.md

myFunction = { c2 }
\relative c' { c4 \myFunction c }

mySchemefunction = #(define-music-function () () #{ c2 #} )
\relative c' { c4 \mySchemefunction c }



