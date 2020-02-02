\version "2.18.2"

% https://lilypondblog.org/2014/04/music-functions-4-recursion/

% Urs Liska blog



% Generic Scheme function

#(define (display-names my-names-list)
   (if
    ;; check if there still is a list element left
    (null? my-names-list)
      ;; no: we're at the end of the recursion
      ;; simply issue a new line and exit
      (newline)
      ;; yes: we still have elements to process
      ;; begin a compound expression
      (begin
       ;; display the first element and insert a new line
       (display (car my-names-list))
       (newline)
       ;; recursively call the function
       ;; with the rest of the list
       (display-names (cdr my-names-list))) ;; end of begin
      ) ;; end of the if expression
   )

#(display-names '(Notehead Slur Flag Beam))


colorGrob =
#(define-music-function (parser location my-grob my-color)
   (symbol? color?)
   #{
       \temporary \override #my-grob #'color = #my-color
   #})


uncolorGrob =
#(define-music-function (parser location my-grob)
   (symbol?)
   #{
     \revert #my-grob #'color
   #})


colorGrobs =
#(define-music-function (parser location my-grob-list my-color)
   (symbol-list? color?)
   (if (null? my-grob-list)
       ;; issue an empty music expression
       #{ #}
       #{
         % color the first grob type of the current list
         \colorGrob #(car my-grob-list) #my-color
         % recursively call itself with the remainder
         % of the current list.
         \colorGrobs #(cdr my-grob-list) #my-color
       #}))

uncolorGrobs =
#(define-music-function (parser location my-grob-list)
   (symbol-list?)
   (if (null? my-grob-list)
       ;; issue an empty music expression
       #{ #}
       #{
         \uncolorGrob #(car my-grob-list)
         \uncolorGrobs #(cdr my-grob-list)
       #}))

grobs = #'(NoteHead
                      ;; Stem
                      ;; Flag
                      ;; Beam
                      Rest
                      Slur
                      PhrasingSlur
                      Tie
                      Script
                      Dots
                      DynamicText
                      Accidental)
colorMusic =
#(define-music-function (parser location my-color music)
   (color? ly:music?)
   #{
     \colorGrobs \grobs  #my-color

     #music

     \uncolorGrobs \grobs
   #})

music = \relative c' {
  c4. d8 e16 d r cis( d4) ~ | d1 \fermata
}

\relative c' {
  \colorMusic #blue \music
  \colorMusic #red { c4 c } d \colorMusic #green e\f
  \colorMusic #magenta \music
}



% Print all grob descriptions
% print list to console
#(map
  (lambda (gd) (display (car gd)) (newline))  
    all-grob-descriptions)

allGrobNames = #(map car all-grob-descriptions)


% From the comments

simpleColorMusic =
#(let ((grob-names (map car all-grob-descriptions)))
      (define-music-function (parser location my-color music)
        (color? ly:music?)
        #{
          \colorGrobs #grob-names #my-color
          #music
          \uncolorGrobs #grob-names
        #}))


\relative c' {
  \simpleColorMusic #green \music
  \simpleColorMusic #blue { c4 c } d 
  \simpleColorMusic #red e\f
  \simpleColorMusic #black \music
}
