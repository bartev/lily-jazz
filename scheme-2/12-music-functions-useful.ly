\version "2.20.0"

makeRedNote = #(define-music-function () ()
            #{ \once \override NoteHead.color = #red
               \once \override Stem.color = #red
            #})

\relative c' { c4 \makeRedNote c c c }


colorNote = #(define-music-function (col) 
            (color?)
            #{ \once \override NoteHead.color = #col
               \once \override Stem.color = #col
            #})

\relative c' { c4 \colorNote #blue c 
             \colorNote #green c
             \colorNote #'(0.5 0.5 0) c 
             \colorNote #'(0.2 0.7 0) c 
             #(colorNote red) c}


% Pass a music element

noOp = #(define-music-function (mus)
       (ly:music?)
       mus )

\noOp \relative c' {c4 \noOp d8 c e}

colorMusic = #(define-music-function (col mus)
           (color? ly:music?)
           #{ \temporary \override NoteHead.color = #col
           
           #mus
           \revert NoteHead.color
           #})

myMusic = \relative c' {c4. d8 e16 d r cis ( d4) ~ | d1 \fermata }

\relative c' { #(colorMusic blue myMusic) \myMusic 
               #(colorMusic red myMusic) \myMusic}

% refactor step 1
colorGrob = #(define-music-function (grob col) 
          (symbol? color?) 
          #{ \temporary \override #grob #'color = #col #})

unColorGrob = #(define-music-function (grob)
            (symbol?)
            #{ \revert #grob #'color #})

colorMusic_ii = #(define-music-function (col music)
              (color? ly:music?)
              #{ \colorGrob NoteHead #col
                 #music
                 \unColorGrob NoteHead #})

\relative c' { \colorMusic_ii #blue \myMusic
               \colorMusic_ii #red \myMusic
               \myMusic }

grobList = #'(NoteHead
              Stem
              Flag
              Beam
              Rest
              Slur
              PhrasingSlur
              Tie
              Script
              Dots
              DynamicText
              Accidental)

#(define (wrap-music-list music-list)
         (let ((out #{ {} #}))
         (ly:music-set-property! out 'elements music-list)
         out))

colorGrobs = #(define-music-function (grobs col)
           (symbol-list? color?)
           #{
           #})

\colorGrobs #grobList #red